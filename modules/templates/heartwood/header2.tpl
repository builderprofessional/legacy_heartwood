<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<!-- Begin header.tpl (This has to be underneath the doctype statement due to bug in IE. The header actually starts with the Doctype statement.) -->

<head>
    <title><?=$this->content->title?></title>
    <meta name="keywords" content="<?= $this->content->metaKeywords ?>" />
    <meta name="description" content="<?= $this->content->metaDesc ?>" />

    <link rel="canonical" href="http://www.heartwoodcustomhomes.com/<?= $this->curPage ?>" />
    <link rel=StyleSheet type="text/css" href="<?= $this->getFileHref("site_style.css.php") ?>"  media="screen" />
    <link rel="stylesheet" href="<?= $this->getFileHref("shadowbox.css") ?>" type="text/css" media="screen" />
        
    <script type="text/javascript" src="<?= $this->getFileHref("shadowbox.js") ?>"></script>
    <script type="text/javascript" src="<?php echo $this->getFileHref("jquery.js"); ?>"></script>

</head>
<body>
<script type="text/javascript" src="<?php echo $this->getFileHref("wz_tooltip.js"); ?>"></script>

<?php $this->display('jsSlideshow.tpl'); ?>
<?php $this->display('admin_header.tpl'); ?>
<?php $this->display('menu.tpl'); ?>

	<div style="position:absolute; z-index:1; left:500px; width:950px; top:40px; ">
		<div class="content">
	
 
<!-- End header.tpl -->

