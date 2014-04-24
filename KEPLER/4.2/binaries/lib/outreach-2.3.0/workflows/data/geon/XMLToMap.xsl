<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:template match="/">
    <!-- <CDATA<?xml version="1.0" encoding="UTF-8" ?> -->
    	<table>
    	<xsl:for-each select="result/row">
			<record>
				<spatial>
					<lat><xsl:value-of select="LATDD"/></lat> 
  					<lon><xsl:value-of select="LONDD"/></lon> 
  				</spatial>
				<attributes>
  					<elevation><xsl:value-of select="ELEVATION"/></elevation> 
  					<freeair><xsl:value-of select="FREEAIR"/></freeair> 
  				</attributes>
  			</record>
    	</xsl:for-each>
        </table>
  </xsl:template>
</xsl:stylesheet>