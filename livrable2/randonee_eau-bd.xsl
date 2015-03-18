<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output 
        method="xml"
        encoding="UTF-8"
        indent="yes" />
    
    <xsl:template match="/randonnee">
        <randonnee>
        <xsl:apply-templates/>
        </randonnee>
    </xsl:template>
    
    <xsl:template match="etape">
        <xsl:element name="etape">
            <xsl:attribute name="numero"><xsl:value-of select="num_etape"/></xsl:attribute>
            <xsl:attribute name="libelle"><xsl:value-of select="libelle"/></xsl:attribute>

            <xsl:element name="distance">
                <xsl:attribute name="valeur"><xsl:value-of select="distance/valeur"/></xsl:attribute>
                <xsl:attribute name="unite"><xsl:value-of select="distance/unite"/></xsl:attribute>
            </xsl:element>
            <xsl:element name="temps">
                <xsl:attribute name="heure"><xsl:value-of select="temps/heure"/></xsl:attribute>
                <xsl:attribute name="minute"><xsl:value-of select="temps/minute"/></xsl:attribute>
            </xsl:element>
            <xsl:element name="description">
                <xsl:value-of select="description"/>
            </xsl:element>
            <xsl:element name="lieux">
                <xsl:apply-templates select="description/*"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="description/*">
        <xsl:element name="lieu">
            <xsl:attribute name="type"><xsl:value-of select="name()"/></xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>