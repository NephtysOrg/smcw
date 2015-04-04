<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:h="namespace:rbary.univ-pau.fr:h" xmlns:f="namespace:rbary.univ-pau.fr:f"
    xmlns:r="namespace:rbary.univ-pau.fr:r" xmlns:general="namespace:rbary.univ-pau.fr:general">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    
    <xsl:variable name="entete" as="xs:string" select="unparsed-text('./entete.txt', 'utf-8')"/>
    <xsl:variable name="fin" as="xs:string" select="unparsed-text('./fin.txt', 'utf-8')"/>
    
    
    <xsl:import-schema schema-location="./general.xsd"/>
    
    
    <xsl:template match="general:root">
        <xsl:value-of select="$entete"/>
        \title{ <xsl:value-of select="//h:section_preambule/h:intitule"/>}
        \date{}
        \maketitle
        \tableofcontents
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
        
        \subsubsection{<xsl:value-of select="../@libelle"/>}
        \paragraph{}
        <xsl:value-of select="."/>\\
        <xsl:apply-templates select="../r:lieux"/>
    </xsl:template>
    
    <xsl:template match="r:lieux">
        <xsl:text>Lieux d'intéret : </xsl:text>
        \begin{itemize}
        <xsl:apply-templates select="r:lieu"/>
        \end{itemize}
    </xsl:template>
    
    <xsl:template match="r:lieu">
        \item {
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        \href{https://www.google.com/maps/?q=<xsl:value-of select="@coord"/>}{(Voir sur map)}
        }
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
    
    <xsl:template match="h:paragraphe|f:acces">
        \paragraph{}
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="f:fiche_technique">
        <xsl:apply-templates select="../h:sous_titre"/>
        \begin{description}
        \item[Information]{<xsl:value-of select="f:information"/>}
        \item[Recommandations]{<xsl:value-of select="f:recommandations"/>}
        \item[Saison(s)]~\\{\begin{itemize}<xsl:apply-templates select="f:epoque/f:saison"/>\end{itemize}}
        \item[Tailles]{<xsl:apply-templates select="f:taille/@*"/>}
        \item[Altitudes]{<xsl:apply-templates select="f:altitude/@*"/>}
        \item[Horaires]{<xsl:apply-templates select="f:horaire/@*"/>}
        \item[Depart]{<xsl:apply-templates select="f:depart/@*"/>}
        \item[Arrivée]{<xsl:apply-templates select="f:arrivee/@*"/>}
        \end{description}
    </xsl:template>
    
    
    <xsl:template match="@*">    
        <xsl:if test="name() != 'unite'">
        <xsl:value-of select="name()"/>:
        <xsl:value-of select="."/>
       <xsl:value-of select="../@unite"/>
       <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="f:epoque">
        \paragraph{}
        <xsl:text>Saison(s) : </xsl:text>
        \begin{itemize}
        <xsl:apply-templates select="f:saison"/>
        \end{itemize}
    </xsl:template>
    
    <!-- Nous avons essayé de produire un template generique, mais sans succes autrement qu'en "bricolant."
    L'idée etait : si dans le noeud courant, il y a seulement des fils de meme noms, on peut construire une liste de time itemize. 
    -->
    <xsl:template match="f:saison|f:carte|f:type_terrain|f:materiel|f:parking|f:type_chemin">
        \item{<xsl:value-of select="."/>}
    </xsl:template>


<!-- Ici, nous avions l'idée dafficher le contenu de chaque noeud n'ayant pas de fils, pour éviter de repeter value-of. Le probleme posé etait que ces noeuds sont soumis a des labels. Par exemple, le noeud <carroyage>toto</carryage> donne  Caroyage : toto\\ . Comment produire alors des labels dynamiques en fonction du noeud... -->
    <xsl:template match="f:fiche_information">
        <xsl:apply-templates select="../h:sous_titre"/>
        \begin{description}
        
        \item[Carte(s)]~\\{
            \begin{itemize}
            <xsl:apply-templates select="f:cartes/f:carte"/>
            \end{itemize}
            }
        
            \item[Carroyage]{<xsl:value-of select="f:carroyage"/>}
            \item[Nom]{<xsl:value-of select="f:nom"/>}
            \item[Aces]{<xsl:value-of select="f:acces"/>}
        
        \item[Parking(s)]~\\{ 
             \begin{itemize}
             <xsl:apply-templates select="f:parkings/f:parking"/>
             \end{itemize}
             }
        
            \item[Type]{<xsl:value-of select="f:type_parcours"/>}
        
        \item[Chemin(s)]~\\{
            \begin{itemize} 
            <xsl:apply-templates select="f:types_chemin/f:type_chemin"/>
            \end{itemize}
            }
            
            \item[Terrain(s)]~\\{
            \begin{itemize}
            <xsl:apply-templates select="f:types_terrain/f:type_terrain"/>
            \end{itemize}
            }
            
            \item[Materiel]~\\{
        \begin{itemize}
        <xsl:apply-templates select="f:liste_materiel/f:materiel"/>
        \end{itemize}
        }
        \end{description}
    </xsl:template>
</xsl:stylesheet>
