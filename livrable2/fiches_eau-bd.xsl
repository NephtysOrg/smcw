<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output 
        method="xml"
        encoding="UTF-8"
        indent="yes" />
    
    <xsl:template match="/fiches">
        <fiches>
            <xsl:apply-templates/>
        </fiches>
    </xsl:template>
    
    <xsl:template match="fiche_technique">
        <fiche_technique>
            <information><xsl:value-of select="information"/></information>
            <recommandations><xsl:value-of select="recommandations"/></recommandations>
            <xsl:analyze-string select="difficulte"
                regex="(FACILE|DIFFICILE|MOYEN)">
                <xsl:matching-substring>
                    <difficulte><xsl:value-of select="regex-group(1)"/></difficulte>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <difficulte>
                        <xsl:text>INCONNUE</xsl:text>
                    </difficulte>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
            <xsl:copy-of select="epoque"/>
            <xsl:element name="taille">
                <xsl:attribute name="denivele">
                </xsl:attribute>
            </xsl:element>
        </fiche_technique>
    </xsl:template>
    
    <xsl:template match="fiche_information">
        <fiche_information>

        </fiche_information>
    </xsl:template>
</xsl:stylesheet>