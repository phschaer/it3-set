<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" indent="yes" />
	
	<xsl:template match="/">
			<xsl:apply-templates select="//result/doc"/>  
	</xsl:template>
	
	<xsl:template match="doc">
<xsl:text>top-001 Q0 </xsl:text>
<xsl:value-of select="str[@name='id']/text()"/>
<xsl:text> </xsl:text>
<xsl:value-of select="position()-1"/> 
<xsl:text> </xsl:text>
<xsl:value-of select="float[@name='score']/text()"/> 
<xsl:text> 0</xsl:text>
<xsl:text>
</xsl:text>
	</xsl:template>
	
</xsl:stylesheet>