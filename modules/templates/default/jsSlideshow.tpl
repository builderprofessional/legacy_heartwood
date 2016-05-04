<?php

	// This template contains all of the code necessary to display a javascript slideshow
	// This template requires the bseSlideshow module, it should be named "dynamicSlideshow"
	// Display this template at the location in the page that you want to show the dynamic slideshow
	// Ex: $this->display('jsSlideshow.tpl');
	
	echo "<script type=\"text/javascript\" src=\"{$this->getFileHref('jquery.js')}\"></script>\n";
	echo "<script type=\"text/javascript\" src=\"{$this->getFileHref('jquery.imagesloaded.js')}\"></script>\n";
	echo "<script type=\"text/javascript\" src=\"{$this->dynamicSlideshow->getJavascriptURL($this->rootDir)}?root={$this->rootDir}\"></script>";

?>

    <div id="slideshowBox" style="width:<?php echo $this->dynamicSlideshow->width . $this->dynamicSlideshow->widthUnit; ?>; height:<?php echo $this->dynamicSlideshow->height . $this->dynamicSlideshow->heightUnit; ?>; <?php echo $this->dynamicSlideshow->extraStyle; ?> ">
    	<img id="preloaderImg" src="<?php echo $this->rootDir; ?>images/loading.gif" style="height:120px; width:120px; position:relative; left:50%; top:50%; margin-left:-60px; margin-top:-60px; " /> 
    </div>
