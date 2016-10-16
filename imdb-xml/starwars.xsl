<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	
	<xsl:template match="/">
		<imdb>		
			<xsl:apply-templates/>  
		</imdb>
	</xsl:template>
	
	<xsl:template match="movie">
		<movie>
			<title><xsl:value-of select="@title"/></title>
			<year><xsl:value-of select="@year"/></year>
		</movie>
	</xsl:template>
	
</xsl:stylesheet>