<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"> 

    <xsl:output method = "html"/>
    <xsl:param name="id" />

    <xsl:template match="tei:teiCorpus">
        <xsl:result-document href="#infotesto">
            <div class="pulsanti">
                <ul class="ops2">
                    <li><img src="ext/picture.png" alt="img" id="{$id}" class ="open" onclick = "displayImg(this)" ></img></li> 
                    <li><img src="ext/link.png" alt="link" id="{$id}" class="link" onclick ="displayLink(this.id)"></img></li> 
                    <li><img src="ext/meta.png" alt="link" id="{$id}" class="link" onclick ="displayMeta(this.id)"></img></li> 
                </ul>
                <ul class="ops3">
                    <li><img src="ext/avanti.png" alt="avanti" id="{$id}" class="avanti" onclick ="avantiTesto()"></img></li>
                </ul> 
            </div>
            <ul class="ops4">
                <li><img src="ext/indietro.png" alt="indietro" id="{$id}" class ="indietro" onclick = "indietroTesto()" ></img> </li>
            </ul>
            <div id="content-text">
                <xsl:apply-templates select="tei:TEI" />
            </div>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="tei:TEI[@xml:id=$id]">
        <div class="blocco"> 
            <h2><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></h2>
                <div class="content_tooltip">
                    <div class="scrittoamano">
                        <div class="apertura">
                            <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']//tei:dateline"/>
                        </div>
                        <br />
                        <div class="testo">
                            <xsl:choose> 
                                <xsl:when test ="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']/tei:p/tei:lb/following-sibling::text()"> 
                                    <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']/tei:p/tei:lb/following-sibling::text()" >
                                        <xsl:value-of select="." />
                                        <br />
                                    </xsl:for-each> 
                                </xsl:when>
                                <xsl:otherwise>
                                    <h3> La cartolina non presenta <br/>  alcun messaggio </h3> 
                                </xsl:otherwise>
                            </xsl:choose> 
                        </div>
                        <br />
                        <div class="chiusura">
                            <xsl:if test="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer/tei:s">
                                <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer/tei:s/tei:lb/following-sibling::text()" >
                                    <xsl:value-of select="." />
                                    <br />
                                </xsl:for-each>
                            </xsl:if>  
                            <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer//tei:signed">
                                <xsl:value-of select="." />
                            </xsl:for-each>
                            <xsl:if test="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer//tei:dateline">
                                <xsl:value-of select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer//tei:dateline" />
                            </xsl:if>
                        </div>
                        <br />
                        <xsl:if test="tei:text/tei:body/tei:div[@type='fronte']/tei:div[@type='message']">
                            <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='fronte']/tei:div[@type='message']/tei:p"/>
                        </xsl:if>
                    </div>
                </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']//tei:dateline">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']/tei:p/tei:choice"> 
        <xsl:value-of select="tei:reg"/>
    </xsl:template>

    <xsl:template match="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer/tei:s/tei:choice"> 
        <xsl:value-of select="tei:reg"/>
    </xsl:template>

    <xsl:template match="tei:unclear">
        <xsl:value-of select="text()"/>
    </xsl:template>

    <xsl:template match="tei:gap">
        <xsl:text>[]</xsl:text>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:text />
    </xsl:template>

</xsl:stylesheet> 

