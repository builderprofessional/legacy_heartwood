<?php

    $page = "/";
    if( isset($_POST['page']) )
        $page=htmlentities($_POST['page']);

    else if( isset($_GET['page']) )
        $page=htmlentities($_GET['page']);


// The following handles posted data from the form below
    if( isset($_POST['vidID']) )
    {
        include("video.php");
        
        $id = $_POST['vidID'];
        $vid = createVideoClass("../../", $id);
        
        $vid->setValue("title", $_POST['vidTitle']);
        
        if( isset($_FILES['vidPreview']) )
        {
            $uid = microtime();
            $imgFile = $vid->imageDir."$id-$uid.jpg";
            if( move_uploaded_file($_FILES['vidPreview']['tmp_name'], $imgFile) )
            {
                $playerW = $vid->playerWidth;
                $playerH = $vid->playerHeight;
                $bgColor = $vid->bgColor;
                list($imgW, $imgH) = getimagesize($imgFile);
                $padW = $padH = $cropW = $cropH = 0;
                
                if( $playerW > $imgW )
                {
                    $padW = ($playerW - $imgW)/2;
                }
                else if( $videoW > $imgW )
                {
                    $cropW = ($imgW - $playerW)/2;
                }
                
                if( $playerH > $imgH )
                {
                    $padH = ($playerH - $imgH) / 2;
                }
                else if( $videoH > $imgH )
                {
                    $cropH = makeMultipleTwo(($imgH - $playerH)/2);
                }
                
                if( $playerW != $imgW || $playerH != $imgH )
                    resizePreview($imgFile, $bgColor, $playerW, $playerH, $padW, $padH, $cropW, $cropH);

                $vid->setValue("previewFile", "$id-$uid.jpg");
            }
        }
        
        if( !empty($_POST['reEdit']) )
        {
            header("Location: upload/editVideo.php?vidID=$id");
            exit();
        }
        
        else
        {
            header("Location: $page");
            exit();
        }
    
    }   // End post handling code

    
// No data posted, output a form to edit the video data, unless no video id was provided
    if( isset($_GET['vid']) )
    {
        include("video.php");
        
        $id = $_GET['vid'];
        $vid = createVideoClass("../../", $id);
    }
    
    else
    {
        header("Location: $page");
        exit();
    }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<body>
    <form method="post" enctype="multipart/form-data">
        <div>Video Title</div>
        <input style="width:300px;" type="text" name="vidTitle" value="<?=$vid->title?>" />
        <div style="margin-top:15px; ">Change Preview Image</div>
        <input style="width:300px;" type="file" name="vidPreview" />
        <div style="margin-top:15px; ">Re-edit original video <input type="checkbox" name="reEdit" value="1" /></div>
        <input type="hidden" name="vidID" value="<?=$vid->id?>" />
        <input type="hidden" name="page" value="<?=$page?>" />
        <input type="button" value="Cancel" onclick="document.location.href='<?=$page?>';" /> <input type="submit" value="Save" />
    </form>
</body>
</html>
<?php
    function resizePreview($imageFile, $backColor, $destWidth, $destHeight, $padW, $padH, $cropX, $cropY)
    {
        // Create resized image
        $color = $backColor;
        $img = imagecreatetruecolor($destWidth, $destHeight);
        $backColor = imagecolorallocate($img, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));
        imagefilledrectangle($img, 0, 0, $destWidth, $destHeight, $backColor);
        list($srcW, $srcH) = getimagesize($imageFile);
        $prevImg = imagecreatefromjpeg($imageFile);
        $newW = $srcW - $cropX*2;
        $newH = $srcH - $cropY*2;
        imagecopyresized($img, $prevImg, $padW, $padH, $cropX, $cropY, $destWidth-$padW*2, $destHeight-$padH*2, $newW, $newH);
        imagejpeg($img, $imageFile, 100);
        imagedestroy($img);
        imagedestroy($prevImg);
    }
?>