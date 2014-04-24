<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.geon.LidarWorkflowExecute" %>

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
<TABLE>
<TR>
<TD><A HREF="http://activetectonics.la.asu.edu/GEONatASU/index.htm" target="_new"><IMG border="0" SRC="http://agassiz.la.asu.edu/logos/GEONASUWebBanner.jpg" alt="GEON at ASU homepage"></A></TD>
<TD><a href="http://www.sdsc.edu" target="_new"><img border="0" src="http://www.sdsc.edu/logos/SDSClogo-plusname-red.gif" alt="San Diego Supercomputer Center" height="60" width="216"></a></TD>
</TR>
</TABLE>
<table cellpadding=2>

<% //     java.util.Enumeration paramNames = request.getParameterNames();
// get the parameter names %>

<%
String appPath = pageContext.getServletContext().getRealPath("/");
%>
<tr><td>
<%//System.out.println("application path ==> " + appPath + "\n"); %> </td></tr>

<%
	String numRows = request.getParameter("numRows");
System.out.println("numRows ==> " + numRows);
System.out.println("\n\ninside ty");
System.out.println("client ip: " + request.getRemoteAddr());  
	String email = request.getParameter("email");
	System.out.println("email ==> " + email);
	// get parameters.
//System.out.println(new Date().toString());
	String uniqueId = "" + new Date().getTime() + Math.abs(myRandomNumber.nextInt());
System.out.println("uniqueId ==> " + uniqueId + "\n"); 

	String requestParams = "id=" + uniqueId;

	String rawdata = request.getParameter("rawdata");
	if (rawdata == null) 
		rawdata = "0";
	requestParams += "&rawdata=" + rawdata;

	String download = "0";

	// Read processing parameters.
	StringBuffer sb = new StringBuffer();

        String algs[] = {"elev","slope","aspect","pcurv"};
       	String formats[] = {"view","arc","ascii","tiff"};
                                                                                                           
       	for (int i=0; i<4; i++) {
       		for (int j=0; j<4; j++) {
               		String type = algs[i]+formats[j];
                        String typeVal = request.getParameter(type);
			if (typeVal == null) 
				typeVal = "";
			requestParams += "&" + type + "=" + typeVal;
//			System.out.println(type+"="+typeVal);
                        if (typeVal != null && typeVal.equals("1") && j>0) {
       	                        download = "1";
               	        }
               	}
        }
                                                                                                           
	// check whether any processing was selected.
	if (rawdata.equals("0") && download.equals("0")) {
		System.out.println("no processing algorithm was selected!");
		out.print("<tr><td><h2>Error!<h2></td></tr>"); 
		out.print("<tr><td>No processing was selected!</td></tr>");		
		return;
	}

	String MinX = request.getParameter("MinX");
	String MaxX = request.getParameter("MaxX");
	String MinY = request.getParameter("MinY");
	String MaxY = request.getParameter("MaxY");
//System.out.println("MinX ==> " + MinX + "\n"); 
//System.out.println("MinY ==> " + MinY + "\n"); 
//System.out.println("MaxX ==> " + MaxX + "\n"); 
//System.out.println("MaxY ==> " + MaxY + "\n"); 

	// also check whether they values contain letters - TODO!
	if (MinX.equals("0") && MinY.equals("0") && MaxX.equals("0") && MaxY.equals("0")) {
		out.print("<tr><td><h2>Error!<h2></td></tr>"); 
		out.print("<tr><td>Invalid bounding box selection: MinX = " + MinX + ", MaxX = " + MaxX + ", ");
                out.print("MinY = " + MinY + ", MaxY = " + MaxY + ".</td></tr>");		
		return;
	}
	
out.print("<tr><td>Thank you for your submission of job id " + uniqueId + ".  The processing of your job may take a significant amount of time.  You will receive an email notification once the processing is complete.</td></tr>");

	String[] classification = request.getParameterValues("classification");
	if (classification != null) {
		for (int i=0; i<classification.length; i++) {
			System.out.println("clasification ==> " + classification[i]);
			requestParams += "&c=" + classification[i];
		}
	}
        String resolution = request.getParameter("resolution");
	String dmin = request.getParameter("dmin");
	String tension = request.getParameter("spline_tension");
	String smooth = request.getParameter("spline_smoothing");
        
	requestParams += "&resolution=" + resolution;
	requestParams += "&dmin=" + dmin;
	requestParams += "&spline_tension=" + tension;
	requestParams += "&spline_smoothing=" + smooth;

	requestParams += "&download=" + download;

	//String email = request.getParameter("email");
	//System.out.println("email ==> " + email);
        requestParams += "&email=" + email;

	requestParams += "&MinX=" + MinX; 
	requestParams += "&MinY=" + MinY; 
	requestParams += "&MaxX=" + MaxX; 
	requestParams += "&MaxY=" + MaxY; 
	
	requestParams += "&numRows=" + numRows; 

	String srid = request.getParameter("srid");
	requestParams += "&srid=" + srid; 

	System.out.println("requestParams ==> " + requestParams);
	out.print("<META HTTP-EQUIV=\'Refresh\' CONTENT=\"0 ; URL=lidarProc.jsp?" + requestParams + "\">");
	System.out.println("<META HTTP-EQUIV=\'Refresh\' CONTENT=\"0 ; URL=lidarProc.jsp?" + requestParams + "\">");
	//out.print("<META HTTP-EQUIV=\'Refresh\' CONTENT=\"0 ; URL=http://www.google.com \">");

%>
</table>

</body>
</html>

