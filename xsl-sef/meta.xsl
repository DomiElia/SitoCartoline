<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT" 
>  

    <xsl:output method = "html"/>
    <xsl:param name="id"/> 

    <xsl:template match="tei:teiCorpus">
        <xsl:result-document href="#meta"> 
            <xsl:apply-templates select = "tei:TEI"/> 
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="tei:TEI[@xml:id=$id]"> 
        <div class="metadatiC">
            <h2><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></h2>
            <div class="box">
                <div class="thumb2" 
                  style="background-image: url('img-cartoline/{$id}F.jpg');" alt="{$id}" id="{$id}" onclick="displayMeta(this.id)" >
                </div>
                <ul class="ops">
                    <li><img src="ext/picture.png" alt="img" id="{$id}" class ="open" onclick = "displayImg(this)" ></img></li> 
                    <li><img src="ext/text.png" alt="testo" id="{$id}" class="text" onclick = "displayTesto(this.id)"></img></li>
                    <li><img src="ext/link.png" alt="link" id="{$id}" class="link" onclick ="displayLink(this.id)"></img></li> 
                </ul>
            </div>
            
            <div class="boxTesto">
                <h3>Informazioni sull'opera d'arte</h3>
                <p>Titolo: <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></p>
                <p>Autore dell'illustrazione:
                    <xsl:choose>
                        <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:author">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:author" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>---</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
                <p>Descrizione:
                    <xsl:choose>
                        <xsl:when test="tei:text/tei:body/*/tei:figure/tei:figDesc">
                            <xsl:value-of select="tei:text/tei:body/*/tei:figure/tei:figDesc" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>---</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
                <h3>Informazioni identificative della cartolina</h3>
                <p>Editore:
                    <xsl:choose>
                        <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:publisher">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:publisher" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>---</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
                <p>Luogo di publicazione:
                    <xsl:choose>
                        <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:pubPlace">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:pubPlace" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>---</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
                <p>Data di publicazione:
                    <xsl:choose>
                        <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:date">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:date" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>---</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
                <p>Dimensioni: <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:height" /> x <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:width" /> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/@unit"/></p>
                <p>Codice identificativo: <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno"  /></p>
                <p>Collocazione: <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository" /></p>
                <ul class="ops6">
                    <li><img src="ext/indietro.png" alt="indietro" id="{$id}" class ="indietro" onclick = "indietroMeta()" ></img> </li>
                    <li><img src="ext/avanti.png" alt="avanti" id="{$id}" class="avanti" onclick ="avantiMeta()"></img></li>
                </ul>
            </div>
            
        </div>

    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:apply-templates />
    </xsl:template> 

    <xsl:template match="@*|node()">
        <xsl:text />
    </xsl:template> 

</xsl:stylesheet>