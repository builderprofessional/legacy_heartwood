        <select id="selAdminMenu" onchange="document.location.href=document.getElementById('selAdminMenu').options[document.getElementById('selAdminMenu').selectedIndex].value;">
            <option value="">Select an Option</option>
            <option value="<?= $this->rootDir ?>backdoor.php?module=users">User Management</option>
<?php

    if( $this->moduleInstalled("bseCommunities") )
    {
        echo <<< COMM
            <option value="{$this->rootDir}backdoor.php?module=siteoptions">Site Options</option>
COMM;
    }
    
    if( $this->moduleInstalled("bseContactPage") )
    {
        echo <<< CON
            <option value="{$this->rootDir}backdoor.php?module=contacts">Contact Info</option>
CON;
    }


    if( $this->moduleInstalled("bseAvailableHomes") )
    {
        echo <<< HOMES
            <option value="{$this->rootDir}backdoor.php?module=homes">Available Homes</option>
HOMES;
    }
    
    
    if( $this->moduleInstalled("bseBrochure") )
    {
        echo <<< BROC
            <option value="{$this->rootDir}backdoor.php?module=brochure">Virtual Brochure</option>
BROC;
    }
    
    
    if( $this->moduleInstalled("bseCallNow") )
    {
        echo <<< CALL
            <option value="{$this->rootDir}backdoor.php?module=callnow">Talk Now</option>
CALL;
    }


    if( $this->moduleInstalled("bseTestimonialItem") )
    {
        echo <<< TEST
            <option value="{$this->rootDir}backdoor.php?module=testimony">Testimonials</option>
TEST;
    }
    
    
    
    if( $this->moduleInstalled("bseSitemap") )
    {
        echo <<< SMAP
            <option value="{$this->rootDir}backdoor.php?module=sitemap">Sitemap</option>
SMAP;
    }


    if( $this->moduleInstalled("bseDynamicFlash") )
    {
        echo <<< DYNFLSH
            <option value="{$this->rootDir}backdoor.php?module=dynamicflash">Flash Slideshow</option>
DYNFLSH;
    }
    
    
    if( $this->moduleInstalled("bseSlideshow") )
    {
        echo <<< DYNSHOW
            <option value="{$this->rootDir}backdoor.php?module=jsslideshow">Javascript Slideshow</option>
DYNSHOW;
    }
    
    
    if( $this->moduleInstalled("bseProduct") )
    {
    	echo <<< PROD
    		<option value="{$this->rootDir}backdoor.php?module=products">Products</option>
PROD;
    }
    
    
    
    if( $this->moduleInstaled("bseBuildProcess") )
    {
    	echo <<< PROCESS
    		<option value="{$this->rootDir}backdoor.php?module=process">Build Process</option>
PROCESS;
    }


?>
<!--            <option value="<?= $this->rootDir ?>backdoor.php?module=slider">Scrolling Images</option> -->
<!--            <option value="<?= $this->rootDir ?>backdoor.php?module=quotes">Scrolling Quotes</option> -->
        </select>
