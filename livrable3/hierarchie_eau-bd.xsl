<?xml version="1.0" encoding="UTF-8"?>
<!-- Auteur: Roland Bary -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:output 
        method="xml"
        encoding="UTF-8"
        indent="yes" />
    <!--TEMPLATE RACINE (hierarchie)-->
    <xsl:template match="/">
        <hierarchie>
        <xsl:apply-templates select="//section" />
        </hierarchie>
    </xsl:template>
    
    <!--TEMPLATE SECTION-->
    <xsl:template match="section">
        <section>
            <xsl:attribute name="id"><xsl:text>0</xsl:text><xsl:value-of select="position()"/></xsl:attribute>
            <xsl:choose>
                <xsl:when test="position()='01'" >
                    <xsl:attribute name="type"><xsl:text>preambule</xsl:text></xsl:attribute>
                        <xsl:apply-templates select="titre"/>
                        <xsl:apply-templates select="intitule" />
                        <xsl:apply-templates select="paragraphe" />
                </xsl:when>
                <xsl:when test="position()='02'" >

                        <xsl:attribute name="type"><xsl:text>description</xsl:text></xsl:attribute>
                            <xsl:apply-templates select="titre" />
                            <xsl:apply-templates select="sous_section" />
                </xsl:when>
                <xsl:when test="position()=last()" >
                    <xsl:attribute name="type"><xsl:text>synthese</xsl:text></xsl:attribute>
                        <xsl:apply-templates select="sous_section" />  
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="type"><xsl:text>thematique</xsl:text></xsl:attribute>
                        <xsl:apply-templates select="titre" />
                        <xsl:apply-templates select="paragraphe" />
                </xsl:otherwise>
            </xsl:choose>
        </section>
    </xsl:template>
    <!--TEMPLATE TITRE-->
    <xsl:template match="titre">
        <titre><xsl:value-of select="."/></titre>
    </xsl:template>
    
    <!--TEMPLATE SOUS_SECTION-->
    <xsl:template match="sous_section" >
        <sous_section>
            <xsl:attribute name="id"><xsl:value-of select="position()" /></xsl:attribute>
            <xsl:choose>
                <xsl:when test="../titre/. = 'DESCRIPTION'">
                    <xsl:attribute name="type"><xsl:text>description</xsl:text></xsl:attribute>
                    <xsl:apply-templates select="sous_titre" />
                    <xsl:apply-templates select="paragraphe" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="type"><xsl:text>synthese</xsl:text></xsl:attribute>
                    <xsl:apply-templates select="sous_titre" />
                    <xsl:apply-templates select="liste" />   
                </xsl:otherwise>
            </xsl:choose>
        </sous_section>
    </xsl:template>
    <!--TEMPLATE LISTE-->
    <xsl:template match="liste">
        <liste>
            <xsl:text>des items ici</xsl:text>
            <xsl:apply-templates select="item" />
        </liste>
    </xsl:template>
    
    <!--TEMPLATE ITEM-->
    <xsl:template match="item">
        <item>
            <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
            <xsl:choose>
                <xsl:when test="../../sous_titre/.='FICHE TECHNIQUE'">
                    <xsl:attribute name="categorie"><xsl:text>technique</xsl:text></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="categorie"><xsl:text>information</xsl:text></xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="label" />
            <xsl:apply-templates select="descriptif" />
        </item> 
    </xsl:template>
    <!--TEMPLATE LABEL-->
    <xsl:template match="label">
        <label><xsl:value-of select="."/></label>
    </xsl:template>
    
    <!--TEMPLATE DESCRIPTIF-->
    <xsl:template match="descriptif">
        <descriptif><xsl:value-of select="."/></descriptif>
    </xsl:template>
    
    <!--TEMPLATE SOUS_TITRE-->
    <xsl:template match="sous_titre">
        <sous_titre><xsl:value-of select="."/></sous_titre>
    </xsl:template>
    
    <!--TEMPLATE INTITULE-->
    <xsl:template match="intitule">
        <intitule><xsl:value-of select="."/></intitule>
    </xsl:template>
    
    <!--TEMPLATE PARAGRAPHE-->
    <xsl:template match="paragraphe">
        <paragraphe><xsl:value-of select="."/></paragraphe>
    </xsl:template>
    
</xsl:stylesheet>