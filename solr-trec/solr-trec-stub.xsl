<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" indent="yes" />
	
	<xsl:template match="/">
			<xsl:apply-templates select="//result/doc"/>  
	</xsl:template>
	
	<xsl:template match="doc">
		<!-- hier kommt Ihre Lösung hinein -->
	</xsl:template>
	
</xsl:stylesheet>