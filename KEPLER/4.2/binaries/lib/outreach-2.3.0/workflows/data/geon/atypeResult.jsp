<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="Atype.WorkflowExecute" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 //EN">

<html>
<head>
<title>Atype Result</title>
</head>
<body>
<table border="0">

<% //     java.util.Enumeration paramNames = request.getParameterNames();
// get the parameter names %>

<%
String appPath = pageContext.getServletContext().getRealPath("/");
%>
<tr><td>
<%out.println("application path ==> " + appPath + "\n"); %> </td></tr>

<%

      System.out.print("server name " + request.getServerName());
      System.out.print("server name " + request.getServerPort());

      Map inputs = new TreeMap();

    try {
     InetAddress thisIp =
        InetAddress.getLocalHost();
        String ip = thisIp.getHostAddress();
     System.out.println("IP:"+thisIp.getHostAddress());
     inputs.put("ip", ip);
     }
    catch(Exception e) {
     e.printStackTrace();
     }

      String port = String.valueOf(request.getServerPort());
      System.out.println("port:"+port);
      inputs.put("port",port);
      String classificationType = request.getParameter("classificationType");
      inputs.put("classificationType", classificationType);
      String area = request.getParameter("area");
      inputs.put("area", area);
      String bodiesType = request.getParameter("bodiesType");
      inputs.put("bodiesType", bodiesType);
      String diagramsInfo = request.getParameter("diagramsInfo");
      inputs.put("diagramsInfo", diagramsInfo);

        System.out.println("init");
              	String inputWF = "file:///" + appPath + "data/Atype/Original/Atype.xml";
           	File momlFile = new File(inputWF);
                   System.out.println("BEFORE!!");
            WorkflowExecute we = new WorkflowExecute();
            try {
            	String res = we.executeAtype(inputWF, inputs);
            	System.out.println(res);
                    System.out.println("AFTER");
                    System.out.println(res);
                    response.sendRedirect(res);

            } catch (Exception ex) {
                    ex.printStackTrace();
            }

%>


<% // get and set the input parameters!!
//    while (paramNames.hasMoreElements()) {
//      String name = (String) paramNames.nextElement();
//            _inputValueArr[l++] = request.getParameter(name);
//      }
// }
// save session!!


// output result
//    	out.println("outpartnametype --> " + partName[i] + " - " + typeStr[i]);
// redirect
%>

</table>

</body>
</html>

