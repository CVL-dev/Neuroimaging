<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:template match="/">
    <html>
      <head>
	<title>Drivers Catalog</title>
	<script type="text/javascript">
          function setDBUrl(form)
          {
            var title = form.title.value
            <xsl:for-each select="catalog/driver">
              if (title == "<xsl:value-of select="title"/>") {
              	form.driverName.value = "<xsl:value-of select="name"/>"
	        form.dbURL.value = "<xsl:value-of select="dbURL"/>"
              }
            </xsl:for-each>
          }
	</script>
      </head>
      <body>
  <FORM method="post" action="http://geon01.sdsc.edu:8164/pt2/jsp/pts.jsp">
	<table border="0" width="602" cellspacing="30" cellpadding="0" >
	<tr><td><B>GEON database drivers catalog</B><BR/><BR/>
	Please selcet a database: <BR/> </td></tr>
        <tr><td><select name="title" onChange="setDBUrl(this.form)">
          <xsl:for-each select="catalog/driver">
            <option value = "{title}"><xsl:value-of select="title"/></option>
          </xsl:for-each>
        </select></td></tr>
	<input type="hidden" name="driverName" value="{catalog/driver/name}"/>
	<input type="hidden" name="dbURL" value="{catalog/driver/dbURL}"/>
	<BR/><BR/> <tr><td><INPUT TYPE="submit" VALUE="SUBMIT"/></td></tr>
	</table>

        </FORM>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
