<?php 

    $configFile = $this->findFile("template", "tpl_config.inc");
    if( $configFile !== false )
        include($configFile);


?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<!-- Begin header.tpl (This has to be underneath the doctype statement due to bug in IE. The header actually starts with the Doctype statement.) -->

<head>
    <title><?=$this->content->title?></title>
    <meta name="keywords" content="{$this->content->metaKeywords}" />
    <meta name="description" content="{$this->content->metaDesc}" />

    <link rel=StyleSheet type="text/css" href="<?= $this->getFileHref("site_style.css.php") ?>"  media="screen" />
    <link rel="stylesheet" href="<?= $this->getFileHref("shadowbox.css") ?>" type="text/css" media="screen" />
        
    <script type="text/javascript" src="<?= $this->getFileHref("shadowbox.js") ?>"></script>

</head>
<body>
<?php $this->display('admin_header.tpl'); ?>

    <h1>Default Website Info.</h1>

    <h2>Navigation</h2>
    <a href="<?= $this->rootDir ?>">Home</a><br />
    <a href="<?= $this->rootDir ?>about/">About Us</a><br />

<?php


if( $this->moduleInstalled( "bseCommunity" ) )
    echo <<< COMM
    <a href="{$this->rootDir}communities/">Community Locator</a><br />
COMM;

if( $this->moduleInstalled( "bseAvailableHomes" ) )
    echo <<< HOME
    <a href="{$this->rootDir}homes/">Available Homes</a><br />
HOME;

if( $this->moduleInstalled( "bsePhotoGallery" ) )
    echo <<< GAL
    <a href="{$this->rootDir}gallery/">Photo Gallery</a><br />
GAL;

if( $this->moduleInstalled( "bseVideoTube" ) )
    echo <<< VID
    <a href="{$this->rootDir}videos/">Video Gallery</a><br />
VID;

if( $this->moduleInstalled( "bseBrochure" ) )
    echo <<< BRO
    <a href="{$this->rootDir}brochure/">Virtual Brochure</a><br />
BRO;

if( $this->moduleInstalled( "bseBuildProcessItem" ) )
    echo <<< PROC
    <a href="{$this->rootDir}homeplans/">Home Plans</a><br />
PROC;

if( $this->moduleInstalled( "bseRemodelingGalleryImage" ) )
    echo <<< REM
    <a href="{$this->rootDir}remodeling/">Remodeling</a><br />
REM;

if( $this->moduleInstalled( "bseTestimonialItem" ) )
    echo <<< TEST
    <a href="{$this->rootDir}testimonials/">Testimonials</a><br />
TEST;

if( $this->moduleInstalled( "bseContact" ) )
    echo <<< CON
    <a href="{$this->rootDir}contact/">Contact Us</a><br />
CON;

?>



 
<!-- End header.tpl -->

