<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:template match="/">
    <html>
      <head><title>Virginia Igneous Rock Mineral Composition</title></head>
      <body>
        <table border="1" width="6300">
    <tr bgcolor="#9acd32">
      <th>ssID</th>
          <th>minssID</th>
          <th>name</th>
          <th>Min_sample_ID</th>
          <th>plagioclase</th>
          <th>k-feldspar</th>
          <th>microcline</th>
          <th>quartz</th>
          <th>hornblende</th>
          <th>magnesio-hornblende</th>
          <th>paragasitic-hornblende</th>
          <th>clinopyroxene</th>
          <th>orthopyroxene</th>
          <th>olivine</th>
          <th>albite</th>
          <th>tourmaline</th>
          <th>amphibole</th>
          <th>diopsite</th>
          <th>biotite</th>
          <th>chlorite</th>
          <th>muscovite</th>
          <th>garnet</th>
          <th>epidote</th>
          <th>talc</th>
          <th>actinolite</th>
          <th>allanite</th>
          <th>apatite</th>
          <th>sphene</th>
          <th>zircon</th>
          <th>monazite</th>
          <th>calcite</th>
          <th>carbonate</th>
          <th>zoisite</th>
          <th>clinozoisite</th>
          <th>sericite</th>
          <th>serpentine</th>
          <th>spinel</th>
          <th>fluorite</th>
          <th>fluorencite</th>
          <th>stilpnomelane</th>
          <th>myrmekite</th>
          <th>nontronite</th>
          <th>uralite</th>
          <th>magnetite</th>
          <th>ilmenite</th>
          <th>hematite</th>
          <th>rutile</th>
          <th>opaques</th>
          <th>mixed_assemblages</th>
          <th>points</th>
          <th>methods</th>
          <th>rock type</th>
          <th>sample location</th>
          <th width="200">reference</th>
        </tr>
        <xsl:for-each select="result/row">
        <tr>
      <td align="right"><xsl:value-of select="SSID"/></td>
          <td align="right"><xsl:value-of select="MINSSID"/></td>
          <td align="left"><xsl:value-of select="NAME"/></td>
          <td align="left"><xsl:value-of select="MIN_SAMPLE_ID"/></td>
      <xsl:choose>
            <xsl:when test='PLAGIOCLASE != " "'>
              <td align="right"><xsl:value-of select="PLAGIOCLASE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='K_FELDSPAR != " "'>
              <td align="right"><xsl:value-of select="K_FELDSPAR"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='MICROCLINE != " "'>
              <td align="right"><xsl:value-of select="MICROCLINE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='QUARTZ != " "'>
              <td align="right"><xsl:value-of select="QUARTZ"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='HORNBLENDE != " "'>
              <td align="right"><xsl:value-of select="HORNBLENDE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='MAGNESIO_HORNBLENDE != " "'>
              <td align="right"><xsl:value-of select="MAGNESIO_HORNBLENDE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='PARAGASITIC_HORNBLEN != " "'>
              <td align="right"><xsl:value-of select="PARAGASITIC_HORNBLEN"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='CLINOPYROXENE != " "'>
              <td align="right"><xsl:value-of select="CLINOPYROXENE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ORTHOPYROXENE != " "'>
              <td align="right"><xsl:value-of select="ORTHOPYROXENE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='OLIVINE != " "'>
              <td align="right"><xsl:value-of select="OLIVINE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ALBITE != " "'>
              <td align="right"><xsl:value-of select="ALBITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='TOURMALINE != " "'>
              <td align="right"><xsl:value-of select="TOURMALINE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='AMPHIBOLE != " "'>
              <td align="right"><xsl:value-of select="AMPHIBOLE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='DIOPSITE != " "'>
              <td align="right"><xsl:value-of select="DIOPSITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='BIOTITE != " "'>
              <td align="right"><xsl:value-of select="BIOTITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='CHLORITE != " "'>
              <td align="right"><xsl:value-of select="CHLORITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='MUSCOVITE != " "'>
              <td align="right"><xsl:value-of select="MUSCOVITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='GARNET != " "'>
              <td align="right"><xsl:value-of select="GARNET"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='EPIDOTE != " "'>
              <td align="right"><xsl:value-of select="EPIDOTE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='TALC != " "'>
              <td align="right"><xsl:value-of select="TALC"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ACTINOLITE != " "'>
              <td align="right"><xsl:value-of select="ACTINOLITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ALLANITE != " "'>
              <td align="right"><xsl:value-of select="ALLANITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='APATITE != " "'>
              <td align="right"><xsl:value-of select="APATITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='SPHENE != " "'>
              <td align="right"><xsl:value-of select="SPHENE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ZIRCON != " "'>
              <td align="right"><xsl:value-of select="ZIRCON"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='MONAZITE != " "'>
              <td align="right"><xsl:value-of select="MONAZITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='CALCITE != " "'>
              <td align="right"><xsl:value-of select="CALCITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='CARBONATE != " "'>
              <td align="right"><xsl:value-of select="CARBONATE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ZOISITE != " "'>
              <td align="right"><xsl:value-of select="ZOISITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='CLINOZOISITE != " "'>
              <td align="right"><xsl:value-of select="CLINOZOISITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='SERICITE != " "'>
              <td align="right"><xsl:value-of select="SERICITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='SERPENTINE != " "'>
              <td align="right"><xsl:value-of select="SERPENTINE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='SPINEL != " "'>
              <td align="right"><xsl:value-of select="SPINEL"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='FLUORITE != " "'>
              <td align="right"><xsl:value-of select="FLUORITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='FLUORENCITE != " "'>
              <td align="right"><xsl:value-of select="FLUORENCITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='STILPNOMELANE != " "'>
              <td align="right"><xsl:value-of select="STILPNOMELANE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='MYRMEKITE != " "'>
              <td align="right"><xsl:value-of select="MYRMEKITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='NONTRONITE != " "'>
              <td align="right"><xsl:value-of select="NONTRONITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='URALITE != " "'>
              <td align="right"><xsl:value-of select="URALITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='MAGNETITE != " "'>
              <td align="right"><xsl:value-of select="MAGNETITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ILMENITE != " "'>
              <td align="right"><xsl:value-of select="ILMENITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='HEMATITE != " "'>
              <td align="right"><xsl:value-of select="HEMATITE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='RUTILE != " "'>
              <td align="right"><xsl:value-of select="RUTILE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='OPAQUES != " "'>
              <td align="right"><xsl:value-of select="OPAQUES"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='MIXED_ASSEMBLAGES != " "'>
              <td align="right"><xsl:value-of select="MIXED_ASSEMBLAGES"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='POINTS != " "'>
              <td align="right"><xsl:value-of select="POINTS"/></td>
        </xsl:when>
        <xsl:otherwise><td align="right">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='METHODS != " "'>
              <td align="left"><xsl:value-of select="METHODS"/></td>
        </xsl:when>
        <xsl:otherwise><td align="left">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='ROCK_TYPE != " "'>
              <td align="left"><xsl:value-of select="ROCK_TYPE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="left">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='SAMPLE_LOCATION != " "'>
              <td align="left"><xsl:value-of select="SAMPLE_LOCATION"/></td>
        </xsl:when>
        <xsl:otherwise><td align="left">-</td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
            <xsl:when test='REFERENCE != " "'>
              <td align="left"><xsl:value-of select="REFERENCE"/></td>
        </xsl:when>
        <xsl:otherwise><td align="left">-</td></xsl:otherwise>
      </xsl:choose>
        </tr>
        </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
