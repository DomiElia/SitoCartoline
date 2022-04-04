<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0"
      xmlns="http://www.w3.org/1999/xhtml"
      xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT" 
      >   

    <xsl:output method = "html"/> 
    
    <xsl:template match="tei:teiCorpus">
        <xsl:result-document href="#lecartoline"> 
            <h2>Le cartoline</h2>
            <div class="general">
                <xsl:for-each select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:p" >
                    <p><xsl:value-of select="." /></p>
                </xsl:for-each>
            </div>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>