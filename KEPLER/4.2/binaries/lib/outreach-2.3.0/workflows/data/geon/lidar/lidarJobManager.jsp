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
<jsp:useBean id="title" class="java.lang.String" scope="request"/>
<jsp:useBean id="description" class="java.lang.String" scope="request"/>
<!-- jsp:useBean id="mySYNSEISInputUri" class="java.lang.String" scope="request"/ -->
<!-- jsp:useBean id="mySYNSEISWaveformUri" class="java.lang.String" scope="request"/ -->
<!-- jsp:useBean id="mySYNSEISMovieUri" class="java.lang.String" scope="request"/ -->
<!-- jsp:useBean id="mySYNSEISJobStatusUri" class="java.lang.String" scope="request"/ -->

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

        //document.getElementById("jobStatusPane"+jobPaneIndex).innerHTML = message;

	//alert("<a href='javascript:loadXMLDoc(\"/LidarPortlet/jsp/synseis-jobstatus.jsp?"+queryString+"\","+jobPaneIndex+", \""+queryString+"\")'>"+message+"</a>");

        document.getElementById("jobStatusPane"+jobPaneIndex).innerHTML = 
           "<a href='javascript:loadXMLDoc(\"/LidarPortlet/jsp/synseis-jobstatus.jsp?"+queryString+"\","+jobPaneIndex+", \""+queryString+"\")'>"+message+"</a>";

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

function openwindow(url,w,h)
{
    window.open(url,"_new","toolbar=no, location=no, directories=no, status=yes, menubar=no, scrollbars=yes, resizable=yes, width="+w+", height="+h);
}


</script>

<div style='font: 12px Verdana; horizontal-align:left; '>
  <img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=20 border=0><br>
  <table border=0 cellpadding=0 cellspacing=0>
    <tr><td width=30><img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=10 border=0></td>
    <td width=100%>
     <table border=0 cellpadding=1 cellspacing=0>
    <tr>
        <td>
	<img src='/LidarPortlet/jsp/images/spacer.gif' width=125 height=1 border=0>
	<span class=dataHead>LiDAR Job Manager</span></td>
    </tr>
    <tr>
        <td><img src='/LidarPortlet/jsp/images/spacer.gif' width=1 height=1 border=0></td>
    </tr>
<tr><td><img src='/LidarPortlet/jsp/images/gdot.gif' width=500 height=1 border=0></td></tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=20 height=10 border=0></td></tr>
  </table>
  </td>
  </tr>
  </table>
</div>

<%--============================================================--%>
<%-- Begin the main page --%>
<%--============================================================--%>


<%
String configFile = application.getRealPath("/WEB-INF/persistence/lidar.properties");
LidarJobDB lidarJobDB = new LidarJobDB(configFile);
String username = request.getParameter("username");
LidarJobConfig[] userJobs = lidarJobDB.getUserJobs(username);
if(userJobs == null) {
%>

<div style="padding-left:40">
<span class=dataBody>You have no archived GEON LiDAR workflow jobs.</span>
</div>
<p>
<div style="padding-left:40">
  <table border=0 cellpadding=0 cellspacing=0>
<tr><td><A href="<%= lidarUri %>">Submit a LiDAR Job</td></tr>
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
	<span class=dataHead>List of your submitted jobs</span></td>
    </tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=1 height=10 border=0></td></tr>
     <tr>
    <td>
     <div style="padding-left:30">
     <table width=80% border=1 cellpadding=1 cellspacing=0>
<tr>
<td width=50 align=center>
<span class=dataHead>Select</span>
</td>
<td width=90 align=center>
<span class=dataHead>Job Id</span>
</td>
<td width=400 align=center wrap>
<span class=dataHead>Title</span>
</td>
<td width=210 align=center>
<span class=dataHead>Submission Date</span>
</td>
<td align=center nowrap>
<span class=dataHead>Job Status</span>
</td>
</tr>
<%

    String userJobId = null;
    String submissionDate = null;
    String jobStatus = null;
    title = null;
    description = null;
    String checked = "";
    System.out.println("Jobs for user: " + username);

    for(int i=0; i<userJobs.length; i++) {
	userJobId = userJobs[i].getJobId();
	title = userJobs[i].getJobTitle();
	if (title == null || title.equals("")) title = "no title";
	description = userJobs[i].getJobDescription();
	submissionDate = userJobs[i].getSubmissionDate();
	jobStatus = userJobs[i].getJobStatus();	

	System.out.println(userJobId + ", " + submissionDate + ", " + jobStatus);

/*    String querystring = "userID="+username+"&jobID="+jobid+"&dirName="+dirname+"&siteName="+sitename;
    String jobdelInfo = jobid+"+"+dirname+"+"+jobxml+"+"+sitename;

    String jobcolor = "<span class=dataHead>";
    String jobbgcolor = "FF00FF";
    if(jobstatus.equals("Done")) { jobcolor = "<span class=dataDone>"; jobbgcolor = "008000";}
    else if(jobstatus.equals("Queued")) {jobcolor = "<span class=dataHead>"; jobbgcolor = "FFFF00";}
    else if(jobstatus.equals("Not Checked")){ jobcolor = "<span class=dataNotchecked>"; jobbgcolor = "808080";}
    else if(jobstatus.equals("Running")){ jobcolor = "<span class=dataHead>"; jobbgcolor = "FF0000";}
    else { jobcolor = "<span class=dataHead>"; jobbgcolor = "FF00FF"; }
*/
	checked = (i==0?"checked":"");
%>
        <tr>
	<td align=center>
	<input type=radio name=jobIdRadio value="<%= userJobId %>" <%= checked %>> 
	</td>
	<td align=left>
	<span class=dataBody><%= userJobId %></span> 
        </td>
	<td align=left><span class=dataBody>
<% if (description == null || description.equals("")) { %> 
	<%= title %> 
<% } else { 
	session.setAttribute("title", title);
	session.setAttribute("description", description);
	request.setAttribute("title", title);
	request.setAttribute("description", description);
%>
	<u><a href="javascript:openwindow('/LidarPortlet/jsp/jobDescription.jsp?id=<%= userJobId %>',620,260)"><%= title %></a></u>
<% } %>
	</span></td>
	<td align=left>
	<span class=dataBody><%= submissionDate %></span> 
        </td>
	<td align=center>
	<span class=dataBody><%= jobStatus %></span> 
        </td>

        <!--
	<td align=center id="jobStatusColor< %= i %>" bgcolor=< %=jobbgcolor %>>
	< %= jobcolor %><div id="jobStatusPane<%= i %>">< %= !(jobStatus.toLowerCase().equals("done")||jobStatus.toLowerCase().indexOf("failure")>-1) ? "<a href='javascript:loadXMLDoc(\"/LidarPortlet/jsp/lidar-jobstatus.jsp?jobId="+jobId+"\")'>"+jobStatus+"</span></a>" : jobStatus %></div></span>
        </td>
	-->
        </tr>

<%
   }
%>

  </table>

  <div id='msgPane' style='padding-top:2px;padding-left:5px;padding-bottom:2px;color:brown;display:none; border-style:solid; border-width:2px;'>Please wait ...... </div>

 </div>
  </td>
  </tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=20 height=20 border=0></td></tr>
<tr><td><INPUT TYPE="hidden" name="jobId" value="113883170262391668056" /></td></tr>
<tr><td>
<div style="padding-left:130">
<input type=submit name="jobselection" value="Show Job">
<input type=submit name="jobselection" value="Delete" disabled>
<input type=submit name="jobselection" value="Upload" disabled>
</div>
</td>
  </tr>
  </table>
</div>

</form>

<%
}
%>
