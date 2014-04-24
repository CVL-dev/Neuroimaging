<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="org.geon.LidarJobConfig" %>
<%@ page import="org.geon.LidarJobDB" %>

<HEAD>
<TITLE>LiDAR Job Description</TITLE>
</HEAD>
<body bgcolor="#FFFFFF">

<style type='text/css'>
   .dataHead { font: 12px Verdana; font-weight: bold;}
   .dataBody { font: 12px Verdana; color: navy; }	
   .dataDone { font: 12px Verdana; font-weight: bold; color: white; }	
   .dataQueue { font: 12px Verdana; color: orange; }	
   .dataRunning { font: 12px Verdana; color: red; }	
   .dataNotchecked { font: 12px Verdana; font-weight: bold; color: white; }	
   .dataStatus { font: 12px Verdana; color: purple; }	
</style>
<div style='font: 12px Verdana; horizontal-align:left; '>
  <img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=20 border=0><br>
  <table border=0 cellpadding=0 cellspacing=0>
    <tr><td width=30><img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=10 border=0></td>
    <td width=100%>
     <table border=0 cellpadding=1 cellspacing=0>
    <tr>
        <td>
	<img src='/LidarPortlet/jsp/images/spacer.gif' width=125 height=1 border=0>
	<span class=dataHead>LiDAR Job Description</span></td>
    </tr>
    <tr>
        <td><img src='/LidarPortlet/jsp/images/spacer.gif' width=1 height=1 border=0></td>
    </tr>
<tr><td><img src='/LidarPortlet/jsp/images/gdot.gif' width=520 height=1 border=0></td></tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=20 height=10 border=0></td></tr>
  </table>
  </td>
  </tr>
  </table>
</div>

<% 
/*Enumeration e = request.getParameterNames();
out.print("request elements: <br>");
while (e.hasMoreElements()) {
    out.print((String)e.nextElement() + "<br>");
}
String title = (String)session.getAttribute("title");
out.print("title = " + title);
String description = (String)session.getAttribute("description");
out.print("description:<br>" + description);
*/
String jobId = request.getParameter("id");
//out.print("jobId = " + jobId);
String configFile = application.getRealPath("/WEB-INF/persistence/lidar.properties");
LidarJobDB lidarJobDB = new LidarJobDB(configFile);
String title = null;
String description = null;
LidarJobConfig jobConfig = lidarJobDB.getJobDescription(jobId);
title = jobConfig.getJobTitle();
if (title == null || title.equals("")) title = "no title";
description = jobConfig.getJobDescription();
if (description == null) description = "";
%>

<div style='font: 12px Verdana; horizontal-align:left;padding-left:30 '>
  <img src='/LidarPortlet/jsp/images/spacer.gif' width=25 height=5 border=0><br>
  <table border=0 cellpadding=0 cellspacing=0 width=550px>
    <tr>
        <td width=40px valign=top>
	<span class=dataHead>Title: </span></td>
	<td><span class=dataBody><%= title %></span></td>
    </tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=1 height=10 border=0></td></tr>
    <tr>
        <td colspan=2>
	<span class=dataHead>Description: </span></td>
    </tr>
<tr><td><img src='/LidarPortlet/jsp/images/spacer.gif' width=1 height=5 border=0></td></tr>
    <tr>
        <td colspan=2>
	<span class=dataBody><%= description %></span></td>
    </tr>
  </table>
</div>
</HTML>
