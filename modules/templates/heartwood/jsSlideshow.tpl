<?php

    // This template contains all of the code necessary to display a javascript slideshow
    // This template requires the bseSlideshow module, it should be named "dynamicSlideshow"
    // Display this template at the location in the page that you want to show the dynamic slideshow
    // Ex: $this->display('jsSlideshow.tpl');
    
    //echo "<script type=\"text/javascript\" src=\"{$this->getFileHref('jquery.imagesloaded.js')}\"></script>\n";
    //echo "<script type=\"text/javascript\" src=\"{$this->dynamicSlideshow->getJavascriptURL($this->rootDir)}?root=" . urlencode($this->rootDir) . "\"></script>\n";

    /* Preloader image tag was put in the div tag below, but is temporarily/permenantly removed (a greater than '>' must be put after the question mark '?' in the src property below.)
    <img id="preloaderImg" src="<?php echo $this->rootDir; ?images/loading.gif" style="height:120px; width:120px; position:relative; left:50%; top:50%; margin-left:-60px; margin-top:-60px; " /> 
    */
    
    $count = 0;
    $switch = 1;
    $picIndex = null;
    
    if( $this->dynamicSlideshow->singleRandom )
    {
        // Get a different single random image than the previous page
        if( !isset($_SESSION['prevSlideImage']) ){ $_SESSION['prevSlideImage'] = -1; }
        $picIndex = rand(0, $this->dynamicSlideshow->images->count() - 1);
        if( $picIndex == $_SESSION['prevSlideImage'] ){ $picIndex++; }
        if( $picIndex > $this->dynamicSlideshow->images->count() - 1 ){ $picIndex = 0; };
    }
?>
<script type="text/javascript" src="<?= $this->getFileHref("jquery.imagesloaded.js") ?>"></script>
<script type="text/javascript" src="<?= $this->getFileHref("jquery.cycle.all.js") ?>"></script>
<script type="text/javascript">

    var curSlide = null;
    var dynamicSlideIndex = 0;
    var slidePaused = false;

    $(document).ready(function()
    {
        $('#slideshowBox img:first').imagesLoaded( function()
        {
            beforeTransitionImage(null, $('#slideshowBox img:first')[0], null, null, true);
            $('#slideshowBox img:first')[0].style.display = 'none';
            $('#slideshowBox img:first')[0].style.visibility = 'visible';
            $('#slideshowBox img:first').fadeIn(750, function()
            {
                $(window).resize( function(){ if( curSlide != null ){ beforeTransitionImage(null, curSlide, null, null, true); } } );
                
                $('#slideshowBox').cycle(
                { 
                    fx:    'fade', 
                    timeout:  <?= $this->dynamicSlideshow->duration * 1000 ?>,
                    containerResize: 0,
                    slideResize: false,
                    speed:1000,
                    //delay:300,
                    resumed: function(cont, opts, byHover) {
                        slidePaused = false;
                    },
                    before: beforeTransitionImage
                });
                
                setTimeout(function()
                {
                    $('#preloaderImg').remove();
                },
                1800);

            });
        });
        
    <?php if( !$this->dynamicSlideshow->singleRandom ): ?>

            
        setTimeout(function()
        {
            $(window).blur( function(){ $('#slideshowBox').cycle('pause'); });
            $(window).focus( function(){ if( slidePaused == false ){ $('#slideshowBox').cycle('resume'); setTimeout(function(){$('#slideshowBox').cycle('next') }, 400); } });
        },
        350);
        
    <?php endif; ?>
    });
    
    
    
    function beforeTransitionImage(currSlideElement, nextSlideElement, opts, forwardFlag, keepHidden)
    {
        if( typeof(keepHidden) == 'undefined' )
            keepHidden = false;
        
        nextSlideElement.style.display = "block";
        if( $('#preloaderImg') )
        {
            //$('#preloaderImg').remove();
        }
        var img = nextSlideElement;
        boxWidth = Math.floor($('#slideshowBox').width());
        boxHeight = Math.floor($('#slideshowBox').height());
        

        var boxRatio = boxWidth / boxHeight;
        var imgRatio = img.offsetWidth / img.offsetHeight;
        
        // Check for image height / width proportions fitting to the window
        
        // if the resized image's width is less than the container's width, then
        // resize the image's width to the container's width
        if( ( boxHeight * imgRatio ) <= boxWidth )
        {
            nextSlideElement.style.height = "auto";
            nextSlideElement.style.width = boxWidth + "px";
            nextSlideElement.style.left = 0;
            //alert("Resized width to " + boxWidth + " pixels.");
        }
        
        // if the resized image's height is less than the container's height, then resize the image's height to the container's height
        else if( ( boxWidth / imgRatio ) <= boxHeight )
        {
            nextSlideElement.style.width = "auto";
            nextSlideElement.style.height = boxHeight + "px";
            nextSlideElement.style.left = (boxWidth - img.offsetWidth) / 2 + 'px';
            //alert("Resized height to " + boxHeight + " pixels.");
        }
        
        else
        {
            nextSlideElement.style.height = "auto";
            nextSlideElement.style.width = boxWidth + "px";
            nextSlideElement.style.left = 0;
            //alert("Resized width to " + boxWidth + " pixels.");
        }
        
        curSlide = nextSlideElement;
        if( !keepHidden )
            nextSlideElement.style.visibility = 'visible';
        
        
        // ******** Add slides dynamically ********* //
        // on the first pass, addSlide is undefined (plugin hasn't yet created the fn); 
        // when we're finshed adding slides we'll null it out again 
        if( opts == null )
            return;
        if (!opts.addSlide)
            return; 
 
        if( typeof(newImages) != 'undefined' )
        {
            if (dynamicSlideIndex >= newImages.length )
            { 
                // final slide in our slide slideshow is about to be displayed 
                // so there are no more to fetch 
                opts.addSlide = null; 
                return; 
            } 
             
            // add our next slide 
            opts.addSlide('<img src="' + newImages[dynamicSlideIndex++] + '" />'); 
        }
    }
    
</script>

    <div style="position:absolute; width:100%; height:100%; z-index:-1; ">
        <div id="slideshowBox" style="width:<?php echo $this->dynamicSlideshow->width . $this->dynamicSlideshow->widthUnit; ?>; height:<?php echo $this->dynamicSlideshow->height . $this->dynamicSlideshow->heightUnit; ?>; <?php echo $this->dynamicSlideshow->extraStyle; ?> ">
<?php foreach( $this->dynamicSlideshow->images as $img ):
                if( $this->dynamicSlideshow->singleRandom ):
                    if( $count == $picIndex ): ?>
            <img src="<?= $img->getImageHref() ?>" />
<?php
                        break; 
                    endif;
                elseif( $count < 2 ): ?>
            <img src="<?= $img->getImageHref() ?>" />
<?php elseif( $count == 2 && !$this->dynamicSlideshow->singleRandom ): ?>
        </div>
        <script type="text/javascript">
            var newImages = new Array();
            newImages[0] = "<?= $img->getImageHref() ?>";
<?php else: ?>
            newImages[newImages.length] = "<?= $img->getImageHref() ?>";
<?php endif;
                $count++;
                $switch=0; 
            endforeach; ?>
<?php if( $count > 2 && !$this->dynamicSlideshow->singleRandom ): ?>
        </script>
<?php elseif( $this->dynamicSlideshow->singleRandom ): ?>
        </div>
<?php endif; ?>
        <img id="preloaderImg" src="<?php echo $this->rootDir; ?>iface/loading.gif" style="height:120px; width:120px; position:relative; left:50%; top:50%; margin-left:-60px; margin-top:-60px; z-index:-1; " /> 
    </div>
    
    
    
    