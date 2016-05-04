<html>
<head>
<script type="text/javascript">

    function setDuringPictureInfo(form, id, main, durGal)
    {   document.getElementById('durpicid').value = id;
        document.getElementById('durPhoto').value = main;
        document.getElementById('durPicInputs').style.display = 'block';
        document.getElementById('durPicDelete').disabled = '';
        parent.resizeframe(parent.document.getElementById('duringGallery'));
    }
    
</script>
<link rel="stylesheet" type="text/css" media="screen" href="<?= $this->rootDir ?>css/site_style.css.php" />
</head>
<body style="background-color:transparent; " onload="parent.resizeframe(parent.document.getElementById('duringGallery'));">

<?php

    if( $this->duringGallery != null )
    {
?>

    <div style="position:relative; width:100%; height:75px; clear:both; ">
        <div style="position:absolute; left:0px; top:0px; height:100%; width:30px; cursor:pointer; ">
            <img src="<?= $this->rootDir ?>iface/slideGalleryLeft.png" onmousedown="scrollButtonClicked(event, 'botGalleryImages', 1);" onmouseup="mouseUp(); " />
        </div>
        <div style="position:absolute; left:30px; right:30px; height:100%; overflow:hidden; ">
            <div id="botGalleryImages" style="position:absolute; height:75px; white-space:nowrap; ">
<?php

        foreach($this->duringGallery->categories->getItemById( $this->duringGallery->getActiveCategoryId() )->images as $image)
        {
            $href_preview = $image->getPreviewImage(75, -1);
?>

                <img src="<?= $href_preview ?>" style="cursor:pointer; width:<?= $image->resizeW ?>px; height:<?= $image->resizeH ?>px; " onmouseup="<?php if( $this->user->inBackDoor() ) { ?>setDuringPictureInfo(document.getElementById('durImageForm'), <?= $image->id ?>, '<?= $image->image_file ?>', <?= $this->duringGallery->id ?>); <?php } else { ?>parent.Shadowbox.open({content: '<?= $image->getImageHref() ?>', player: 'img'}); <?php } ?>" />

<?php
        }
?>

            </div>
        </div>
        <div style="position:absolute; right:0px; top:0px; bottom:0px; width:30px; cursor:pointer; ">
            <img src="<?= $this->rootDir ?>iface/slideGalleryRight.png" onmousedown="scrollButtonClicked(event, 'botGalleryImages', -1);" onmouseup="mouseUp(); " />
        </div>
    </div>



<?php 

        if( $this->user->inBackDoor() )
        {
            echo "<form id='durImageForm' action='" . $this->rootDir . "modules/bseRemodelingGallery/galleryProcessor.php' method='post'>
        ";
        }
        echo "</div>";

?>
    <div id="sliderImageBlowup_during">
<?php
        if( $this->user->inBackDoor() )
        {
            $tmpGal = new bsePhotoGallery($this->rootDir);
            echo "
            <div style='margin:10px 35px; font-size:14px; '>
                Click an image to edit/delete it.
            </div>
            <input id='durpicid' type='hidden' name='durpicid' value='new' />
            <input type='hidden' name='durgalid' value='{$this->duringGallery->id}' />
            <div id='durPicInputs' style='display:none; '>
                <div class='inputWrapper tb_input'><div>During Photo</div><input id='durPhoto' type='text' name='main' /><img style='margin-left:2px; cursor:pointer; ' alt='Browse for file' title='Browse for File' src='{$this->rootDir}iface/browse_btn.png' onmouseup=\"parent.tinyBrowserPopUp('image','durPhoto', '" . urlencode($tmpGal->getMediaDirHref(false)) . "'); \" /></div>
            </div>
            <div class='clear' style='height:15px; '></div>
            <input type='submit' name='remodel_during_submit' value='Save' style='float:right; margin-right:35px; ' /><input style='float:right; margin-right:5px; ' type='button' value='New Picture' onmouseup=\"setDuringPictureInfo(document.getElementById('durImageForm'),'new','',0); \" /><input id=\"durPicDelete\" style=\"float:right; margin-right:5px; \" type=\"button\" value=\"Delete\" disabled=\"disabled\" onmouseup=\"if( document.getElementById('durImageForm').durpicid.value != 'new' && document.getElementById('durImageForm').durpicid.value != '' ) {document.location.href='{$this->rootDir}modules/bseRemodelingGallery/galleryProcessor.php?galid={$this->duringGallery->id}&deldurid=' + document.getElementById('durImageForm').durpicid.value; }\" />
";
        }

        echo "</div>";


        if( $this->user->inBackDoor() )
            echo "
        </form>
";
?>

<?php

    }     // End if
    
    else if( isset($_REQUEST['parentgal']) && $this->user->inBackDoor() )
    {
        echo "<div style='width:100%; font-size:16px; text-align:center; position:relative; top:65px; '><a href=\"{$this->rootDir}modules/bseRemodelingGallery/galleryProcessor.php?addDuringTo={$_REQUEST['parentgal']}\">Add Gallery of During Photos</a></div>";
    }

?>
</body>
</html>