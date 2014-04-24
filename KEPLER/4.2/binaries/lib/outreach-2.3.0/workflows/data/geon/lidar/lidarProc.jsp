<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Thread" %>
<%@ page import="java.net.*" %>
<%@ page import="org.geon.LidarWorkflowExecute" %>
<%@ page import="org.geon.ExecutionThread" %>

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
System.out.println("inside lidarProc");
String uniqueId = request.getParameter("id"); 

String appPath = pageContext.getServletContext().getRealPath("/");
System.out.println("application path ==> " + appPath + "\n");  

String host = request.getServerName();
System.out.println("host:"+host);

String port = String.valueOf(request.getServerPort());
System.out.println("port:"+port);

System.out.println(new Date().toString());
long begin = new Date().getTime();

String configFile = application.getRealPath("/WEB-INF/persistence/lidar.properties");
request.setAttribute("configFile", configFile);
System.out.println("config file = " + configFile);

StringBuffer threadResp = new StringBuffer();
ExecutionThread _thread = new ExecutionThread(request, threadResp, appPath, uniqueId, host, port);

_thread.start();
_thread.join();
out.print(threadResp.toString());
long end = new Date().getTime();
long length = end - begin;
length = length/1000;
System.out.println("Processing took " + length + " seconds.");
System.out.println("done processing " + uniqueId);
String user = request.getParameter("username");
System.out.println("user = " + user);
if (user == null) user = "";
%>
<br><hr><br><br>
<table>
<tr><td>Processing took <%= length %> seconds.</td></tr>
<!--<tr><td><A href="https://portal.geongrid.org:8443/gridsphere/gridsphere?cid=147&JavaScript=enabled">Back to the LiDAR processing page</td></tr>-->
<tr><td><A href="http://geon01.sdsc.edu:8405/lidar/jsp/lidar.jsp?email=<%= user %>">Back to the Lidar processing page</td></tr>
</table>
</body>
</html>

