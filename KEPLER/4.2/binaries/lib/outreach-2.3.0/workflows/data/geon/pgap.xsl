<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:template match="/">
    <html>
      <head><title>pgap</title></head>
      <body>
      	<table border="1" width="4500">
	<tr bgcolor="#9acd32">
	  <th>LOC_NO</th>
          <th>LAT_DEC</th>
          <th>LONG_DEC</th>
          <th>ERA</th>
          <th>EMLPERIOD_MAX</th>
          <th>PERIOD_MAX</th>
          <th>EMLPERIOD_MIN</th>
          <th>PERIOD_MIN</th>
          <th>STAGE_MAX</th>
          <th>STAGE_MIN</th>
          <th>CONTINENT</th>
          <th>COUNTRY</th>
          <th>STATE_PROVINCE</th>
          <th>PAPER_NO</th>
          <th>LITH_NO</th>
          <th>LOC_NO</th>
          <th>LITH_CODE</th>
          <th>COUNTRY</th>
          <th>STATE</th>
          <th>AREA_CODE</th>
          <th>LAT_DEC</th>
          <th>LNG_DEC</th>
          <th>AGE_TOP</th>
          <th>AGE_BOT</th>
          <th>BOOK</th>
          <th>PLATE_CODE</th>
          <th>PGAP_ENVI1</th>
          <th>PGAP_ENVI2</th>
          <th>FACIES</th>
          <th>FORMATION_NAME</th>
          <th>STRAT_RELIABILITY</th>
          <th>GEO_RELIABILITY</th>
          <th>INVESTIGATOR</th>
          <th>DATE_OF_ENTRY</th>
          <th>DATE_OF_MODIFIED</th>
          <th>COMMENTS</th>
          <th>LOC_NO</th>
          <th>DATE_CREATED</th>
          <th>DATE_MODIFIED</th>
    	</tr>
    	<xsl:for-each select="result/row">
    	<tr>
	  <xsl:choose>
            <xsl:when test='LOC_NO != "" and LOC_NO != "NULL"'>
              <td align="right"><xsl:value-of select="LOC_NO"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LAT_DEC != "" and LAT_DEC != "NULL"'>
              <td align="right"><xsl:value-of select="LAT_DEC"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LONG_DEC != "" and LONG_DEC != "NULL"'>
              <td align="right"><xsl:value-of select="LONG_DEC"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='ERA != "" and ERA != "NULL"'>
              <td align="left"><xsl:value-of select="ERA"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='EMLPERIOD_MAX != "" and EMLPERIOD_MAX != "NULL"'>
              <td align="left"><xsl:value-of select="EMLPERIOD_MAX"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='PERIOD_MAX != "" and PERIOD_MAX != "NULL"'>
              <td align="left"><xsl:value-of select="PERIOD_MAX"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='EMLPERIOD_MIN != "" and EMLPERIOD_MIN != "NULL"'>
              <td align="left"><xsl:value-of select="EMLPERIOD_MIN"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='PERIOD_MIN != "" and PERIOD_MIN != "NULL"'>
              <td align="left"><xsl:value-of select="PERIOD_MIN"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='STAGE_MAX != "" and STAGE_MAX != "NULL"'>
              <td align="left"><xsl:value-of select="STAGE_MAX"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='STAGE_MIN != "" and STAGE_MIN != "NULL"'>
              <td align="left"><xsl:value-of select="STAGE_MIN"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='CONTINENT != "" and CONTINENT != "NULL"'>
              <td align="left"><xsl:value-of select="CONTINENT"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='COUNTRY != "" and COUNTRY != "NULL"'>
              <td align="left	"><xsl:value-of select="COUNTRY"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='STATE_PROVINCE != "" and STATE_PROVINCE != "NULL"'>
              <td align="left"><xsl:value-of select="STATE_PROVINCE"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='PAPER_NO != "" and PAPER_NO != "NULL"'>
              <td align="right"><xsl:value-of select="PAPER_NO"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LITH_NO != "" and LITH_NO != "NULL"'>
              <td align="right"><xsl:value-of select="LITH_NO"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LOC_NO1 != "" and LOC_NO1 != "NULL"'>
              <td align="right"><xsl:value-of select="LOC_NO1"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LITH_CODE != "" and LITH_CODE != "NULL"'>
              <td align="left"><xsl:value-of select="LITH_CODE"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='COUNTRY1 != "" and COUNTRY1 != "NULL"'>
              <td align="left"><xsl:value-of select="COUNTRY1"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='STATE != "" and STATE != "NULL"'>
              <td align="left"><xsl:value-of select="STATE"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='AREA_CODE != "" and AREA_CODE != "NULL"'>
              <td align="right"><xsl:value-of select="AREA_CODE"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LAT_DEC1 != "" and LAT_DEC1 != "NULL"'>
              <td align="right"><xsl:value-of select="LAT_DEC1"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LNG_DEC != "" and LNG_DEC != "NULL"'>
              <td align="right"><xsl:value-of select="LNG_DEC"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='AGE_TOP != "" and AGE_TOP != "NULL"'>
              <td align="right"><xsl:value-of select="AGE_TOP"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='AGE_BOT != "" and AGE_BOT != "NULL"'>
              <td align="right"><xsl:value-of select="AGE_BOT"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='BOOK != "" and BOOK != "NULL"'>
              <td align="left"><xsl:value-of select="BOOK"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='PLATE_CODE != "" and PLATE_CODE != "NULL"'>
              <td align="right"><xsl:value-of select="PLATE_CODE"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='PGAP_ENVI1 != "" and PGAP_ENVI1 != "NULL"'>
              <td align="right"><xsl:value-of select="PGAP_ENVI1"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='PGAP_ENVI2 != "" and PGAP_ENVI2 != "NULL"'>
              <td align="right"><xsl:value-of select="PGAP_ENVI2"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='FACIES != "" and FACIES != "NULL"'>
              <td align="left"><xsl:value-of select="FACIES"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='FORMATION_NAME != "" and FORMATION_NAME != "NULL"'>
              <td align="left"><xsl:value-of select="FORMATION_NAME"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='STRAT_RELIABILITY != "" and STRAT_RELIABILITY != "NULL"'>
              <td align="left"><xsl:value-of select="STRAT_RELIABILITY"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='GEO_RELIABILITY != "" and GEO_RELIABILITY != "NULL"'>
              <td align="left"><xsl:value-of select="GEO_RELIABILITY"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='INVESTIGATOR != "" and INVESTIGATOR != "NULL"'>
              <td align="left"><xsl:value-of select="INVESTIGATOR"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='DATE_OF_ENTRY != "" and DATE_OF_ENTRY != "NULL"'>
              <td align="center"><xsl:value-of select="DATE_OF_ENTRY"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='DATE_OF_MODIFIED != "" and DATE_OF_MODIFIED != "NULL"'>
              <td align="center"><xsl:value-of select="DATE_OF_MODIFIED"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='COMMENTS != "" and COMMENTS != "NULL"'>
              <td align="left"><xsl:value-of select="COMMENTS"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LOC_NO2 != "" and LOC_NO2 != "NULL"'>
              <td align="right"><xsl:value-of select="LOC_NO2"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='DATE_CREATED != "" and DATE_CREATED != "NULL"'>
              <td align="center"><xsl:value-of select="DATE_CREATED"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='DATE_MODIFIED != "" and DATE_MODIFIED != "NULL"'>
              <td align="center"><xsl:value-of select="DATE_MODIFIED"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="center">-</td></xsl:otherwise>
	  </xsl:choose>
        </tr>
    	</xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>