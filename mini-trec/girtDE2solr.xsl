<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="/">
		<add>		
			<xsl:apply-templates/>  
		</add>
	</xsl:template>
	
	<xsl:template match="DOC">
		<doc>	
			<field name="collection_s">girtDE</field>					
			<field name="id"><xsl:value-of select="DOCNO/text()"/></field>
			<field name="title_txt"><xsl:value-of select="TITLE-DE/text()"/></field>
			<field name="pubyear_s"><xsl:value-of select="PUBLICATION-YEAR/text()"/></field>
			<field name="lang_s"><xsl:value-of select="LANGUAGE-CODE/text()"/></field>
			<field name="abstract_txt"><xsl:value-of select="ABSTRACT-DE/text()"/></field>
			
			<!-- apply templates for multivalued fields -->
			<xsl:apply-templates select="AUTHOR"/>  
			<xsl:apply-templates select="CONTROLLED-TERM-DE"/>  
			<xsl:apply-templates select="METHOD-TERM-DE"/>  
			<xsl:apply-templates select="CLASSIFICATION-TEXT-DE"/>  
		</doc>
	</xsl:template>
	
	<xsl:template match="AUTHOR">
		<field name="author_ss"><xsl:value-of select="text()"/></field>
	</xsl:template>

	<xsl:template match="CONTROLLED-TERM-DE">
		<field name="controlledterm_txt"><xsl:value-of select="text()"/></field>
	</xsl:template>			

	<xsl:template match="METHOD-TERM-DE">
		<field name="method_txt"><xsl:value-of select="text()"/></field>
	</xsl:template>			

	<xsl:template match="CLASSIFICATION-TEXT-DE">
		<field name="classificiation_txt"><xsl:value-of select="text()"/></field>
	</xsl:template>			



</xsl:stylesheet>