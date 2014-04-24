<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:template match="/">
    <html>
      <head><title>gravity query results</title></head>
      <body>
      	<table border="1" width="800">
	<tr bgcolor="#9acd32">
	  <th>Lattitued</th>
          <th>Longitude</th>
          <th>Bouguer Annomalities</th>
          <th>Elevation</th>
          <th>Freeair</th>
    	</tr>
    	<xsl:for-each select="result/row">
    	<tr>
	  <xsl:choose>
            <xsl:when test='LATDD != "" and LATDD != "NULL"'>
              <td align="right"><xsl:value-of select="LATDD"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='LONDD != "" and LONDD != "NULL"'>
              <td align="right"><xsl:value-of select="LONDD"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='SIMPLEBA != "" and SIMPLEBA != "NULL"'>
              <td align="right"><xsl:value-of select="SIMPLEBA"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='ELEVATION != "" and ELEVATION != "NULL"'>
              <td align="right"><xsl:value-of select="ELEVATION"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='FREEAIR != "" and FREEAIR != "NULL"'>
              <td align="right"><xsl:value-of select="FREEAIR"/></td>
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