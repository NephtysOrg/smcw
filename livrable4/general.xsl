<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:r="bd__randonnee.xsd"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:text>\documentclass{article}&#10;</xsl:text>
        <xsl:text>\usepackage[utf8]{inputenc}&#10;</xsl:text>
        <xsl:text>\usepackage[francais]{babel}&#10;</xsl:text>
        <xsl:text>\usepackage{hyperref}</xsl:text>
        <xsl:text>\usepackage{xcolor}&#10;</xsl:text>
        <xsl:text>\newcommand\ytl[2]{
\parbox[b]{8em}{\hfill{\color{cyan}\bfseries\sffamily #1}~$\cdots\cdots$~}\makebox[0pt][c]{$\bullet$}\vrule\quad \parbox[c]{4.5cm}{\vspace{7pt}\color{red!40!black!80}\raggedright\sffamily #2.\\[7pt]}\\[-3pt]}&#10;</xsl:text>
        <xsl:text>\begin{document}</xsl:text>
        <xsl:text>\section{</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>}&#10;</xsl:text>
        <xsl:text>
        \begin{table}[h]&#10;
        \centering&#10;
        \begin{minipage}[t]{.7\linewidth}&#10;
        \color{gray}&#10;
        \rule{\linewidth}{1pt}&#10;
        </xsl:text>
        <xsl:apply-templates select="//r:etape"/>
        <xsl:text>
            \bigskip&#10;
            \rule{\linewidth}{1pt}&#10;
            \end{minipage}&#10;
            \end{table}&#10;
        </xsl:text>
        <xsl:apply-templates select="//r:etape//r:description"/>
        <xsl:text>\end{document}</xsl:text>
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
        <xsl:value-of select="temps/@minute"/>
        <xsl:text>m </xsl:text>
        <xsl:text>)</xsl:text>
        <xsl:text>}&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="r:description">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="../../@numero"/>
        <xsl:text>)\indent</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>\\</xsl:text>
        <xsl:apply-templates select="../r:lieux"/>
    </xsl:template>

    <xsl:template match="r:lieux">
        <xsl:text>\emph{Lieux d'intéret : </xsl:text>
        <xsl:apply-templates select="r:lieu"/>
    </xsl:template>

    <xsl:template match="r:lieu">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text> \href{https://www.google.com/maps/?q=<xsl:value-of select="@coord"
        />}{(Voir sur map)} <xsl:choose>
            <xsl:when test="position()=last()">
                <xsl:text>}\\~\\&#10;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>, </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>