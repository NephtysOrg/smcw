    <!-- 1  -->
    <!-- Nous avons essayé de produire un template generique, mais sans succes autrement qu'en "bricolant."
    L'idée etait : si dans le noeud courant, il y a seulement des fils de meme noms, on peut construire une liste de type itemize. 
    -->

    <!-- Source -->
    <xsl:template match="f:saison|f:carte|f:type_terrain|f:materiel|f:parking|f:type_chemin">
        \item{<xsl:value-of select="."/>}
    </xsl:template>

    <!-- Application -->
    <f:types_chemin>
        <f:type_chemin>CHEMIN GOUDRONNE</f:type_chemin>
        <f:type_chemin>SENTIER BALISE</f:type_chemin>
    </f:types_chemin>
    <f:types_terrain>
        <f:type_terrain>ZONE AGRICOLE</f:type_terrain>
        <f:type_terrain>ZONE URBAINE</f:type_terrain>
    </f:types_terrain>
    <f:liste_materiel>
        <f:materiel>Jumelles</f:materiel>
        <f:materiel>chaussures de marche</f:materiel>
        <f:materiel>bâtons</f:materiel>
    </f:liste_materiel>
