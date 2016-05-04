<?=  $this->gallery->getGalleryStyleLink() ?>

<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>
<script type="text/javascript">

    var mouseDown = 0;
    var scrollInterval = 0;
    var loadingImgHTML = "<div style='width:100%; height:100%; display:table; text-align:center;'><div style='display:table-cell; vertical-align:middle; '><img src='<?= $this->rootDir ?>iface/loading.gif' /></div></div>";
    var beforeImgBox;
    var beforeBlowupImg = "";
    var beforeLabel = document.createElement("div");
    var afterLabel = document.createElement("div");
    afterLabel.style.position = beforeLabel.style.position = "absolute";
    afterLabel.style.top = beforeLabel.style.bottom = "0px";
    afterLabel.style.right = beforeLabel.style.left = "0px";
    afterLabel.style.backgroundColor = beforeLabel.style.backgroundColor = "#FFF";
    afterLabel.style.color = beforeLabel.style.color = "#000";
    afterLabel.style.fontSize = beforeLabel.style.fontSize = "17px";
    afterLabel.style.fontWeight = beforeLabel.style.fontWeight = "900";
    afterLabel.style.border = beforeLabel.style.border = "solid 2px #000";
    afterLabel.style.zIndex = beforeLabel.style.zIndex = 2;
    afterLabel.style.padding = beforeLabel.style.padding = "2px 5px";
    beforeLabel.innerHTML = "Before";
    afterLabel.innerHTML = "After";
    

    var xmlhttp;
    var durGalId = 0;
    var curGalId = 0;
    
    
    function resizeframe(f)
    {
        f.style.height = f.contentWindow.document.body.scrollHeight + "px";
    }
    
    
    function tb_valueSet(value)
    {
        if( window.frames['duringGallery'].document.getElementById('durPhoto') != NULL )
            window.frames['duringGallery'].document.getElementById('durPhoto').value = value;
    }
    
    
    
    function showDuringGallery(galid,parentGallery)
    {
        var args = '?galid=' + galid;
        if( parentGallery != 'undefined' )
            args = args + '&parentgal=' + parentGallery;
        
        document.getElementById('duringGallery').src = "duringGallery.php" + args;
    }
    
    
    
    function hideDescs()
    {
        var boxContainer = document.getElementById("descriptionsBox");
        var boxes = boxContainer.childNodes;
        
        for( i=0; i < boxes.length; i++ )
        {
            if( boxes[i].getAttribute )
            {
                if( boxes[i].getAttribute('elementName') == "projectDescriptions" )
                    boxes[i].style.display = 'none';
            }
        }
    }
    
    
    
    function setPictureInfo(form, id, main, before, durGal)
    {
        form.picid.value = curGalId = id;
        form.main.value = main;
        form.before.value = before;
        durGalId = durGal;
        showDesc(id);
        document.getElementById('picInputs').style.display = 'block';
        document.getElementById('picAfterDelete').disabled = '';
//        showDuringGallery(durGalId);
    }
    
    
    
    function showDesc(idNum)
    {
        var id = "imgDesc_" + idNum;
        
        hideDescs();
        document.getElementById(id).style.display = "block";
    }
    
    

    function displayLoadedAfterImage(e)
    {
        if( !e ) {var e = window.event;}
        
        var img = (e.target) ? e.target : this;
        var box = document.getElementById('sliderImageBlowup');

        box.style.backgroundImage = "url('" + img.src + "')";
        if( box.innerHTML ) {box.innerHTML = "";}
        else { box.innerText = ""; }
        if( beforeImgBox != undefined )
        {
            box.appendChild(beforeImgBox);
            beforeLabel.innerHTML = "Before";
            beforeImgBox.appendChild(beforeLabel);
            beforeImgBox.style.cursor = "pointer";
            if( beforeBlowupImg != "" )
                beforeImgBox.onmouseup = function() {Shadowbox.open({content: beforeBlowupImg, player: 'img'}); };
            beforeImgBox.style.display = "block";
        }
        afterLabel.innerHTML = "After";
        box.appendChild(afterLabel);
        box.style.display = "block";
    }

    function showBeforeAfter(afterImage, afterBoxH, afterBoxW, beforeImage, beforeBoxH, beforeBoxW)
    {
        var afterBox = document.getElementById('sliderImageBlowup');

        beforeImgBox = undefined;
        if( beforeImage != undefined && beforeImage != "" )
        {
            beforeImgBox = document.createElement('div');
            beforeImgBox.innerHTML = "";
            beforeImgBox.id = "sliderImageBefore";
            beforeImgBox.style.height = beforeBoxH + "px";
            beforeImgBox.style.width =  beforeBoxW + "px";
            beforeImgBox.style.backgroundImage="url('" + beforeImage + "')";
        }


        if( afterImage == undefined || afterImage == "" )
        {
            afterBox.style.display = "none";
        }
        else
        {
            if( afterBox.innerHTML ) {afterBox.innerHTML = loadingImgHTML;}
            else {afterBox.innerText = loadingImgHTML;}
            afterBox.style.height = afterBoxH + "px";
            afterBox.style.width = afterBoxW + "px";
            afterBox.style.display = "block";
            var bgImg = new Image();
            bgImg.onload = displayLoadedAfterImage;
            bgImg.error = function(e) { if (!e) {var e = window.event;} var afterBox = document.getElementById('sliderImageBlowup'); afterBox.innerHTML = "<div style='width:100%; height:100%; display:table; text-align:center;'><div style='display:table-cell; vertical-align:middle; '>There was an error loading the image<br />Please try again later</div></div><div id='sliderImageBefore'></div>"; };
            bgImg.src = afterImage;
        }
    }
    
    
    
    function showDuringImage(img, h, w)
    {
        var box = document.getElementById('sliderImageBlowup_during');


        if( img == undefined || img == "" )
        {
            box.style.display = "none";
        }
        else
        {
            box.innerHTML = loadingImgHTML;
            box.style.height = h + "px";
            box.style.width = w + "px";
            box.style.display = "block";
            var bgImg = new Image();
            bgImg.onload = function(e){ if( !e ) {var e = window.event;} var img = (e.target) ? e.target : this; var box = document.getElementById('sliderImageBlowup_during'); box.innerHTML = ""; box.style.backgroundImage = "url('" + img.src + "')"; };
            bgImg.error = function(e) { if( !e ) {var e = window.event;} var afterBox = document.getElementById('sliderImageBlowup'); afterBox.innerHTML = "<div style='width:100%; height:100%; display:table; text-align:center;'><div style='display:table-cell; vertical-align:center; '>There was an error loading the image<br />Please try again later</div></div><div id='sliderImageBefore'></div>"; };
            bgImg.src = img;
        }
    }
    
    
    
    function scrollImages(scrollerId, direction)
    {
        if( mouseDown == 1 )
        {
//        alert("Why is this not scrolling?");
            var scroller = document.getElementById(scrollerId);
            if( direction < 0 && scroller.offsetLeft + scroller.offsetWidth > scroller.parentNode.offsetWidth )
            {
                scroller.style.left = scroller.offsetLeft + (30 * direction) + "px";
            }
            
            if( direction > 0 && scroller.offsetLeft < 0 )
            {
                scroller.style.left = scroller.offsetLeft + (30 * direction) + "px";
            }
            
            if( scrollInterval == 0 )
            {
                scrollInterval = setInterval("scrollImages('" + scrollerId + "', " + direction + ");", 90);
            }
        }
    }
    
    
    function scrollButtonClicked()
    {
        if( typeof(arguments[0]) != "object" )   // IE browser
        {
            var direction = arguments[1];
            var elId = arguments[0];
            var e = window.event;
            var lbutton = (e.button == 1);
        }
        else   // Standards complient browser
        {
            var e = arguments[0];
            var elId = arguments[1];
            var direction = arguments[2];
            if( e.which )
                var lbutton = (e.button == 0);
            else
                var lbutton = (e.button == 1);
        }

        if( lbutton == true )
        {
            mouseDown = 1;
            scrollImages(elId, direction);
        }
    }
    
    
    function mouseUp()
    {
        mouseDown = 0;
        try
        {
            clearInterval(scrollInterval);
        }
        catch(e)
        {
            try
            {
                clearTimeout(scrollInterval);
            }
            catch(e)
            {
                scrollInterval = 0;
            }
        }
        scrollInterval = 0;
    }

</script>

<div style="width:100%; margin:0px auto; ">
    <div style="position:relative; width:100%; height:75px; ">
        <div style="position:absolute; left:0px; top:0px; height:100%; width:30px; cursor:pointer; ">
            <img src="<?= $this->rootDir ?>iface/slideGalleryLeft.png" onmousedown="scrollButtonClicked(event, 'topGalleryImages', 1);" onmouseup="mouseUp(); " />
        </div>
        <div style="position:absolute; left:30px; right:30px; height:75px; overflow:hidden; ">
            <div id="topGalleryImages" style="position:absolute; height:75px; white-space:nowrap; ">
<?php


    $descs = "<div id='descriptionsBox' style='text-align:left; '>";
    foreach($this->rem_images as $image)
    {
    
        $code = "%s";
        if( $this->user->inBackDoor() && $this->access >= 2 )
        {
            $code = "<textarea style=\"width:99.2%%; height:95%%; \" name=\"imgDesc[{$image->bseImage->id}]\">%s</textarea>";
        }
            
        $text = sprintf($code, $image->description);
        $descs .= "
        <div id=\"imgDesc_{$image->bseImage->id}\" elementName=\"projectDescriptions\" style=\"width:100%; height:130px; font-size:15px; padding:4px; display:none; border:solid 2px #000; margin:5px auto; \">$text</div>";

        $previewImg = $image->getPreviewImage(75, -1);
        $previewH = $image->resizeH; 
        $previewW = $image->resizeW;
?>
            <div style="cursor:pointer; position:absolute; float:left; height:75px; width:<?= $image->resizeW ?>px; background-color:#000; z-index:2; display:inline; filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=10); opacity:.1; " onmouseover="setOpacity(this, 0);" onmouseout="setOpacity(this, 2);" onmouseup="
    <?php 
       if( $this->user->inBackDoor() && $this->access >= 2 )
           echo "setPictureInfo(document.getElementById('mainImageForm'), {$image->bseImage->id}, '{$image->bseImage->image_file}', '{$image->before_file}', '{$image->during_galid}'); showDuringGallery({$image->during_galid}, {$image->id}";
       else
           echo "
         showDesc({$image->bseImage->id}); showDuringGallery( {$image->during_galid} ); showBeforeAfter('" . $image->getPreviewImage(-1, 675) . "', {$image->resizeH}, {$image->resizeW}";
         if( @trim( $image->before_file ) != "" )
             echo ", '" . $image->getPreviewImage(150, -1, $image->before_file) . "', {$image->resizeH}, {$image->resizeW}";
    ?>); beforeBlowupImg = '<?= ( @trim( $image->before_file ) == "" ? "" : $image->getPreviewImage(-1, 675, $image->before_file) ) ?>';"></div>
            <img src="<?= $previewImg ?>" style="width:<?= $previewW ?>px; height:<?= $previewH ?>px; display:inline; " />

<?php
    }
?>

            </div>
        </div>
        <div style="position:absolute; right:0px; top:0px; bottom:0px; width:30px; cursor:pointer; ">
            <img src="<?= $this->rootDir ?>iface/slideGalleryRight.png" onmousedown="scrollButtonClicked(event, 'topGalleryImages', -1);" onmouseup="mouseUp(); " />
        </div>
    </div>

<?php 

    if( $this->user->inBackDoor() && $this->access >= 2 )
    {
        echo "<form id='mainImageForm' action='" . $this->rootDir . "modules/bseRemodelingGallery/galleryProcessor.php' method='post' name='editpic'>
        ";
        
        $descs .= "<div id=\"imgDesc_new\" elementName=\"projectDescriptions\" style=\"width:100%; height:130px; font-size:15px; padding:4px; display:none; border:solid 2px #000; margin:5px auto; \"><textarea style=\"width:99.2%; height:95%; \" name=\"imgDesc[new]\"></textarea></div>";
    }
    echo $descs."</div>";

?>
    <div id="sliderImageBlowup">
<?php
    $tmpRem = new bseRemodelingGalleryImage($this->rootDir);
    if( $this->user->inBackDoor() )
    {
        echo "
        <div style='margin:10px 35px; font-size:14px; '>
            Add Before and After photos of your remodeling below. The 'After' photos will go in the photo slider above.
            When that photo is clicked, a large image will display below the slider, and if you add a 'Before' photo, it will show up near the bottom left of the enlarged photo.
            Also, if you have added photos to the 'During' gallery, they will display in another slider below the enlarged photo.
            After adding an 'After' photo and while in the backdoor, click the photo to edit it or add photos of the remodeling process in the 'During' gallery.
            To add photos to the 'During' gallery, click the image in the top slider of the project you want to add 'During' photos to, and then click the 'During Gallery Manager' link below.
            This will take you to the standard gallery manager page where you can upload pictures to the gallery.
        </div>
            <input type='hidden' name='picid' value='new' />
            <input type='hidden' name='galid' value='{$this->gallery->id}' />
            <div id='picInputs' style='display:none; '>
                <div class='inputWrapper tb_input'><div>After Photo</div><input id='mainPhoto' type='text' name='main' /><img style='margin-left:2px; cursor:pointer; ' alt='Browse for file' title='Browse for File' src='{$this->rootDir}iface/browse_btn.png' onmouseup=\"tinyBrowserPopUp('image','mainPhoto', '" . urlencode($tmpRem->getMediaDirHref(false)) . "'); \" /></div>
                <div class='inputWrapper tb_input'><div>Before Photo</div><input id='beforePhoto' type='text' name='before' /><img style='margin-left:2px; cursor:pointer; ' alt='Browse for file' title='Browse for File' src='{$this->rootDir}iface/browse_btn.png' onmouseup=\"tinyBrowserPopUp('image','beforePhoto', '" . urlencode($tmpRem->getMediaDirHref(false)) . "'); \" /></div>
            </div>
            <div class='clear' style='height:15px; '></div>
            <input type='submit' name='remodelsubmit' value='Save' style='float:right; margin-right:35px; ' /><input style='float:right; margin-right:5px; ' type='button' value='New Picture' onmouseup=\"setPictureInfo(this.form,'new','','',0); \" /><input id=\"picAfterDelete\" style=\"float:right; margin-right:5px; \" type=\"button\" value=\"Delete\" disabled=\"disabled\" onmouseup=\"if( this.form.picid.value != 'new' && this.form.picid.value != '' ) {document.location.href='{$this->rootDir}modules/bseRemodelingGallery/galleryProcessor.php?delid=' + this.form.picid.value; }\" />
";
    }

    echo "</div>";


    if( $this->user->inBackDoor() && $this->access >= 2 )
        echo "
        </form>
";
?>

    
    <iframe name="duringGallery" frameborder="0" style="border:0; width:100%; position:relative; top:10px; " id="duringGallery">
<?php
    if( $this->user->inBackDoor() && $this->access >= 2 )
    {
        echo "<div class='clear' style='width:100%; text-align:center; padding-top:25px; margin-bottom:12px; font-size:14px; font-weight:900; '><a href='#' onclick=\"document.location.href='{$this->rootDir}modules/bseGallery/galleryManager.php?ownerGalId=' + curGalId + '&galid=' + durGalId; \">During Gallery Manager</a></div>";
    }
?>
    </iframe>
</div>