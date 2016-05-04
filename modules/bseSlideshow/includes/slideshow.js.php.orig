<?php

	$rootPath = "../../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    
    $slideshow =& $bse->getModule("bseSlideshow");

    header("Content-type: text/javascript");
?>    
    var nextPicIndex = 1;
    var curPicIndex = 0;
    var opacityLevel = 0;
    var timeoutIndex = 0;
    var intervalIndex = 0;
    var docLoaded = false;
    var imgComplete = new Array();
    var boxWidth = 0;
    var boxHeight = 0;
    var boxId = "slideshowBox";
    var resized = false;
<?php

    $images = array();


    $url = "http://" . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF'])."/flashGalleryXML.php";
    //$url = "flashGalleryXML.php";
/*
    $curl = curl_init($url);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_REFERER, "http://" . $_SERVER['SERVER_NAME']);
    curl_setopt($curl, CURLOPT_HEADER, false);
    $xml = curl_exec($curl);

    curl_close($curl);
*/
    //$xml = eval( file_get_contents( $url ) );
    //$gallery = simplexml_load_string($xml);
    $gallery = simplexml_load_file($url);

    
    $dur = (int)$gallery['duration'] * 1000;
    echo "
    var slideDur = $dur;
    var images = new Array();


";

    $cnt = 0;
    foreach( $gallery->images[0] as $img )
    {
        $images[$cnt] = array();
        $images[$cnt]['label'] = $img->label;
        $images[$cnt]['file'] = $img->file;
        $images[$cnt]['link'] = $img->link;
        $cnt++;
    }


    if( count($images) > 0 && !$slideshow->singleRandom )
    {
        for( $i = 0; $i < count($images); $i++ )
        {
            echo <<< IMGS
    images[$i] = new Image();
    images[$i].src = "{$_GET['root']}modules/bseSlideshow/{$images[$i]['file']}";
    images[$i].style.position = "absolute";
    images[$i].id = $i;
    //images[$i].onload = imageLoad;
    setOpacity(images[$i], 0);
    imgComplete[$i] = 0;
    
IMGS;
        }
//    echo '
//    $("#" + boxId).ready(function(){ resizeImage(images[0]); document.getElementById(boxId).appendChild(images[0]); images[0].style.left = "0px"; images[0].style.top = "0px"; setOpacity(images[0], 10); });
//';
    }
    elseif( count($images) > 0 && $slideshow->singleRandom )
    {
    	// Get a different single random image than the previous page
    	if( !isset($_SESSION['prevSlideImage']) ){ $_SESSION['prevSlideImage'] = -1; }
    	$i = rand(0, count($images) - 1);
    	if( $i == $_SESSION['prevSlideImage'] ){ $i++; }
    	if( $i > count($images) - 1 ){ $i = 0; };
    	
    	// Output the single random image code
		echo <<< IMGS
    images[0] = new Image();
    images[0].src = "{$_GET['root']}modules/bseSlideshow/{$images[$i]['file']}";
    images[0].style.position = "absolute";
    images[0].id = $i;
    imgComplete[0] = 0;

IMGS;

    	// Set the image index of the selected random image for this page so we don't duplicate it on the next page
    	$_SESSION['prevSlideImage'] = $i;
    }

?>

    $(images[0]).imagesLoaded(function(){ resizeImage(images[0], true); });
    
    function setFirstImage()
    {
        images[0].style.left = "0px";
        images[0].style.top = "0px";
        document.getElementById(boxId).appendChild(images[0]);
        setOpacity(images[0], 10);
    }

	if (window.attachEvent) {window.attachEvent('onload', pageLoaded);}
	else if (window.addEventListener) {window.addEventListener('load', pageLoaded, false);}
	else {document.addEventListener('load', pageLoaded, false);}
    
    
    function pageLoaded() { docLoaded = true; init(); }



    function imageLoad(e)
    {
        var tgt;
        
        if( window.event )
        {
            tgt = window.event.srcElement;
        }
        else
        {
            tgt = this;
        }
        
        finishImageLoad(tgt);
    }

    function finishImageLoad(img)
    {
        var redo = function(){ finishImageLoad(img); };
        imgComplete[img.id] = setTimeout( redo, 500);

        if( img.complete && docLoaded )
        {
            //resizeImage(img);
            clearTimeout(imgComplete[img.id]);
            img.id = "";
        }
    }


    function getWindowSize()
    {
        // the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
    
        if (typeof window.innerWidth != 'undefined')
        {
            boxWidth = window.innerWidth,
            boxHeight = window.innerHeight
        }

        // IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)

        else if (typeof document.documentElement != 'undefined'
            && typeof document.documentElement.clientWidth !=
           'undefined' && document.documentElement.clientWidth != 0)
        {
            boxWidth = document.documentElement.clientWidth,
            boxHeight = document.documentElement.clientHeight
        }

        // older versions of IE

        else
        {
            boxWidth = document.getElementsByTagName('body')[0].clientWidth,
            boxHeight = document.getElementsByTagName('body')[0].clientHeight
        }
    }




    
    function fadePic(picIndex)
    {
        var nextPic = images[picIndex];
        var currentPicIndex = picIndex - 1;
        if( currentPicIndex < 0 )
            currentPicIndex = images.length - 1;
        
        var curPic = images[currentPicIndex];
        
        if( opacityLevel <= 10 )
        {
            opacityLevel = opacityLevel + 0.5;
            setOpacity(nextPic, opacityLevel);
            setOpacity(curPic, (10 - opacityLevel) );
            setTimeout( function(){ fadePic(picIndex); }, 50);
        }
        else
        {
            opacityLevel = 0;
        }
    }






    function setOpacity(obj, opacity)
    {
        obj.style.filter='progid:DXImageTransform.Microsoft.Alpha(Opacity=' + opacity * 10 + ')';
        obj.style.opacity = opacity/10;
    }
    




    function changeImage()
    {
        nextPicIndex = curPicIndex + 1;
        if( nextPicIndex > images.length - 1 )
            nextPicIndex = 0;
        

        images[nextPicIndex].style.zIndex = 1;
        images[curPicIndex].style.zIndex = 0;

        if( images[nextPicIndex].complete )
        {
            if( timeoutIndex != 0 )
                clearTimeout(timeoutIndex);

            fadePic(nextPicIndex);
            
            if( intervalIndex != 0 )
            {
                clearInterval(intervalIndex);
                intervalIndex = setInterval(changeImage, slideDur);
            }
            curPicIndex = nextPicIndex;
        }
        else
        {
            clearInterval(intervalIndex);
            timeoutIndex = setTimeout(changeImage, 200);
        }
    }
    
    



    function init()
    {
        var container = document.getElementById(boxId);
<?php if( $slideshow->singleRandom ): ?>
		document.getElementById(boxId).appendChild(images[0]);
<?php else: ?>
        for( i=1; i < images.length; i++ )
        {
            container.appendChild(images[i]);
            images[i].style.left = 0;
            images[i].style.top = 0;
            resizeImage(images[i]);
        }
<?php endif; ?>

<?php if( $slideshow->autoStart != false ): ?>

        intervalIndex = setInterval(changeImage, slideDur);
<?php endif; ?>
		document.getElementById('preloaderImg').style.display = "none";
    }
    
    
    


    function startstop(action)
    {
        if( intervalIndex > 0 && ( action == 'stop' || action == undefined ) )
        {
            clearInterval(intervalIndex);
            intervalIndex = 0;
        }
        else if( action == 'start' || action == undefined )
        {
            changeImage();
            intervalIndex = setInterval(changeImage, slideDur);
        }
    }
    



    
    
    function resizeImage(img, callCompleteFunc)
    {
    
      // ratio = width / height
      // width = ratio * height
      // height = width / ratio
      
        if( typeof(callCompleteFunc) == 'undefined' )
        {
            callCompleteFunc = false;
        }
      
        if( img.complete == false )
        {
        	setTimeout(function(){ resizeImage(img, callCompleteFunc); }, 100 );
            return;
        }
    
        if( boxId == null )
        {
            getWindowSize();
        }
        else
        {
            var el = document.getElementById(boxId);
            boxWidth = Math.floor(el.offsetWidth);
            boxHeight = Math.floor(el.offsetHeight);
        }
        

        var boxRatio = boxWidth / boxHeight;
        var imgRatio = img.offsetWidth / img.offsetHeight;
        
        // Check for image height / width proportions fitting to the window
        
        // if the resized image's width is less than the container's width, then
        // resize the image's width to the container's width
        if( ( boxHeight * imgRatio ) <= boxWidth )
        {
            img.style.height = "auto";
            img.style.width = boxWidth + "px";
            img.style.left = 0;
            //alert("Resized width to " + boxWidth + " pixels.");
        }
        
        // if the resized image's height is greater than the container's height, then resize the image's height to the container's height
        else if( ( boxWidth / imgRatio ) <= boxHeight )
        {
            img.style.width = "auto";
            img.style.height = boxHeight + "px";
            img.style.left = (boxWidth - img.offsetWidth) / 2 + 'px';
            //alert("Resized height to " + boxHeight + " pixels.");
        }
        
        else
        {
            img.style.width = boxWidth + "px";
            img.style.height = "auto";
            img.style.left = 0;
            //alert("Resized width to " + boxWidth + " pixels.");
        }
        

        if( callCompleteFunc )
        {
            setFirstImage();
        }
    }
    
    
    function resizeAll()
    {
        for( i = 0; i < images.length; i++ )
            resizeImage(images[i]);
    }

    $(document).ready( function()
    {
        setTimeout( function()
        {
            $(window).blur( function(){ startstop('stop'); } );
<?php if( !$slideshow->singleRandom ): ?>
            $(window).focus( function(){ if( !paused ){ setTimeout( function(){ startstop('start'); }, 500); } } );
<?php endif; ?>
        }, 500 );
        $(window).resize( function(){ resizeAll(); } );
    });