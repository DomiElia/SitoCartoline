<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT" 
>  

  <xsl:output method = "html"/> 
  <xsl:param name="id" />

  <xsl:template match="/">

     <!--i due titoli-->
     <xsl:result-document href="#title"> 
        <h2><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" /> </h2>
        <h4> Donazione Borghi - <a href="http://etnografico.museilaspezia.it/"><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher/tei:orgName" /></a> </h4>
     </xsl:result-document> 

     <!--box di tutte le cartoline-->
     <xsl:result-document href ="#dialog"> 
          <xsl:for-each select="tei:teiCorpus/tei:TEI">
            <div class="container"> 
            <xsl:variable name="id" select="@xml:id" />
                <div class="thumb" 
                  style="background-image: url('img-cartoline/{$id}F.jpg');" alt="{$id}" id="{$id}" onclick="displayMeta(this.id)" >
                </div>
              <p><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></p>
              <ul class="option"> 
                <li><img src="ext/picture.png" alt="img" id="{$id}" class ="open" onclick = "displayImg(this)" ></img></li> 
                <li><img src="ext/text.png" alt="testo" id="{$id}" class="text" onclick = "displayTesto(this.id)"></img></li>
                <li><img src="ext/link.png" alt="link" id="{$id}" class="link" onclick ="displayLink(this.id)"></img></li>
              </ul>
            </div>
          </xsl:for-each>
     </xsl:result-document> 
     
  </xsl:template>  

</xsl:stylesheet>  
