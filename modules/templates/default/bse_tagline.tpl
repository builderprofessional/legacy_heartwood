<div id="bse_footer">
<?php
    if( $GLOBALS['useStatistics'] == true && $GLOBALS['bseLinkId'] != "" )
    {
         echo <<< BUSP
    <a href="http://www.bselink.com/index2.php?id={$GLOBALS['bseLinkId']}" target="_blank">Business Partners/Partnership Inquiries</a>
BUSP;
    }
?>
    &copy; <?= date("Y") ?> <a href="http://www.builders-software.com/" target="_blank">Builders Software</a> |
    <a href="http://www.bsewebsites.com/" target="_blank">BSE Websites</a> |
    <a href="Javascript:clickAdminLink();">Website Admin</a>
<?php
    if( $this->moduleInstalled("bseSitemap") )
        echo "
    <a href=\"{$this->rootDir}sitemap.php\" style=\"font-size:90%; font-weight:200; \">(Site Map)</a>
";
?>
</div>
