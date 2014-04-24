<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.geon.ExecutionThread" %>
<%@ page import="org.geon.LidarJobDB" %>

<% String user = request.getParameter("user");
if (user == null) user = "";
System.out.println("Entered NSAF: " + user + " " + new Date().toString()); 
ExecutionThread _thread = new ExecutionThread();
_thread._logExecution("Entered NSAF: " + user + " " + new Date().toString()+"\n",  "lidarAccess");
%>
<HEAD>
<link rel="stylesheet" href="help.css">
                                                                                                                  
<link rel="stylesheet" href="inc/quickWMS.css"><script
        language="Javascript" src="inc/WMSbrowsers.js"></script> <script
        language="Javascript" src="inc/WMSlayer.js"></script> <script
        language="Javascript" src="inc/WMSmap.js"></script> <script
        language="Javascript" src="inc/WMStools.js"></script> <script
        language="Javascript" src="inc/WMSquick.js"></script>
                                                                                                                  
<TITLE>LiDAR / ALSM Data Processing with GEON Cyberinfrastructure</TITLE>
<SCRIPT LANGUAGE="javaScript">
                    <!--//
                    submited=0
                    function CheckSubmit()
                         {
                           if(submited>0)
                             {
                              return false
                             }
                    submited++
                    }
                    //-->
      </SCRIPT>

<script language='Javascript'>
var map;
function populate(){
                                                                                                                  
document.selectForm.MinX.value=map.slBox[0];
document.selectForm.MinY.value=map.slBox[1];
document.selectForm.MaxX.value=map.slBox[2];
document.selectForm.MaxY.value=map.slBox[3];
resetCount();
}

function resetCount() {
	document.selectForm.numRows.value=-1;
	document.getElementById('vFrame').src="";
}
                                                                                                                  
function validate() {
    verifyCoordinates();
    var X1 = document.selectForm.MinX.value;
    var X2 = document.selectForm.MaxX.value;
    var Y1 = document.selectForm.MinY.value;
    var Y2 = document.selectForm.MaxY.value;
    var srid = document.selectForm.srid.value;
    var cls = document.selectForm.classification.options;
    var url = "validate.jsp?MinX=" + X1 + "&MinY=" + Y1 + "&MaxX=" + X2 + "&MaxY=" + Y2 + "&srid=" + srid; 
    var c
    for (c=0; c<cls.length; c++) {
	if (document.selectForm.classification.options[c].selected) {
		url += "&classification=" + cls[c].value;
	}
    }
	frames["validateFrame"].location.href=url;
//	document.getElementById('vFrame').src=url;

//    document.location.href=url;

}

function submitForm(){
    if (document.forms[0].action=="") {
        alert("You are not authorized to submit LiDAR jobs.\n To request access, please go back to the main page.");
    } else {
        document.getElementById('vFrame').src="";
        verifyCoordinates();	
        outputFormats();
        document.selectForm.submit();
    }
}

/* function verifyCoordinates() {
    if (map.slBox[0]!="0" || map.slBox[1]!="0" || map.slBox[2]!="0" || map.slBox[3]!="0") 
    {
	populate();
    }
    if (document.selectForm.MinX.value=="") {
	document.selectForm.MinX.value=map.slBox[0];
    }
    if (document.selectForm.MinY.value=="") {
	document.selectForm.MinY.value=map.slBox[1];
    }
    if (document.selectForm.MaxX.value=="") {
	document.selectForm.MaxX.value=map.slBox[2];
    }
    if (document.selectForm.MaxY.value=="") {
	document.selectForm.MaxY.value=map.slBox[3];
    }
} */ 

function verifyCoordinates() {
    if (document.selectForm.MinX.value=="" || document.selectForm.MinY.value=="" || 
	document.selectForm.MaxX.value=="" || document.selectForm.MaxY.value=="") {
		populate();
    }
} 

function outputFormats() {
if (document.selectForm.elevview.checked) {
    document.selectForm.elevarc.checked=true;   
    document.selectForm.elevarc.disabled=false; 
    document.selectForm.elevascii.disabled=false;   
    document.selectForm.elevtiff.disabled=false;    
} 
else {
    document.selectForm.elevarc.disabled=true;  
    document.selectForm.elevascii.disabled=true;    
    document.selectForm.elevtiff.disabled=true; 
    document.selectForm.elevarc.checked=false;  
    document.selectForm.elevascii.checked=false;    
    document.selectForm.elevtiff.checked=false; 
}
if (document.selectForm.slopeview.checked) {
    document.selectForm.slopearc.checked=true;  
    document.selectForm.slopearc.disabled=false;    
    document.selectForm.slopeascii.disabled=false;  
    document.selectForm.slopetiff.disabled=false;   
} 
else {
    document.selectForm.slopearc.disabled=true; 
    document.selectForm.slopeascii.disabled=true;   
    document.selectForm.slopetiff.disabled=true;    
    document.selectForm.slopearc.checked=false; 
    document.selectForm.slopeascii.checked=false;   
    document.selectForm.slopetiff.checked=false;    
}
if (document.selectForm.aspectview.checked) {
    document.selectForm.aspectarc.checked=true; 
    document.selectForm.aspectarc.disabled=false;   
    document.selectForm.aspectascii.disabled=false; 
    document.selectForm.aspecttiff.disabled=false;  
} 
else {
    document.selectForm.aspectarc.disabled=true;    
    document.selectForm.aspectascii.disabled=true;  
    document.selectForm.aspecttiff.disabled=true;   
    document.selectForm.aspectarc.checked=false;    
    document.selectForm.aspectascii.checked=false;  
    document.selectForm.aspecttiff.checked=false;   
}
if (document.selectForm.pcurvview.checked) {
    document.selectForm.pcurvarc.checked=true;  
    document.selectForm.pcurvarc.disabled=false;    
    document.selectForm.pcurvascii.disabled=false;  
    document.selectForm.pcurvtiff.disabled=false;   
} 
else {
    document.selectForm.pcurvarc.disabled=true; 
    document.selectForm.pcurvascii.disabled=true;   
    document.selectForm.pcurvtiff.disabled=true;    
    document.selectForm.pcurvarc.checked=false; 
    document.selectForm.pcurvascii.checked=false;   
    document.selectForm.pcurvtiff.checked=false;    
}
}                                                                                                          
var textLimit = 500;
function update() {
    var counter = document.selectForm.jobDescription.value.length;
    if (counter > textLimit) {
        alert("Sorry, the job description is limited to 500 characters.");
        document.selectForm.jobDescription.value = document.selectForm.prevJobDescription.value;
    } else {
        document.selectForm.prevJobDescription.value = document.selectForm.jobDescription.value;
    }
}
</script>

</HEAD>
<body bgcolor="#FFFFFF">
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
<br><br>
<TABLE cellpadding=2 width="85%">
<TR>
<TD width="55%">As a pilot data set, this page offers access to LiDAR data acquired along the Northern San Andreas fault and associated marine terraces in coastal Sonoma and Mendocino counties, California (<a href="http://activetectonics.la.asu.edu/GEONatASU/Data/NSAFLiDAR_overview.gif" target="_new">map</a>).  This data set covers approximately 418 square kilometers and includes approximately 1.2 billion data points.  Point density is 1.2 points per square meter.  Select the yellow button at right for the projection and datum of this data set:&nbsp;
<div id='sprojection' style='display:inline'><a href='javascript:showItem("projection")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hprojection' style='display:none'><a href='javascript:hideItem("projection")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
<!--<TD></TD>-->
<TD><div id='projection' style='display:none; padding-top:3;' >
    <TABLE style='font: 10px Verdana;'>
    <tr><td>Projection: State Plane</td></tr>
    <tr><td>Zone for San Andreas: California II</td></tr>
    <tr><td>Horizontal units: US Survey Feet (= 1200/3937 meters ~ 0.30480061 meters)</td></tr>
    <tr><td>Elevation units: International Feet (= 0.3048 meters)</td></tr>
    <tr><td>Spheroid: GRS80</td></tr>
    <tr><td>Horizontal Datum: NAD83, 1991 Adjustment</td></tr>
    <tr><td>Vertical Datum: NAVD88</td></tr>
    <tr><td>Orthometric elevations are derived from ellipsoid elevations using the National Geodetic Survey geoid model Geoid99</td></tr>
</TABLE>
</div></TD></TR>
</TABLE>


<H2>Interactive spatial selection of LiDAR data</H2>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>

<%
        String configFile = application.getRealPath("/WEB-INF/persistence/lidar.properties");
        LidarJobDB lidarJobDB = new LidarJobDB(configFile);
        boolean hasAccess = lidarJobDB.verifyUser(user);
        if (hasAccess) {
%>
<form name="selectForm" ACTION="lidarSubmitNotification.jsp" METHOD="POST"> 
<%      } else { %>
<form name="selectForm" ACTION="" METHOD="POST"> 
<%      } %>
<TABLE  cellpadding=2 width="30%">
    <TR>
    <TD colspan="5">
        <script language='Javascript'>
         var demisWMS = "http://geon07.sdsc.edu/wmsconnector/com.esri.wms.Esrimap/nsaf"
         function writeMaps(){
            //map = new quickWMS(6015627.57917393, 1899101.39023383, 6275588.46169608, 2338108.17859906,"EPSG:2226");
            map = new quickWMS(5926104.62625239, 1899101.39023383, 6365111.41461762, 2338108.17859906,"EPSG:2226");
	    //  map = new quickWMS(6035946.85, 2239121.46, 6068889.01, 2244983.31,"EPSG:102242");
            //  map = new quickWMS(6040946.85, 2239121.46, 6053889.01, 2244983.31,"EPSG:2226");
            //  map = new quickWMS(6203946.36, 1946167.77, 6219121.76, 1967772.11,"EPSG:2226"); 
            //  map = new quickWMS(6203946.36, 1944967.77, 6219121.76, 1967772.11,"EPSG:2226"); 
//    map = new quickWMS(6203946.36, 1944967.77, 6226750.7, 1967772.11,"EPSG:2226"); 
            //  map = new quickWMS(6208361.02, 1951028.74, 6209602.64, 1953729.28,"EPSG:2226");
            //  map = new quickWMS(6204036.03, 1946343.30, 6213451.67, 1960035.05,"EPSG:2226");
            //  map.addLayer(demisWMS, "ncoast_30mhs,water_clip,NSAF_LiDAR_extent,roads_clip,CA_pop_place_clip", "1.1.1");
              map.addLayer(demisWMS, "4,3,2,1,0", "1.1.1");
              map.layers[0].format="image/png";
              map.writeDOM("myMap", 30, 620, 550, 550, "background-color:white;border-style:solid;border-width:5;border-color:red;");
              map.toolbar = new toolBar(map);
              map.toolbar.writeDOM(map.left+200,map.top+560,true);
              map.onSelection = populate; 
              map.refresh();
          }
          writeMaps()
        </script>
    </TD>
    </TR>
<TR>
<TD colspan=1><div id='stoolbar' style='display:inline'><a href='javascript:showItem("toolbar")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='htoolbar' style='display:none'><a href='javascript:hideItem("toolbar")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
</TR>
<TR>
<TD colspan=5><div id='toolbar' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr><td>
Navigation and selection of the map is completed with the tools above.  Select the magnifying glass tool and draw a box on the map to zoom to the area of interest.  Use the selection tool (furthest right tool) to select the area of the map you'd like to work with data for.
    </td></tr>
</TABLE>
</div></TD></TR>
    <TR>
        <TD colspan=5><HR></TD>
    </TR>
    <TR>
        <TD colspan="5">
        <H3><u>Data selection coordinates</u></H3>
        </TD>
    </TR>
<TR>
    <TD>MinX</TD><TD><Input type="text" name="MinX" value="6207117.0"></TD>
    <TD align=right>MinY</TD><TD><Input type="text" name="MinY" value="1951306.0"></TD>
</TR>
<TR>
    <TD>MaxX</TD><TD><Input type="text" name="MaxX" value="6207459.0"></TD>
    <TD align=right>MaxY</TD><TD><Input type="text" name="MaxY" value="1951991.0"></TD>
</TR>
    <TR>
<!--        <TD colspan=5><HR></TD> -->
        <TD colspan=5><BR></TD>
    </TR> 
    <TR>
<TD colspan=1><H3><div id='sclassinf' style='display:inline'><a href='javascript:showItem("classinf")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hclassinf' style='display:none'><a href='javascript:hideItem("classinf")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></H3></TD>
<TD colspan=4><H3><u>Classification</u></H3></TD>
    </TR>
<TR>
<TD colspan=5><div id='classinf' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Each point return within the Northern San Andreas data set is classified by what type of surface it is returned from.  Choosing points classified as "G" results in a "bare earth" Digital Elevation Model (DEM).  Failure to select a classification type results in all classifications being returned.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR><TD></TD>
        <TD COLSPAN=4>
        <select name=classification size=4 multiple onChange="resetCount()">
        <option value="B">B - Blunder</option>
        <option value="G">G - Ground</option>
        <option value="S">S - Structure</option>
        <option value="V">V - Vegetation</option>
        </select>
        </TD>
    </TR>
    <TR>
		<INPUT TYPE="hidden" name="numRows" value=-1 />
		<INPUT TYPE="hidden" name="srid" value=1005 />
	    <TR>
        	<TD><div id='svalid' style='display:inline'><a href='javascript:showItem("valid")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hvalid' style='display:none'><a href='javascript:hideItem("valid")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
		<TD><INPUT TYPE="button" value="Validate" onClick="validate()"></TD>
		<TD colspan=3>
		<IFRAME name="validateFrame" id="vFrame" frameborder="0" width="500" height="115" scrolling="no"></IFRAME>
		</TD>
	    </TR>
<TR>
<TD colspan=5><div id='valid' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Verify how many points will be returned based on the coordiate and attribute values chosen above and their estimated processing time. Currently, interpolation of points to an elevation product is limited to 1.6 million points. This limit does not apply to downloads of point cloud data.  By selecting only the "Download raw data" box below, point cloud data queries exceeding 1.6 million points may be downloaded. <font color="red">Please note that this operation may take several minutes when accessing areas containing millions of points.</font></td>
    </tr>
</TABLE>
</div></TD></TR>
    </TR>
    <TR>
        <TD colspan=5><HR></TD>
    </TR>
    <TR>
        <TD colspan="5">
        <H3><u>Point Cloud Data Download</u></H3>
        </TD>
    </TR>
<TR>
<TD colspan=1><div id='srawdatainf' style='display:inline'><a href='javascript:showItem("rawdatainf")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hrawdatainf' style='display:none'><a href='javascript:hideItem("rawdatainf")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
<TD colspan=4 nowrap align=left><Input type="checkbox" name="rawdata" value="1">Download raw data (Query result in compressed ASCII File)</TD>
</TR>
<TR>
<TD colspan=5><div id='rawdatainf' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Selection of this option returns the LiDAR point cloud for the area selected above as a compressed ASCII file (comma delimited, one point per line).  If you only wish to download the raw data it is not necessary to select any of the options in the "Processing Algorithms and Derived Products" section below.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR>
        <TD colspan=5><HR></TD>
    </TR>
    <TR>
        <TD colspan="5">
        <H3><u>Processing Algorithms and Derived Products</u>&nbsp;&nbsp;&nbsp;<div id='sprocinf' style='display:inline'><a href='javascript:showItem("procinf")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hprocinf' style='display:none'><a href='javascript:hideItem("procinf")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></H3>
        </TD>
    </TR>
<TR>
<TD colspan=5><div id='procinf' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Interpolation of the LiDAR data and calculation of derived products is performed via <a href="http://grass.itc.it/" target="_new">GRASS Open Source GIS</a>.  GRASS is running on the ASU GEON node and is accessed in this workflow via web service architecture.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR>
        <TD width="10%">&nbsp</TD>
        <TD colspan="1" width="20%">
        <b>Interpolation and Derived Product</b>
        </TD>
        <TD colspan="3">
        <b>Product Download Format&nbsp;&nbsp;&nbsp;<div id='sdownloadinf' style='display:inline'><a href='javascript:showItem("downloadinf")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hdownloadinf' style='display:none'><a href='javascript:hideItem("downloadinf")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></b>
        </TD>
    </TR>
<TR>
<TR>
<TD/><TD/>
<TD colspan=3><div id='downloadinf' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>The data products created by the GEON LiDAR workflow may be download in the following formats:</td>
    </tr>
    <tr>
	<td>Arc Grid:  This ascii grid format is designed for import into ESRI software such as ArcGIS.  The Arc Grid can be imported through ArcToolbox by selecting - Conversion Tools > To Raster > ASCII to Raster.  "Output data type" should be set to "float".</td>
    </tr>
    <tr>
	<td>ascii grid:  A standard ascii grid format that should be importable to software packages that can handle ascii grids (e.g. GMT).</td>
    </tr>
    <tr>
	<td>GeoTIFF:  A standard tiff image file with an associated header file (.tfw) that gives the tiff image spatial coordinates.  This file can be opened in GIS software or in standard graphics software packages such as Adobe's Photoshop.</td>
    </tr>
</TABLE>
</div></TD></TR>
<TD><div id='selev' style='display:inline'><a href='javascript:showItem("elev")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='helev' style='display:none'><a href='javascript:hideItem("elev")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
    <TD><Input type="checkbox" name="elevview" value="1" onClick="outputFormats()">Elevation (Spline)</TD>
    <TD colspan="1" width="40%"><Input type="checkbox" name="elevarc" value="1" disabled>Arc Grid</TD>
    <TD><Input type="checkbox" name="elevascii" value="1" disabled>Ascii Grid</TD>
    <TD><Input type="checkbox" name="elevtiff" value="1" disabled>GeoTIFF</TD>
</TR>
<TR>
<TD colspan=5><div id='elev' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Interpolation of the LiDAR point cloud selected above is performed via a regularized spline with tension and smooth algorithm offered in GRASS GIS.  This algorithm utilizes quadtree segmentation to speed interpolation of large data sets such as LiDAR.  An overview of the algorithm plus information on developers and references to publications can be found <a href="http://grass.itc.it/grass61/manuals/html61_user/v.surf.rst.html" target="_new">here</a>.  For deployment in the GEON workflow we have hardwired many of the settings to simplify user interaction with the tool.  Users retain control of the dmin, spline tension and spline smoothing parameters (see Interpolation Parameters below).</td>
    </tr>
</TABLE>
</div></TD></TR>
<TR>
<TD><div id='sslope' style='display:inline'><a href='javascript:showItem("slope")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hslope' style='display:none'><a href='javascript:hideItem("slope")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
    <TD><Input type="checkbox" name="slopeview" value="1" onClick="outputFormats()">Slope</TD>
    <TD><Input type="checkbox" name="slopearc" value="1" disabled>Arc Grid</TD>
    <TD><Input type="checkbox" name="slopeascii" value="1" disabled>Ascii Grid</TD>
    <TD><Input type="checkbox" name="slopetiff" value="1" disabled>GeoTIFF</TD>
</TR>
<TR>
<TD colspan=5><div id='slope' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Slope is a derived product of the surface interpolated by the spline algorithm.  Calculation of the slope map is completed directly from the interpolation function.  Slopes are computed in degrees (0-90).  The equations for computation of these parameters are described in <a href="http://activetectonics.la.asu.edu/GEONatASU/Data/Mitasova_and_Hofierka_1993.pdf" target="_new">Mitasova and Hofierka 1993</a>.</td>
    </tr>
</TABLE>
</div></TD></TR>
<TR>
<TD><div id='saspect' style='display:inline'><a href='javascript:showItem("aspect")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='haspect' style='display:none'><a href='javascript:hideItem("aspect")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
    <TD><Input type="checkbox" name="aspectview" value="1" onClick="outputFormats()">Aspect</TD>
    <TD><Input type="checkbox" name="aspectarc" value="1" disabled>Arc Grid</TD>
    <TD><Input type="checkbox" name="aspectascii" value="1" disabled>Ascii Grid</TD>
    <TD><Input type="checkbox" name="aspecttiff" value="1" disabled>GeoTIFF</TD>
</TR>
<TR>
<TD colspan=5><div id='aspect' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Aspect is a derived product of the surface interpolated by the spline algorithm.  Calculation of the aspect map is completed directly from the interpolation function.  Aspects are computed in degrees (1-360).  The aspect raster file has value 0 assigned to flat areas (with slope less than 0.1%) and to singular points with undefined aspect. Aspect points downslope and is 90 to the North, 180 to the West, 270 to the South and 360 to the East, the values increase counterclockwise.  The equations for computation of these parameters are described in <a href="http://activetectonics.la.asu.edu/GEONatASU/Data/Mitasova_and_Hofierka_1993.pdf" target="_new">Mitasova and Hofierka 1993</a>.</td>
    </tr>
</TABLE>
</div></TD></TR>
<TR>
<TD><div id='spcurv' style='display:inline'><a href='javascript:showItem("pcurv")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hpcurv' style='display:none'><a href='javascript:hideItem("pcurv")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
    <TD><Input type="checkbox" name="pcurvview" value="1" onClick="outputFormats()">PCurv</TD>
    <TD><Input type="checkbox" name="pcurvarc" value="1" disabled>Arc Grid</TD>
    <TD><Input type="checkbox" name="pcurvascii" value="1" disabled>Ascii Grid</TD>
    <TD><Input type="checkbox" name="pcurvtiff" value="1" disabled>GeoTIFF</TD>
</TR>
<TR>
<TD colspan=5><div id='pcurv' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Profile curvature (PCurv) is a derived product of the surface interpolated by the spline algorithm.  Calculation of the PCurv map is completed directly from the interpolation function.  Curvatures are positive for convex and negative for concave areas. Singular points with undefined curvatures have assigned zero values.  The equations for computation of these parameters are described in <a href="http://activetectonics.la.asu.edu/GEONatASU/Data/Mitasova_and_Hofierka_1993.pdf" target="_new">Mitasova and Hofierka 1993</a>.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR>
        <TD colspan=5><HR></TD>
    </TR>
    <TR>
        <TD colspan="5">
        <H3><u>Interpolation Parameters</u></H3>
        </TD>
    </TR>

<TR>
<TD><div id='sresinf' style='display:inline'><a href='javascript:showItem("resinf")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hresinf' style='display:none'><a href='javascript:hideItem("resinf")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
        <TD colspan="2">Grid Resolution (Default=6 ft)</TD>
        <TD colspan="2"><Input type="text" name="resolution"></TD>
</TR>
<TR>
<TD colspan=5><div id='resinf' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Sets the resolution of the Digital Elevation Model (DEM) generated by the interpolation.  Grid resolution is set in the same units as the data set.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR>
        <TD colspan="5">
        <H3><u>Spline Parameters</u></H3>
        </TD>
    </TR>
    <TR>
<TD><div id='sdmininf' style='display:inline'><a href='javascript:showItem("dmininf")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hdmininf' style='display:none'><a href='javascript:hideItem("dmininf")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
        <TD colspan ="2">Enter dmin value (Default=1)</TD>
        <TD colspan="2"><Input type="text" name="dmin"></TD>
    </TR>
<TR>
<TD colspan=5><div id='dmininf' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>Sets minimum distance between points used for the interpolation.  Points closer together than the dmin are ignored.  Dmin is in the same units as the data being interpolated (feet or meters).  If no value is entered here the default value of 1 is used.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR>
<TD><div id='stension' style='display:inline'><a href='javascript:showItem("tension")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='htension' style='display:none'><a href='javascript:hideItem("tension")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
        <TD colspan ="2">Enter spline tension (Default=40)</TD>
        <TD colspan="2"><Input type="text" name="spline_tension"></TD>
    </TR>
<TR>
<TD colspan=5><div id='tension' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>The tension parameter tunes the character of the surface resulting from the spline algorithm from thin plate to membrane.  For most landscape scale applications the default value (40) seems to generate good results.  Surfaces with tension set too high behave like a membrane (rubber sheet stretched over the data points) with peaks or pits at each given point and everywhere else the surface goes rapidly to trend.  Surfaces with tension set too low behave like a stiff steel plate and overshoots can appear in areas with rapid changes of gradient.  Segmentation may also be visible when tension is set too low.  For a more complete discussion of the tension parameter click <a href="http://grass.itc.it/grass61/manuals/html61_user/v.surf.rst.html" target="_new">here</a>.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR>
<TD><div id='ssmooth' style='display:inline'><a href='javascript:showItem("smooth")'><img src='images/letter_i.gif' alt='show details' border=0></a></div><div id='hsmooth' style='display:none'><a href='javascript:hideItem("smooth")'><img src='images/letter_h.gif' alt='hide details' border=0></a></div></TD>
        <TD colspan ="2">Enter spline smoothing (Default=0.1)</TD>
        <TD colspan="2"><Input type="text" name="spline_smoothing"></TD>
    </TR>
<TR>
<TD colspan=5><div id='smooth' style='display:none; padding-top:3;' >
    <TABLE style='font: 12px Verdana;'>
    <tr>
        <td>The smoothing parameter is another way to control the character of the surface interpolated by the spline algorithm.  This parameter is most useful when dealing with noisy data.  With the smoothing parameter set to zero the resulting surface passes exactly through the data points.  The default value is 0.1.  Click <a href="http://grass.itc.it/grass61/manuals/html61_user/v.surf.rst.html" target="_new">here</a> for more information.</td>
    </tr>
</TABLE>
</div></TD></TR>
    <TR>
        <TD colspan=5><HR></TD>
    </TR>
    <TR>
        <TD colspan="5">
        <H3><u>Email Address</u></H3>
        </TD>
    </TR>
    <TR>
        <TD colspan="3">Enter your e-mail address for notification upon completion of processing</TD>
        <TD colspan="2"><Input type="text" name="email" value="<%= user %>"></TD>
    </TR>
    <TR>
        <TD colspan="5"><Input type="hidden" name="user" value="<%= user %>"></TD>
    </TR>
    <TR>
        <TD colspan="5"><HR></TD>
    </TR>
    <TR>
        <TD colspan="2">Enter job title</TD>
        <TD colspan="3"><Input type="text" name="title" value="" size=63 maxlength=100></TD>
    </TR>
    <TR>
        <TD colspan="5">Job description (up to 500 characters):</TD>
    </TR>
    <TR>
        <TD colspan="5"><textarea name="jobDescription" cols=72 rows=6 value="" onkeyup="update();"></textarea></TD>
	<TD colspan="5"><Input type="hidden" name="prevJobDescription" value="" maxlength=500/></TD>
    </TR>
    <TR>
        <TD colspan="5" align="center">
        <INPUT TYPE="button" value="Submit" onClick="submitForm()">
        </TD>
    </TR>
</TABLE>
</form>
<br>
<TABLE>
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
<TABLE width="52%">
<tr><td><hr></td></tr>
<tr><td><A href="http://geon01.sdsc.edu:8405/lidar/jsp/lidar.jsp?email=<%= user %>">Back to the LiDAR main page</td></tr>

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
