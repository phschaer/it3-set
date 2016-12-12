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
			<!-- we recycle the imdbID for our system -->
			<field name="id"><xsl:value-of select="@imdbID"/></field>
			
			<!-- Text data -->
			<field name="title_txt_en"><xsl:value-of select="@title"/></field>
			<field name="plot_txt_en"><xsl:value-of select="@plot"/></field>
			<field name="awards_txt_en"><xsl:value-of select="@awards"/></field>

			<!-- String data -->
			<field name="imdbID_s"><xsl:value-of select="@imdbID"/></field>
			<field name="type_s"><xsl:value-of select="@type"/></field>								
			<field name="year_s"><xsl:value-of select="@year"/></field>			
			<field name="rated_s"><xsl:value-of select="@rated"/></field>
			<field name="released_s"><xsl:value-of select="@released"/></field>
			<field name="runtime_s"><xsl:value-of select="@runtime"/></field>
			<field name="director_s"><xsl:value-of select="@director"/></field>			
			<field name="language_s"><xsl:value-of select="@language"/></field>
			<field name="country_s"><xsl:value-of select="@country"/></field>
			<field name="poster_s"><xsl:value-of select="@poster"/></field>

			<!-- metascore, imdbRating, and imdbVotes might contain non-integer values like N/A -->
			<xsl:if test="not(@metascore='N/A')">
				<field name="metascore_i"><xsl:value-of select="@metascore"/></field>
			</xsl:if>
			<xsl:if test="not(@imdbRating='N/A')">
				<field name="imdbRating_f"><xsl:value-of select="@imdbRating"/></field>
			</xsl:if>	
			<xsl:if test="not(@imdbVotes='N/A')">
				<!-- we use translate to get rid of the comma in the original number format -->
				<field name="imdbVotes_i"><xsl:value-of select="translate(@imdbVotes,',','')"/></field>
			</xsl:if>	

			<!-- This uses an english hyphen: – (only valid using utf-8) -->
			<xsl:if test="contains(@year,'–')">
				<field name="startyear_i"><xsl:value-of select="normalize-space(substring-before(@year,'-'))"/></field>
				<field name="endyear_i"><xsl:value-of select="normalize-space(substring-after(@year,'-'))"/></field>					
			</xsl:if>
			<xsl:if test="not(contains(@year,'–'))">
				<field name="startyear_i"><xsl:value-of select="@year"/></field>
				<field name="endyear_i"><xsl:value-of select="@year"/></field>					
			</xsl:if>
			
			<!-- example of splited text nodes -->
			<!-- actors -->
			<xsl:call-template name="tokenizeString">
				<xsl:with-param name="list" select="@actors"/>
				<xsl:with-param name="delimiter" select="','"/>
				<xsl:with-param name="nodename" select="'field'"/>
				<xsl:with-param name="attribute" select="'actor_ss'"/>
			</xsl:call-template>
			
			<!-- genre -->
			<xsl:call-template name="tokenizeString">
				<xsl:with-param name="list" select="@genre"/>
				<xsl:with-param name="delimiter" select="','"/>
				<xsl:with-param name="nodename" select="'field'"/>
				<xsl:with-param name="attribute" select="'genre_ss'"/>
			</xsl:call-template>			
			
			<!-- writer -->
			<xsl:call-template name="tokenizeString">
				<xsl:with-param name="list" select="@writer"/>
				<xsl:with-param name="delimiter" select="','"/>
				<xsl:with-param name="nodename" select="'field'"/>
				<xsl:with-param name="attribute" select="'writer_ss'"/>
			</xsl:call-template>	
							
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
								<xsl:attribute name="name"><xsl:value-of select="$attribute"/></xsl:attribute>
	                            <xsl:value-of select="normalize-space($list)"/>
	                        </xsl:element>
	                    </xsl:otherwise>
	                </xsl:choose>
	            </xsl:otherwise>
	        </xsl:choose>
	    </xsl:template>  
	
</xsl:stylesheet>