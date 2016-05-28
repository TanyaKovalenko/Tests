<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="utf-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/errors">
    <table border="1">
        <caption>Error summary</caption>
        <thead>
            <tr>
                <th>ID</th>
                <th>File</th>
                <th>Line</th>
            </tr>
        </thead>
        <tbody>
            <xsl:apply-templates select="error/stack"/>
        </tbody>
    </table>
 </xsl:template>

<xsl:template match="errors">
    <tr>
        <td><xsl:value-of select="error/id"/></td>
        <td><xsl:value-of select="location/file"/></td>
	<td><xsl:value-of select="location/line"/></td>
    </tr>
</xsl:template>

</xsl:stylesheet>