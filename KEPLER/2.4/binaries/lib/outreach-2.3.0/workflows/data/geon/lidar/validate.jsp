<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Thread" %>
<%@ page import="java.net.*" %>
<%@ page import="org.geon.LidarUtilities" %>

<jsp:useBean
    id="myRandomNumber"
    scope="application"
    class="java.util.Random" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 //EN">

<html>
<head>
<title>Lidar response</title>
</head>
<body>
<body bgcolor="#FFFFFF">
<%
System.out.println("inside validate");

        String MinX = request.getParameter("MinX");
        String MaxX = request.getParameter("MaxX");
        String MinY = request.getParameter("MinY");
        String MaxY = request.getParameter("MaxY");

	String srid = request.getParameter("srid");
	System.out.println("inside validate.. srid = " + srid);

        String[] classification = request.getParameterValues("classification");

	String configFile = application.getRealPath("/WEB-INF/persistence/lidar.properties");
	System.out.println("from validate: configFile = " + configFile);
	
	StringBuffer threadResp = new StringBuffer();
	LidarUtilities lutil = new LidarUtilities(threadResp,"","",srid);
	boolean propSet = lutil.setProperties(configFile);
	if (!propSet) {
	    System.out.println(threadResp.toString());
	    out.print("<br><font color=\"red\"><B>Error!</B> Unable to connect to or query the LiDAR database.</font>");
	    return;
	}
	
	long numRows = lutil.calculateNumRows(MinX, MinY, MaxX, MaxY, classification, "0");
	System.out.println("RESULT FROM VALIDATE: " + numRows + "rows.");
%>
<script language='Javascript'>
parent.document.selectForm.numRows.value=<%= numRows %>;
</script>
<%
	if (numRows == -1) {
		System.out.println(threadResp.toString());
		out.print("<br><font color=\"red\"><B>Error!</B> Unable to connect to or query the LiDAR database.</font>");
	} else if (numRows == 0) {
		out.print("<br>Query returns no points.");
	} else if (numRows < 1600000) {
		long time = lutil.estimateTime(numRows);
		System.out.println("processing of " + numRows + " points is about " + time + " seconds."); 
		out.print("<br>" + numRows + " points.  Estimated processing time is " + time + " seconds (based on system average load).");
        } else if (numRows > 20000000) {
                 out.print("<font color=\"red\">Warning, Query returns more than 20 million points and cannot be processed. Please select a different bounding box or classification attributes.</font>");
	} else {
		 out.print("<font color=\"red\">Warning, Query returns more than 1.6 million points. Currently interpolation of points to an elevation product is limited to 1.6 million points so we are unable to process this request. Please select a different bounding box or classification attributes. If you'd like to download the point cloud data for this selection, choose only the \"download raw data\" option below and submit your request.</font>");
	}
%>
</body>
</html>

