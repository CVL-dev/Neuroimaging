<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="org.geon.LidarJobConfig" %>
<%@ page import="org.geon.LidarJobDB" %>
<%-- 
  Set up the property bean and set some URL strings
  using info therein.
--%>
<%--============================================================--%>
</jsp:useBean>

<!-- jsp:useBean id="username" class="java.lang.String" scope="request"/ -->
<jsp:useBean id="lidarUri" class="java.lang.String" scope="request"/>
<jsp:useBean id="lidarJobConfigUri" class="java.lang.String" scope="request"/>
<jsp:useBean id="lidarMonitorUri" class="java.lang.String" scope="request"/>
<jsp:useBean id="lidarNSAFUri" class="java.lang.String" scope="request"/>
<jsp:useBean id="lidaRainierUri" class="java.lang.String" scope="request"/>

<style type='text/css'>
   .dataHead { font: 12px Verdana; font-weight: bold;}
   .dataBody { font: 12px Verdana; color: navy; }	
   .dataDone { font: 12px Verdana; font-weight: bold; color: white; }	
   .dataQueue { font: 12px Verdana; color: orange; }	
   .dataRunning { font: 12px Verdana; color: red; }	
   .dataNotchecked { font: 12px Verdana; font-weight: bold; color: white; }	
   .dataStatus { font: 12px Verdana; color: purple; }	
</style>

<script type="text/javascript">

// global request and XML document objects
var req;
var jobPaneIndex;
var queryString;

// type, such as text/xml; XML source must be from
// same domain as HTML file
function loadXMLDoc(url, index, querystring) {
    // branch for native XMLHttpRequest object
    jobPaneIndex = index;
    queryString = querystring;

    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
        req.onreadystatechange = processReqChange;
        req.open("GET", url, true);
        req.send(null);

	// open the message pane
        var msgPane = document.getElementById('msgPane');	
        //msgPane.x = '200px';
        //msgPane.y = '700px';
        msgPane.style.display = 'block';

    // branch for IE/Windows ActiveX version
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
        if (req) {
            req.onreadystatechange = processReqChange;
            req.open("GET", url, true);
            req.send();

	// open the message pane
        var msgPane = document.getElementById('msgPane');	
        //msgPane.x = '200px';
        //msgPane.y = '700px';
        msgPane.style.display = 'block';

        }
    }
}

// handle onreadystatechange event of req object
function processReqChange() {
    // only if req shows "loaded"
    if (req.readyState == 4) {
        // only if "OK"
        if (req.status == 200) {
	    // do whatever you like

	    //alert(req.responseText);
	    setJobStatus(req.responseText);
	    
	    // close the message pane
            var msgPane = document.getElementById('msgPane');	
            msgPane.style.display = 'none';

         } else {
            alert("There was a problem retrieving the XML data:\n" +req.statusText);
         }
    } 
}



function setJobStatus(message) {

    var bName = navigator.appName;
    //alert("--"+message+"--");
    var content;

    message = trimString(message);
    content = message;

    //alert("--"+message.length+"--");
    //alert("--"+message+"--");

    if(message=="Done") {
        message = "<span class=dataDone>"+message+"</span>"; 
        document.getElementById("jobStatusColor"+jobPaneIndex).style.backgroundColor = "#008000";
    } else if(message=="Queued") {
        message = "<span class=dataHead>"+message+"</span>";
        document.getElementById("jobStatusColor"+jobPaneIndex).style.backgroundColor = "#FFFF00";
    } else if(message=="Running") {
        message = "<span class=dataHead>"+message+"</span>";
        document.getElementById("jobStatusColor"+jobPaneIndex).style.backgroundColor = "#FF0000";
    } else if(message=="Not Checked") {
        message = "<span class=dataNotchecked>"+message+"</span>";
        document.getElementById("jobStatusColor"+jobPaneIndex).style.backgroundColor = "#808080";
    } else {
        message = "<span class=dataHead>"+message+"</span>";
        document.getElementById("jobStatusColor"+jobPaneIndex).style.backgroundColor = "#FF00FF";
    }

    if(content=="Done"){	
        document.getElementById("jobStatusPane"+jobPaneIndex).innerHTML = message;
    } else {

        document.getElementById("jobStatusPane"+jobPaneIndex).innerHTML = 
           "<a href='javascript:loadXMLDoc(\"/LidarPortlet/jsp/lidarJobStatus.jsp?"+queryString+"\","+jobPaneIndex+", \""+queryString+"\")'>"+message+"</a>";

    }

    /*
    if (bName == "Microsoft Internet Explorer") {
        jobStatusPane5.innerHTML = message;
    } else {
        document.getElementById("jobStatusPane"+jobPaneIndex).innerHTML = message;
    }
    */

}

//Use regular expressions to remove the white space 

function trimString (str) {
  str = this != window? this : str;
  return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
}

</script>
<!--
<div style='font: 12px Verdana; horizontal-align:left; '>
  <img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=20 border=0><br>
  <table border=0 cellpadding=0 cellspacing=0>
    <tr><td width=30><img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=10 border=0></td>
    <td width=100%>
     <table border=0 cellpadding=1 cellspacing=0>
    <tr>
        <td>
	<img src='/LidarPortlet/jsp/images/spacer.gif' width=125 height=1 border=0>
	<span class=dataHead>View the results of you GEON LiDAR Workflow job</span></td>
    </tr>
    <tr>
        <td><img src='/LidarPortlet/jsp/images/spacer.gif' width=1 height=1 border=0></td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
</div>
-->
<%--============================================================--%>
<%-- Begin the main page --%>
<%--============================================================--%>


<%
String configFile = application.getRealPath("/WEB-INF/persistence/lidar.properties");
LidarJobDB lidarJobDB = new LidarJobDB(configFile);
String jobId = request.getParameter("jobId");
//out.print("jobId = " + jobId);
if (jobId==null) { //TODO: FIX!!!
    jobId="113883170262391668056";
}
LidarJobConfig jobConfig = null;
String userId = "efrat@sdsc.edu";
if (jobId != null) {
    jobConfig = lidarJobDB.getJobConfig(jobId);
    userId = jobConfig.getUserId();
    System.out.println("userId = " + userId);
}
if(jobConfig == null) {
%>

<div style="padding-left:40">
<span class=dataBody>Unable to load job data.</span>
</div>
<p>
<div style="padding-left:40">
  <table border=0 cellpadding=0 cellspacing=0>
<tr><td><A href="<%= lidarMonitorUri %>&username=<%= userId %>">Back to the Lidar Job Manager</td></tr>
</div>

<%
} else {
%>

<form name="UserInputSelect" Method="POST" action="<%= lidarJobConfigUri %>" enctype="multipart/form-data" >

<div style='font: 12px Verdana; horizontal-align:left; '>
  <img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=5 border=0><br>
  <table border=0 cellpadding=0 cellspacing=0>
    <tr>
        <td>
	<img src='/LidarPortlet/jsp/images/spacer.gif' width=60 height=1 border=0>
	<span class=dataHead>View the results of you GEON LiDAR Workflow job</span></td>
    </tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=20 height=10 border=0></td></tr>
     <tr>
    <td>
     <div style="padding-left:30">
     <table border=1 cellpadding=1 cellspacing=0>
<tr>
<td width=90 align=center>
<span class=dataHead>Job Id</span>
</td>
<td width=190 align=center>
<span class=dataHead>Submission Date</span>
</td>
<td align=center nowrap>
<span class=dataHead>Job Status</span>
</td>
<td width=50 align=center>
<span class=dataHead>Query Time</span>
</td>
<%
String[] processings = jobConfig.getProcessings();
if (processings != null && processings.length > 0) {
%>
<td width=50 align=center>
<span class=dataHead>Process Time</span>
</td>
<%
}
%>
<td width=190 align=center>
<span class=dataHead>Completion Date</span>
</td>
</tr>
<%

    jobId = jobConfig.getJobId();
    String submissionDate = jobConfig.getSubmissionDate();
    String jobStatus = jobConfig.getJobStatus();
    String queryTime = jobConfig.getQueryTime();
    String processTime = jobConfig.getProcessTime();
    String completeDate = jobConfig.getCompletionDate();

	System.out.println(jobId + ", " + submissionDate + ", " + jobStatus);
%>
        <tr>
	<td align=center>
	<span class=dataBody><%= jobId %></span> 
        </td>
	<td align=center>
	<span class=dataBody><%= submissionDate %></span> 
        </td>
	<td align=center>
	<span class=dataBody><%= jobStatus %></span> 
        </td>
	<td align=center>
	<span class=dataBody><%= queryTime %></span> 
        </td>
<%
if (processings != null && processings.length > 0) {
%>
	<td align=center>
	<span class=dataBody><%= processTime %></span> 
        </td>
<%
}
%>
	<td align=center>
	<span class=dataBody><%= completeDate %></span> 
        </td>
        </tr>
  </table>

  <div id='msgPane' style='padding-top:2px;padding-left:5px;padding-bottom:2px;color:brown;display:none; border-style:solid; border-width:2px;'>Please wait ...... </div>

 </div>
  </td>
  </tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=20 height=20 border=0></td></tr>
<tr><td>
<div style="padding-left:130">
<input type=submit name="jobAction" value="Query Response" />
<%
if (processings != null && processings.length > 0) {
%>
<input type=submit name="jobAction" value="Process Response" />
<%
}
%>
<input type=submit name="jobAction" value="Delete" disabled>
<input type=submit name="jobAction" value="Upload" disabled>
</div>
</td>
  </tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=20 height=20 border=0></td></tr>
<tr><td><div>
<jsp:include page="/LidarPortlet/jsp/lidarNSAF.jsp" />
</div></td></tr>
<tr><td><A href="<%= lidarNSAFUri %>&jobId=<%= jobId %>">View Job Configurations</td></tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=20 height=20 border=0></td></tr>
<tr><td><A href="<%= lidarMonitorUri %>&username=<%= userId %>">Back to the Lidar Job Manager</td></tr>
  </table>
</div>

</form>
<!-- <jsp:include page="/LidarPortlet/jsp/lidarNSAF.jsp&jobId=<%= jobId %>"/> -->
<!-- <table><tr><td><div>
<jsp:include page="/LidarPortlet/jsp/lidarNSAF.jsp"/>
</div></td></tr></table> -->
<%//TODO: MAKE LIDARNSAF GENERIC!!!
}
%>
