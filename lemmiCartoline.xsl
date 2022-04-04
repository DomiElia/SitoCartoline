<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:tei="http://www.tei-c.org/ns/1.0"
        xmlns = "http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="altroDoc" select="doc('linguA.xml')" />

    <xsl:template match="/">

          <xsl:variable name="id" select="tei:TEI/@xml:id"/>

          <TEI xml:id="{$id}">

            <xsl:copy-of select="tei:TEI/tei:teiHeader"/>
            <xsl:copy-of select="tei:TEI/tei:facsimile"/>

            <text>

              <xsl:copy-of select="tei:TEI/tei:text/tei:front"/>
              <xsl:copy-of select="tei:TEI/tei:text/tei:body"/>

            <xsl:for-each select="$altroDoc/linguistic/analisi">
              <xsl:if test="@id = $id">
              <xsl:variable name="t" select="text()"/>
              <back>
                  <div type="linguistic">
                      <ab>
                      <xsl:for-each select="tokenize($t,'\n')"> <!-- per ogni riga -->
                        <xsl:choose>
                          <xsl:when test="matches( . , '^\s+$') or matches( . , '^$')" /> <!-- riga vuota -->
                          <xsl:otherwise>
                            <xsl:variable name="word" select="tokenize( . ,'\t')" />
                            <seg lemma="{$word[3]}">
                                <w type="form">
                                    <xsl:value-of select="$word[2]"/>
                                </w>
                            </seg>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                      </ab>
                  </div>
            </back>
            </xsl:if>
          </xsl:for-each>
        </text>

      </TEI>

    </xsl:template>

  </xsl:stylesheet>
