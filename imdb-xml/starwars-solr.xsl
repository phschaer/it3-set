<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="/">
		<add>		
			<xsl:apply-templates/>  
		</add>
	</xsl:template>
	
	<xsl:template match="movie">
		<doc>			
			<field name="title_t"><xsl:value-of select="@title"/></field>
			<field name="year_s"><xsl:value-of select="@year"/></field>
			<field name="rated_s"><xsl:value-of select="@rated"/></field>
			<field name="released_s"><xsl:value-of select="@released"/></field>
			<field name="runtime_s"><xsl:value-of select="@runtime"/></field>
			<field name="genre_s"><xsl:value-of select="@genre"/></field>
			<field name="director_s"><xsl:value-of select="@director"/></field>
			<field name="writer_s"><xsl:value-of select="@writer"/></field>
			<field name="plot_t"><xsl:value-of select="@plot"/></field>
			<field name="language_s"><xsl:value-of select="@language"/></field>
			<field name="country_s"><xsl:value-of select="@country"/></field>
			<field name="awards_t"><xsl:value-of select="@awards"/></field>
			<field name="poster_s"><xsl:value-of select="@poster"/></field>
			<field name="metascore_i"><xsl:value-of select="@metascore"/></field>
			<field name="imdbRating_f"><xsl:value-of select="@imdbRating"/></field>
			<field name="imdbVotes_i"><xsl:value-of select="@imdbVotes"/></field>
			<field name="imdbID_s"><xsl:value-of select="@imdbID"/></field>
			<field name="type_s"><xsl:value-of select="@type"/></field>			
			
			<!-- example of splited text nodes -->
			<xsl:call-template name="tokenizeString">
				<xsl:with-param name="list" select="@actors"/>
				<xsl:with-param name="delimiter" select="','"/>
				<xsl:with-param name="nodename" select="'field'"/>
				<xsl:with-param name="attribute" select="'actor_ss'"/>
			</xsl:call-template>
			
			<!-- -->
				
		</doc>
	</xsl:template>
	
	<!--############################################################-->
	<!--## Template to tokenize strings                           ##-->
	<!--## http://www.heber.it/?p=1088							  ##-->
	<!--############################################################-->
	<xsl:template name="tokenizeString">
	
	<!--passed template parameter -->
	
	        <xsl:param name="list"/>
	        <xsl:param name="delimiter"/>
			<xsl:param name="nodename"/>
			<xsl:param name="attribute"/>
			
	        <xsl:choose>
	            <xsl:when test="contains($list, $delimiter)">			
					<xsl:element name="{$nodename}">
						<xsl:attribute name="name"><xsl:value-of select="$attribute"/></xsl:attribute>						
	                    <!-- get everything in front of the first delimiter -->
	                    <xsl:value-of select="normalize-space(substring-before($list,$delimiter))"/>
					</xsl:element>
	                <xsl:call-template name="tokenizeString">
	                    <!-- store anything left in another variable -->
	                    <xsl:with-param name="list" select="substring-after($list,$delimiter)"/>
	                    <xsl:with-param name="delimiter" select="$delimiter"/>
						<xsl:with-param name="nodename" select="$nodename"/>
						<xsl:with-param name="attribute" select="$attribute"/>
	                </xsl:call-template>
	            </xsl:when>
	            <xsl:otherwise>
	                <xsl:choose>
	                    <xsl:when test="$list = ''">
	                        <xsl:text/>
	                    </xsl:when>
	                    <xsl:otherwise>
	                        <xsl:element name="{$nodename}">
	                            <xsl:value-of select="normalize-space($list)"/>
	                        </xsl:element>
	                    </xsl:otherwise>
	                </xsl:choose>
	            </xsl:otherwise>
	        </xsl:choose>
	    </xsl:template>  
	
</xsl:stylesheet>