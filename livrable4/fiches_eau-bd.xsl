<?xml version="1.0" encoding="UTF-8"?>
<!--Auteur Charles Follet-->
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
            </xsl:analyze-string>
            <xsl:copy-of select="epoque"/>
            <xsl:element name="taille">
                <xsl:attribute name="denivele">
                    <xsl:value-of select="denivele/valeur"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="longueur">
                    <xsl:value-of select="longueur/valeur"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="unite">
                    <xsl:value-of select="denivele/unite"></xsl:value-of>
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="altitude">
                <xsl:attribute name="depart">
                    <xsl:value-of select="alt_dep/valeur"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="arrive">
                    <xsl:value-of select="alt_arr/valeur"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="maximale">
                    <xsl:value-of select="alt_max/valeur"></xsl:value-of>
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="horaire">
                <xsl:attribute name="heure">
                    <xsl:value-of select="horaire/heure"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="minute">
                    <xsl:value-of select="horaire/minute"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="seconde">
                    <xsl:value-of select="horaire/seconde"></xsl:value-of>
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="depart">
                <xsl:attribute name="lieu">
                    <xsl:value-of select="lieu_dep"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="commune">
                    <xsl:value-of select="commune_dep"></xsl:value-of>
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="arrivee">
                <xsl:attribute name="lieu">
                    <xsl:value-of select="lieu_arr"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="commune">
                    <xsl:value-of select="commune_arr"></xsl:value-of>
                </xsl:attribute>
            </xsl:element>
        </fiche_technique>
    </xsl:template>
    
    <xsl:template match="fiche_information">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>