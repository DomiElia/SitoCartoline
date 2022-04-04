<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"> 

    <xsl:output method = "html"/>
    <xsl:param name="id" /> 

    <xsl:template match="tei:teiCorpus">
        <xsl:result-document href="#infolink">
            <div type="c">
                <section id="contLink" class="content_postcard">
                    <h4 class="sectionTitle">
                        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                        <div class="pulsanti">
                            <ul class="ops2">
                                <li><img src="ext/picture.png" alt="img" id="{$id}" class ="open" onclick = "displayImg(this)" ></img></li> 
                                <li><img src="ext/text.png" alt="testo" id="{$id}" class="text" onclick = "displayTesto(this.id)"></img></li>
                                <li><img src="ext/meta.png" alt="link" id="{$id}" class="link" onclick ="displayMeta(this.id)"></img></li> 
                            </ul>
                            <ul class="ops5">
                                <li><img src="ext/indietro.png" alt="indietro" id="{$id}" class ="indietro" onclick = "indietroLink()" ></img> </li>
                                <li><img src="ext/avanti.png" alt="avanti" id="{$id}" class="avanti" onclick ="avantiLink()"></img></li>
                            </ul>
                        </div>
                    </h4>
                    <div class="postcardWrapper">
                        <xsl:apply-templates select="tei:TEI[@xml:id=$id]/tei:facsimile"/> 
                        <xsl:apply-templates select="tei:TEI[@xml:id=$id]" /> 
                    </div>
                </section>
            </div>
        </xsl:result-document> 
    </xsl:template>

    <xsl:template match="tei:TEI">
        <div class="trascrizione">
            <div class="digital">
                <div class="page">
                    <xsl:if test="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:opener/tei:dateline">
                        <p class="dateline manoscritto"><xsl:value-of select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:opener/tei:dateline" /></p>
                    </xsl:if> 
                    <xsl:choose> 
                        <xsl:when test ="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']/tei:p/tei:lb/following-sibling::text()"> 
                            <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']/tei:p/tei:lb/following-sibling::text()" >
                                <p class="manoscritto"><xsl:value-of select="." /> </p>
                            </xsl:for-each> 
                        </xsl:when>
                        <xsl:otherwise>
                            <h3> La cartolina non presenta <br/>  alcun messaggio </h3> 
                        </xsl:otherwise>
                    </xsl:choose> 
                    <xsl:if test="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer/tei:s">
                        <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer/tei:s/tei:lb/following-sibling::text()" >
                            <p class="manoscritto"><xsl:value-of select="." /></p>
                        </xsl:for-each>
                    </xsl:if> 
                    <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer//tei:signed">
                        <p class="manoscritto"><xsl:value-of select="." /></p>
                    </xsl:for-each>
                    <xsl:if test="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer//tei:dateline">
                        <p class="manoscritto"><xsl:value-of select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer//tei:dateline" /></p>
                    </xsl:if>
                </div>
                <xsl:if test="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='address-destination']//tei:addrLine">
                    <div class="page2">
                        <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='address-destination']//tei:addrLine/tei:lb/following-sibling::text()" >
                            <p class="manoscritto"><xsl:value-of select="." /></p>
                        </xsl:for-each>
                    </div>
                </xsl:if>
            </div>
            <div class="metadatazione">
                <div class="meta-tipo">
                    <xsl:if test=".//tei:support//tei:stamp">
                        <p class="tipografia">
                            <span class="label">Timbri e Francobolli:</span>
                        </p>
                    </xsl:if>
                    <xsl:for-each select=".//tei:support//tei:stamp">
                        <p class="tipografia">
                            *
                            <xsl:value-of select="."/>
                        </p>
                    </xsl:for-each>
                </div>
                <div class="meta-tipo2">
                    <p class="tipografia">
                        <span class="label">N° di catalogazione: </span>
                        <xsl:value-of select="normalize-space(tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='secondamano']//tei:add)"/>
                    </p>
                    <xsl:if test=".//tei:front//tei:orgName">
                        <p class="tipografia">
                            <span class="label">Editore cartolina: </span>
                            <xsl:value-of select=".//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher"/>
                        </p>
                    </xsl:if>

                    <xsl:if test=".//tei:front//tei:s">
                        <p class="tipografia">
                            <span class="label">Testo tipografico:</span>
                        </p>
                    </xsl:if>
                    <xsl:for-each select=".//tei:front//tei:s|.//tei:front//tei:ab">
                        <p class="tipografia">
                            <xsl:for-each select="text()|*">
                                <xsl:choose>
                                    <xsl:when test="self::tei:choice">
                                        <xsl:value-of select="tei:abbr"/>
                                    </xsl:when>
                                    <xsl:when test="self::text()|self::*">
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="self::tei:num">
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        </p>
                    </xsl:for-each>
                </div>
            </div>
        </div>
    </xsl:template> 

   <!-- FACSIMILIE -->
    <xsl:template match="tei:TEI[@xml:id=$id]/tei:facsimile"> 
        <img class="scan retro" src="img-cartoline/{$id}R.jpg" title="{$id}"/>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:text />
    </xsl:template>

</xsl:stylesheet>