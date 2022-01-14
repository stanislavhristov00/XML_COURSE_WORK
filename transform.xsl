<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format"
                              xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" version="1.0" indent="yes" />
    <xsl:template match="catalog">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master page-height="350mm" page-width="210mm"
                margin="5mm 25mm 5mm 25mm" master-name="PageMaster">
                    <fo:region-body margin="20mm 0mm 20mm 0mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <xsl:for-each select="./wonders/wonder">
                <fo:page-sequence master-reference="PageMaster">
                    <fo:flow flow-name="xsl-region-body" >
                        <fo:block>
                            <xsl:apply-templates select="name"/>
                            <xsl:apply-templates select="description" />
                            <xsl:apply-templates select="location"/>
                            <xsl:apply-templates select="history" />
                            <xsl:apply-templates select="images" />
                            <xsl:apply-templates select="availability"/>
                        </fo:block>
                    </fo:flow>
                </fo:page-sequence>
            </xsl:for-each>
        </fo:root>
    </xsl:template>
    <xsl:template match="wonder">
        <fo:block>
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>

    <xsl:template match="name">
        <fo:block font-weight="bold" font-size="11px" margin-bottom="10px" text-align="center">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
    <xsl:template match="location">
        <fo:block margin-bottom="10px" text-align="center">
            <xsl:text>City: </xsl:text><xsl:value-of select="./city" />
            <xsl:text>, Region: </xsl:text><xsl:value-of select="./region" />
            <xsl:text>, Country: </xsl:text><xsl:value-of select="./country" />
        </fo:block>
    </xsl:template>
    <xsl:template match="description">
        <fo:table margin-bottom="10px">
        <fo:table-column column-width="2.80in" column-number="1"/>
        <fo:table-column column-width="4.00in" column-number="2"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block margin-left="11px">
                            <xsl:variable name="img" select="unparsed-entity-uri(../images/image[1]/@src)"/>
                            <fo:external-graphic src="{$img}" content-height="scale-to-fit" height="2.00in"  content-width="2.00in" scaling="non-uniform" />
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:apply-templates />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template match="history">
        <fo:block font-weight="bold" margin-bottom="10px">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
    <xsl:template match="images">
    <fo:block margin-bottom="10px">
        <xsl:for-each select="./image">
            <xsl:if test="position()!=1">
                <xsl:variable name="img" select="unparsed-entity-uri(./@src)"/>
                <fo:inline>
                    <fo:external-graphic src="{$img}" content-height="scale-to-fit" height="2.00in"  content-width="2.00in" scaling="non-uniform" />
                </fo:inline>
            </xsl:if>
        </xsl:for-each>
    </fo:block>
    </xsl:template>
    <xsl:template match="availability">
        <fo:block>
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
</xsl:stylesheet>