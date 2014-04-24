<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.geon.LidarUtilities" %>
<%@ page import="org.geon.LidarJobDB" %>

<jsp:useBean
    id="myRandomNumber"
    scope="application"
    class="java.util.Random" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 //EN">

<html>
<head>
<title>LiDAR Job Submission Access Request</title>
</head>
<body>
<body bgcolor="#FFFFFF">
<TABLE>
<TR>
<TD><A HREF="http://activetectonics.la.asu.edu/GEONatASU/index.htm" target="_new"><IMG border="0" SRC="http://agassiz.la.asu.edu/logos/GEONASUWebBanner.jpg" alt="GEON at ASU homepage"></A></TD>
</TR>
<TR>
<TD align="center"><a href="http://www.sdsc.edu" target="_new"><img border="0" src="http://www.sdsc.edu/logos/SDSClogo-plusname-red.gif" alt="San Diego Supercomputer Center" height="60" width="216"></a></TD>
</TR>
</TABLE>
<table cellpadding=2>
<br>

<%
	String firstName = request.getParameter("firstName");
	System.out.println("firstName ==> " + firstName);
	String lastName = request.getParameter("lastName");
	System.out.println("lastName ==> " + lastName);
	String org = request.getParameter("institution");
	System.out.println("org ==> " + org);
	String email = request.getParameter("reqEmail");
	System.out.println("email ==> " + email);
	String user = request.getParameter("user");
	System.out.println("user ==> " + user);

	//check if user already has access..
        String configFile = application.getRealPath("/WEB-INF/persistence/lidar.properties");
        LidarJobDB lidarJobDB = new LidarJobDB(configFile);
        boolean hasAccess = lidarJobDB.verifyUser(user);
	if (hasAccess) {
%>
<tr><td>Thank you for your request to access the LiDAR jobs submission. Your request has been granted.</td></tr>
<%	
	} else {
	    // send email request..
            StringBuffer threadResp = new StringBuffer();
            LidarUtilities lutil = new LidarUtilities(threadResp,"","","");
	    boolean processResponse = lutil.processAccessRequest(request);
 	    if (!processResponse) {
	        out.print(threadResp.toString());
	    } else {
%>
<tr><td>Thank you for your request to access the LiDAR jobs submission. You will receive a notification from our reviewers within a few days.</td></tr>
<%     
	   }
       } 
%>

<tr><td><hr></td></tr>
<tr><td><A href="http://geon01.sdsc.edu:8405/lidar/jsp/lidar.jsp?email=<%= user %>">Back to the LiDAR processing page</td></tr>
</table>

</body>
</html>

