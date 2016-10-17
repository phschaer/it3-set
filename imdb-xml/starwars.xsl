<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="/">
		<imdb>		
			<xsl:apply-templates/>  
		</imdb>
	</xsl:template>
	
	<xsl:template match="movie">
		<movie>
			<title><xsl:value-of select="@title"/></title>
			
			<!-- example of splited text nodes -->
			<xsl:call-template name="tokenizeString">
				<xsl:with-param name="list" select="@actors"/>
				<xsl:with-param name="delimiter" select="','"/>
				<xsl:with-param name="nodename" select="'actor'"/>
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
			
	        <xsl:choose>
	            <xsl:when test="contains($list, $delimiter)">			
					<xsl:element name="{$nodename}">
	                    <!-- get everything in front of the first delimiter -->
	                    <xsl:value-of select="normalize-space(substring-before($list,$delimiter))"/>
					</xsl:element>
	                <xsl:call-template name="tokenizeString">
	                    <!-- store anything left in another variable -->
	                    <xsl:with-param name="list" select="substring-after($list,$delimiter)"/>
	                    <xsl:with-param name="delimiter" select="$delimiter"/>
						<xsl:with-param name="nodename" select="$nodename"/>
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