<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="utf-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/valgrindoutput">
    <table border="1">        
        <thead>
            <tr>
                <th>Kind</th>
                <th>What</th>
                <th>File</th>
                <th>Line</th>
            </tr>
        </thead>
        <tbody>
            <xsl:apply-templates select="error/stack"/>
        </tbody>
    </table>
 </xsl:template>

<xsl:template match="stack">
    <tr>
        <td><xsl:value-of select="../kind"/></td>
        <td><xsl:value-of select="../what"/></td>
        <td><xsl:value-of select="frame/file"/></td>
        <td><xsl:value-of select="frame/line"/></td>
    </tr>
</xsl:template>

</xsl:stylesheet>