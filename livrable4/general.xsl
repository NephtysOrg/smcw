<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:h="namespace:rbary.univ-pau.fr:h" xmlns:f="namespace:rbary.univ-pau.fr:f"
    xmlns:r="namespace:rbary.univ-pau.fr:r" xmlns:general="namespace:rbary.univ-pau.fr:general">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    
    <xsl:variable name="entete" as="xs:string" select="unparsed-text('./entete.txt', 'utf-8')"/>
    <xsl:variable name="fin" as="xs:string" select="unparsed-text('./fin.txt', 'utf-8')"/>
    
    
    
    
    
    <xsl:template match="general:root">
        <xsl:value-of select="$entete"/>
        <xsl:apply-templates select="//h:section_preambule"/>
        <xsl:apply-templates select="//h:section_description"/>
        <xsl:apply-templates select="//h:section_thematique"/>
        <xsl:apply-templates select="//h:section_synthese"/>
        <xsl:value-of select="$fin"/>
    </xsl:template>



    <xsl:template match="h:section_preambule">
        \section{Préambule}
        <xsl:apply-templates select="descendant::h:titre"/>
        <xsl:apply-templates select="descendant::h:intitule"/>
        <xsl:apply-templates select="descendant::h:paragraphe"/>
    </xsl:template>
    
    <xsl:template match="h:section_description">
        \section{Description}
        <xsl:apply-templates select="descendant::h:titre"/>
        \begin{table}[h]
        \centering
        \begin{minipage}[t]{.7\linewidth}
        \rule{\linewidth}{1pt}
        <xsl:apply-templates select="descendant::r:etape"/>
        \bigskip
        \rule{\linewidth}{1pt}
        \end{minipage}
        \end{table}
        \newpage
        <xsl:apply-templates select="descendant::r:description"/>
    </xsl:template>
    
    <xsl:template match="h:section_thematique">
        \section{Thématique}
        <xsl:apply-templates select="descendant::h:titre"/>
        <xsl:apply-templates select="descendant::h:paragraphe"/>
    </xsl:template>
    
    <xsl:template match="h:section_synthese">
        \section{Synthese}
        <xsl:apply-templates select="descendant::h:sous_titre"/>
        <xsl:apply-templates select="descendant::f:fiche_technique"/>
        <xsl:apply-templates select="descendant::f:fiche_information"/>
    </xsl:template>

    
    <xsl:template match="r:etape">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="@numero"/>
        <xsl:text>)&#10;</xsl:text>
        <xsl:text>\ytl{</xsl:text>
        <xsl:value-of select="r:distance/@valeur"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="r:distance/@unite"/>
        <xsl:text>}</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="@libelle"/>
        <xsl:text> \\(</xsl:text>
        <xsl:value-of select="r:temps/@heure"/>
        <xsl:text>h </xsl:text>
        <xsl:value-of select="r:temps/@minute"/>
        <xsl:text>m </xsl:text>
        <xsl:text>)</xsl:text>
        <xsl:text>}&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="r:description">
        \paragraph{}
        <xsl:value-of select="../@numero"/>
        <xsl:value-of select="."/>\\
        <xsl:apply-templates select="../r:lieux"/>
    </xsl:template>
    
    <xsl:template match="r:lieux">
        <xsl:text>\emph{Lieux d'intéret : </xsl:text>
        <xsl:apply-templates select="r:lieu"/>
    </xsl:template>
    
    <xsl:template match="r:lieu">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        \href{https://www.google.com/maps/?q=<xsl:value-of select="@coord"/>}{(Voir sur map)}
        <xsl:choose>
            <xsl:when test="position()=last()">
                <xsl:text>}\\~\\&#10;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>, </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="h:titre">
        \subsection{<xsl:value-of select="."/>}
    </xsl:template>
    
    <xsl:template match="h:sous_titre">
        \subsubsection{<xsl:value-of select="."/>}
    </xsl:template>
    
    <xsl:template match="h:intitule">
        \begin{center}
        \textbf{<xsl:value-of select="."/>}
        \end{center}
    </xsl:template>
    
    <xsl:template match="h:paragraphe">
        \paragraph{}
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="f:fiche_technique">
        \paragraph{}
        \emph{Information : }
        <xsl:value-of select="f:information"/>
        \paragraph{}
        \emph{Recommandations : }
        <xsl:value-of select="f:recommandations"/>
        <xsl:value-of select="f:information"/>
        <xsl:apply-templates select="f:epoque"/>
    </xsl:template>
    
    
    <xsl:template match="f:epoque">
        \paragraph{}
        <xsl:text>\emph{Saison(s) : </xsl:text>
        <xsl:apply-templates select="f:saison"/>
    </xsl:template>
    
    <xsl:template match="f:saison">
        <xsl:value-of select="."/>
        <xsl:choose>
            <xsl:when test="position()=last()">
                <xsl:text>}\\~\\&#10;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>, </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
