<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 //EN">
<html>
<head>
<title>Atype Workflow</title>
</head>
<body>
<form method="POST" action="atypeResult.jsp">
<table border="0">
<tr><td>Execute Atype workflow</td></tr>
<tr><td> <%//out.println(System.getProperty("user.dir"));
String path = pageContext.getServletContext().getRealPath("/");
out.println("application path ==> " + path);
String inputWF = "file:///" + path + "data/Atype/Original/simpleTest.xml";
out.println("wf path ==> " + inputWF);
%></td></tr>
<tr><td>Workflow Parameters:</td></tr>
<tr><td><table>
<tr><td>Classification type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td><td><input type="text" name="classificationType" size="25" value="A-type"></td></tr>
<tr><td>Area: </td><td><input type="text" name="area" size="25" value="VA"></td></tr>
<tr><td>Bodies type:</td><td><input type="text" name="bodiesType" size="25" value="Plutonic"></td></tr>
<tr><td>Diagrams info:</td><td><input type="text" name="diagramsInfo" size="25" value="diagrams.txt"></td></tr>
</table></td></tr>
<tr align="center"><td><input type="submit" value="Execute"/></td></tr>
</table>
</form>
</body>
</html>
