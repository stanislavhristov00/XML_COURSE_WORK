<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format"
                              xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" version="1.0" indent="yes" />
    <xsl:template match="catalog">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master page-height="297mm" page-width="210mm"
                margin="5mm 25mm 5mm 25mm" master-name="PageMaster">
                    <fo:region-body margin="20mm 0mm 20mm 0mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <xsl:for-each select="./wonders/wonder">
                <fo:page-sequence master-reference="PageMaster">
                    <fo:flow flow-name="xsl-region-body" >
                        <fo:block>
                            <xsl:apply-templates select="." />
                        </fo:block>
                    </fo:flow>
                </fo:page-sequence>
            </xsl:for-each>
        </fo:root>
    </xsl:template>
    <!-- <xsl:template match="wonders">
        <xsl:apply-templates />
    </xsl:template> -->
    <xsl:template match="wonder">
        <fo:block>
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
    <xsl:template match="description">
        <fo:inline font-weight="bold">
            <xsl:apply-templates />
        </fo:inline>
    </xsl:template>
    <xsl:template match="history">
        <fo:inline font-weight="bold">
            <xsl:apply-templates />
        </fo:inline>
    </xsl:template>
    <xsl:template match="images">
    <!-- <xsl:for-each select="./tokenize(@photos, ' ')"> -->
    <fo:block>
        <xsl:for-each select="./image">
            <xsl:variable name="img" select="unparsed-entity-uri(./@src)"/>
                <fo:inline>
                    <fo:external-graphic src="{$img}" content-height="scale-to-fit" height="2.00in"  content-width="2.00in" scaling="non-uniform" />
                </fo:inline>
        </xsl:for-each>
    </fo:block>
    </xsl:template>
</xsl:stylesheet>