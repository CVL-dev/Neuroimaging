<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.geon.ExecutionThread" %>

<% String user = request.getParameter("email");
if (user == null) user = "";
System.out.println("Entered GLW: " + user + " " + new Date().toString()); 
ExecutionThread _thread = new ExecutionThread();
_thread._logExecution("Entered GLW: " + user + " " + new Date().toString()+"\n",  "lidarAccess");
%>
<HEAD>
<TITLE>LiDAR / ALSM Data Processing with GEON Cyberinfrastructure</TITLE>
</HEAD>
<body bgcolor="#FFFFFF">

<script language="javascript">
function submitform() {
    var errs=0;
    if (!validatePresent(document.forms[0].reqEmail, 'inf_reqEmail', true) ||
        !validateEmail(document.forms[0].reqEmail,'inf_reqEmail', true))       errs += 1;
    if (!validatePresent(document.forms[0].lastName, 'inf_lastName') ||
        !validateAlphabet(document.forms[0].lastName, 'inf_lastName'))         errs += 1;
    if (!validatePresent(document.forms[0].firstName, 'inf_firstName') ||
        !validateAlphabet(document.forms[0].firstName, 'inf_firstName'))       errs += 1;
    if (!validatePresent(document.forms[0].institution, 'inf_institution'))    errs += 1;
    if (errs == 0) document.forms[0].submit();
}                             
</script>                                                                                               
<script language="javascript" src="formval.js"></script>

<TABLE>
<TR>
<TD><A HREF="http://activetectonics.la.asu.edu/GEONatASU/index.htm" target="_new"><IMG border="0" SRC="http://agassiz.la.asu.edu/logos/GEONASUWebBanner.jpg" alt="GEON at ASU homepage"></A></TD>
</TR>
<TR>
<TD align=center><a href="http://www.sdsc.edu" target="_new"><img border="0" src="http://www.sdsc.edu/logos/SDSClogo-plusname-red.gif" alt="San Diego Supercomputer Center" ></a></TD>
</TR>
</TABLE>
<h1>LiDAR / ALSM Data Processing with GEON Cyberinfrastructure</h1>
<TABLE cellpadding=2 width="78%">
<TR><TD>Welcome to the GEON LiDAR / ALSM processing page.  This site was developed as an end-to-end solution for the distribution, interpolation and analysis of LiDAR / ALSM point data.  This tool capitalizes on cyberinfrastructure developed by GEON as part of its effort to develop information technology for the Geosciences.  The goal of this project is to provide a web-based toolset that can democratize access to these rich and computationally challenging data sets.</TD></TR>
</TABLE>
<br>
<TABLE width="50%">
<TR><TD colspan="2"><b>Please select a data set:</b></TD></TR>
<TR>
	<TD width="4%"><div id='snsaf' style='display:inline'><a href='javascript:showItem("nsaf")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hnsaf' style='display:none'><a href='javascript:hideItem("nsaf")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
	<TD><A HREF="lidarNSAF.jsp?user=<%= user %>">Northern San Andreas Fault (NSAF), CA</A></TD>
</TR>
<TR><TD colspan=2><div id='nsaf' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>LiDAR data acquired along the Northern San Andreas fault and associated marine terraces in coastal Sonoma and Mendocino counties, California (<a href="http://activetectonics.la.asu.edu/GEONatASU/Data/NSAFLiDAR_overview.gif" target="_new">map</a>)</td>
    </tr>
</TABLE>
</div></TD></TR>
<TR>
	<TD><div id='sranier' style='display:inline'><a href='javascript:showItem("ranier")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hranier' style='display:none'><a href='javascript:hideItem("ranier")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
	<TD><A HREF="lidarRanier.jsp?user=<%= user %>">West Rainier Seismic Zone, WA</A></TD>
</TR>
<TR><TD colspan=2><div id='ranier' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>LiDAR data of the western Rainier seismic zone, adjacent to Mt. Rainier, in Pierce County, WA</td>
    </tr>
</TABLE>
</div></TD></TR>
</TABLE>
<br/>
<TABLE width="40%">
<TR><TD>Metadata documents on these data sets can be found <a href="http://activetectonics.la.asu.edu/GEONatASU/Data/metadata.html" target="_new">here</a>.</TD></TR>
<TR><TD><font size=1 face="Verdana">*Web browser compatibility for Macintosh users: Some aspects of the GEON LiDAR processing pages may not be compatible with Apple's Safari web browser. We recommend <a href=" http://www.mozilla.com/firefox/" target="_new">Firefox</a> for browsing these pages.</font></TD></TR>
</TABLE>
<br>
<TABLE width="40%">
<TR><TD><HR></TD></TR>
</TABLE>
<TABLE width="50%" border=0>
<TR>
<TD colspan=2><div id='saccess' style='display:inline'><a href='javascript:showItem("access")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='haccess' style='display:none'><a href='javascript:hideItem("access")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div>&nbsp;&nbsp;
<b>Request access to run LiDAR jobs:</b></TD>
</TR>
<TR><TD colspan=3><div id='access' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Selecting a dataset will provide you with additional information about the data. In order to submit LiDAR jobs, you must be authorized first. Use the form below to request access, our reviewers will get back to you in a couple of days (please note that all fields are required).</td>
    </tr>
</TABLE>
</div></TD></TR>
<form action="lidarAccessRequest.jsp" method=post>
<TR>
    <TD width=90px><font size=3px>First Name:</font></TD>     
    <TD width=60px><Input type="text" name="firstName" size=30 value=""></TD><TD><span id="inf_firstName"></span></TD>     
</TR> 
<TR>
    <TD><font size=3px>Last Name:</font></TD>     
    <TD><Input type="text" name="lastName" size=30 value=""></TD><TD><span id="inf_lastName"></span></TD>     
</TR> 
<TR>
    <TD><font size=3px>Institution:</font></TD>     
    <TD><Input type="text" name="institution" size=30 value=""></TD><TD><span id="inf_institution"></span></TD>     
</TR> 
<TR>
    <TD><font size=3px>Email:</font></TD>     
    <TD><Input type="text" name="reqEmail" size=30 value=""></TD><TD><span id="inf_reqEmail"></span></TD>     
</TR> 
<TR><TD colspan="3"><Input type="hidden" name="user" value="<%= user %>"></TD></TR>
<TR>
    <TD colspan="2" align="center">
    <INPUT TYPE="button" value="Submit" onClick="submitform()">
    </TD>
</TR>

</form>
</TABLE>
<br>
<TABLE cellpadding=2 width="40%">
<TR><TD><HR></TD></TR>
<TR><TD>Information about us and the projects we are involved with</TD></TR>
<TR><TD><A HREF="http://activetectonics.la.asu.edu/GEONatASU/index.htm" target="_new">Geoinformatics at ASU </A></TD></TR>
<TR><TD><A HREF="http://activetectonics.asu.edu/" target="_new">ASU Active Tectonics Research Group </A></TD></TR>
<TR><TD><A HREF="http://activetectonics.la.asu.edu/ASU_GEON/laser_links.html" target="_new">Active Tectonics Group LiDAR / ALSM research pages </A></TD></TR>
<TR><TD><A HREF="http://www.geongrid.org" target="_new">The GEON Project </A></TD></TR>
</TABLE>
<br>
<TABLE style='font: 12px Verdana;'>
    <tr><td><i>Please address questions, comments and errors to <a href="mailto:chris.crosby@asu.edu">Christopher Crosby</a></i>
    </td></tr>
</TABLE>

<script>

 function showItem(id) {

     var showElement = document.getElementById("s"+id);
     showElement.style.display = "none";

     var hideElement = document.getElementById("h"+id);
     hideElement.style.display = "inline";

     var contElement = document.getElementById(id);
     contElement.style.display = "block";

 }
 

 function hideItem(id) {

     var showElement = document.getElementById("s"+id);
     showElement.style.display = "inline";

     var hideElement = document.getElementById("h"+id);
     hideElement.style.display = "none";

     var contElement = document.getElementById(id);
     contElement.style.display = "none";

 }
 
</script>

</body>
</html>
