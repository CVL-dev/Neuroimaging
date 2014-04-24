<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:template match="/">
    <html>
      <head><title>XSLT Sample</title></head>
      <body>
         <h2>The Sequence for the Given Gene is: </h2>
                <ul>
                  <li>
						<xsl:value-of select="DDBJXML/SEQUENCE"/> 
                  </li>
                </ul> 
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
