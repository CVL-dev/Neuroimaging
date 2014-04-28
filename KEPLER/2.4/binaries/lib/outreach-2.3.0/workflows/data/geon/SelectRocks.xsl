<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:template match="/">
    <html>
      <head><title>Virginia Igneous Rock Mineral Composition</title>
        <script type="text/javascript">

    	function Toggle(e)
    	{
            if (e.checked) {
       	        document.sampleList.toggleAll.checked = AllChecked();
            }
            else {
		document.sampleList.toggleAll.checked = false;
            }
    	}

	function ToggleAll(e)
    	{
            if (e.checked) {
	        CheckAll();
	    }
            else {
	        ClearAll();
            }
    	}

    	function Check(e)
    	{
            e.checked = true;
    	}

    	function Clear(e)
    	{
            e.checked = false;
    	}

    	function CheckAll()
    	{
	    var ml = document.sampleList;
            var len = ml.elements.length;
            <![CDATA[
            for (var i = 0; i < len; i++) {
	    	var e = ml.elements[i];
                Check(e);
	    }
            ]]>
            ml.toggleAll.checked = true;
    	}

	function ClearAll()
    	{
            var ml = document.sampleList;
            var len = ml.elements.length;
            <![CDATA[
            for (var i = 0; i < len; i++) {
	    	var e = ml.elements[i];
                Clear(e);
            }
            ]]>
            ml.toggleAll.checked = false;
    	}

    	function AllChecked()
    	{
            var ml = document.sampleList;
            var len = ml.elements.length;
            <![CDATA[
            for(var i = 0 ; i < len ; i++) {
	    	if (ml.elements[i].name == "Sample" && !ml.elements[i].checked) {
		    return false;
	    	}
            }
            ]]>
            return true;
    	}
	</script>
      </head>
      <body>
	<form name="sampleList" method="post" action="http://geon01.sdsc.edu:8164/pt2/jsp/pts.jsp">
      	<table border="1" width="6300">
	<tr bgcolor="#9acd32">
	  <th></th>
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
	  <td><input type="checkbox" name="{ssID}" value="{ssID}" onclick="Toggle(this)" /></td>
	  <td align="right"><xsl:value-of select="ssID"/></td>
          <td align="right"><xsl:value-of select="minssID"/></td>
          <td align="left"><xsl:value-of select="name"/></td>
          <td align="left"><xsl:value-of select="Min_sample_ID"/></td>
	  <xsl:choose>
            <xsl:when test='plagioclase != ""'>
              <td align="right"><xsl:value-of select="plagioclase"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='k-feldspar != ""'>
              <td align="right"><xsl:value-of select="k-feldspar"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='microcline != ""'>
              <td align="right"><xsl:value-of select="microcline"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='quartz != ""'>
              <td align="right"><xsl:value-of select="quartz"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='hornblende != ""'>
              <td align="right"><xsl:value-of select="hornblende"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='magnesio-hornblende != ""'>
              <td align="right"><xsl:value-of select="magnesio-hornblende"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='paragasitic-hornblende != ""'>
              <td align="right"><xsl:value-of select="paragasitic-hornblende"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='clinopyroxene != ""'>
              <td align="right"><xsl:value-of select="clinopyroxene"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='orthopyroxene != ""'>
              <td align="right"><xsl:value-of select="orthopyroxene"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='olivine != ""'>
              <td align="right"><xsl:value-of select="olivine"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='albite != ""'>
              <td align="right"><xsl:value-of select="albite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='tourmaline != ""'>
              <td align="right"><xsl:value-of select="tourmaline"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='amphibole != ""'>
              <td align="right"><xsl:value-of select="amphibole"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='diopsite != ""'>
              <td align="right"><xsl:value-of select="diopsite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='biotite != ""'>
              <td align="right"><xsl:value-of select="biotite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='chlorite != ""'>
              <td align="right"><xsl:value-of select="chlorite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='muscovite != ""'>
              <td align="right"><xsl:value-of select="muscovite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='garnet != ""'>
              <td align="right"><xsl:value-of select="garnet"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='epidote != ""'>
              <td align="right"><xsl:value-of select="epidote"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='talc != ""'>
              <td align="right"><xsl:value-of select="talc"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='actinolite != ""'>
              <td align="right"><xsl:value-of select="actinolite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='allanite != ""'>
              <td align="right"><xsl:value-of select="allanite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='apatite != ""'>
              <td align="right"><xsl:value-of select="apatite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='sphene != ""'>
              <td align="right"><xsl:value-of select="sphene"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='zircon != ""'>
              <td align="right"><xsl:value-of select="zircon"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='monazite != ""'>
              <td align="right"><xsl:value-of select="monazite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='calcite != ""'>
              <td align="right"><xsl:value-of select="calcite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='carbonate != ""'>
              <td align="right"><xsl:value-of select="carbonate"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='zoisite != ""'>
              <td align="right"><xsl:value-of select="zoisite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='clinozoisite != ""'>
              <td align="right"><xsl:value-of select="clinozoisite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='sericite != ""'>
              <td align="right"><xsl:value-of select="sericite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='serpentine != ""'>
              <td align="right"><xsl:value-of select="serpentine"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='spinel != ""'>
              <td align="right"><xsl:value-of select="spinel"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='fluorite != ""'>
              <td align="right"><xsl:value-of select="fluorite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='fluorencite != ""'>
              <td align="right"><xsl:value-of select="fluorencite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='stilpnomelane != ""'>
              <td align="right"><xsl:value-of select="stilpnomelane"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='myrmekite != ""'>
              <td align="right"><xsl:value-of select="myrmekite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='nontronite != ""'>
              <td align="right"><xsl:value-of select="nontronite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='uralite != ""'>
              <td align="right"><xsl:value-of select="uralite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='magnetite != ""'>
              <td align="right"><xsl:value-of select="magnetite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='ilmenite != ""'>
              <td align="right"><xsl:value-of select="ilmenite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='hematite != ""'>
              <td align="right"><xsl:value-of select="hematite"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='rutile != ""'>
              <td align="right"><xsl:value-of select="rutile"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='opaques != ""'>
              <td align="right"><xsl:value-of select="opaques"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='mixed_assemblages != ""'>
              <td align="right"><xsl:value-of select="mixed_assemblages"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='points != ""'>
              <td align="right"><xsl:value-of select="points"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="right">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='methods != ""'>
              <td align="left"><xsl:value-of select="methods"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='rock_type != ""'>
              <td align="left"><xsl:value-of select="rock_type"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
            <xsl:when test='sample_location != ""'>
              <td align="left"><xsl:value-of select="sample_location"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
 	  <xsl:choose>
            <xsl:when test='reference != ""'>
              <td align="left"><xsl:value-of select="reference"/></td>
	    </xsl:when>
	    <xsl:otherwise><td align="left">-</td></xsl:otherwise>
	  </xsl:choose>
        </tr>
    	</xsl:for-each>
        </table>
	<input type="submit" value="OK" />
	</form>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>