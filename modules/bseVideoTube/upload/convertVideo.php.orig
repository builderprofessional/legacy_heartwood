<?php

    include("../../includes/config.inc");
    include("../includes/config.inc");
    include("../../base/db/bseConnection.php");
    include("../includes/dbClass.inc");
    include("../includes/bseVideo.inc");
    $dbCon = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
    $conn = $dbCon->getConn();

    $vidID = mysql_real_escape_string($_POST['vidID'], $conn);
    $vidFile = $_POST['vidFile'];
    $playerW = makeMultipleTwo($_POST['playerW']);
    $playerH = makeMultipleTwo($_POST['playerH']);
    $videoW = makeMultipleTwo($_POST['videoW']);
    $videoH = makeMultipleTwo($_POST['videoH']);
    $vidTitle = mysql_real_escape_string($_POST['vidTitle'], $conn);
    $bgColor = $_POST['bgColor'];
    $vidQuality = $_POST['vidQuality'];
    $previewFrameNum = $_POST['previewFrameNum'];
    $previewFrame = $_POST['previewFrame'];
    $imgDir = "../$imageDir/";
    $imgFile = $imgDir.$vidID.".jpg";
    $previewImg = $vidID.".jpg";
    $fps = $_POST['vidFPS'];
    $frames = $_POST['vidFrameCount'];
    if( $forceProperties )
        $vidQuality = $forcedVidQuality;

    $padW = $padH = $cropW = $cropH = 0;
    $padOpt = "-padcolor $bgColor";
    $cropOpt = "";

    if( $playerW > $videoW )
    {
        $padW = makeMultipleTwo(($playerW - $videoW)/2);
        $padOpt .= " -padleft $padW -padright $padW";
    }
    else if( $videoW > $playerW )
    {
        $cropW = (makeMultipleTwo($videoW - $playerW)/2);
        $cropOpt .= "-cropleft $cropW -cropright $cropW";
    }

    if( $playerH > $videoH )
    {
        $padH = makeMultipleTwo(($playerH - $videoH) / 2);
        $padOpt .= " -padtop $padH -padbottom $padH";
    }
    else if( $videoH > $playerH )
    {
        $cropH = makeMultipleTwo(($videoH - $playerH)/2);
        $cropOpt .= " -croptop $cropH -cropbottom $cropH";
    }

    $w = $playerW - $padW*2;
    $h = $playerH-$padH*2;
    $sizeOpt = "-s {$w}x{$h}";


    // If Upload Preview Image checkbox is selected, move uploaded file
    if( isset($_POST['uploadPreview']) )
    {
        move_uploaded_file($_FILES['uploadPreviewImg']['tmp_name'], $imgFile);
        list($imgW, $imgH) = getimagesize($imgFile);
        if( $playerW != $imgW || $playerH != $imgH )
        {
            resizePreview($imgFile, $bgColor, $playerW, $playerH, $padW, $padH, $cropW, $cropH);
        }
    }

    // If they selected a preview frame and did not enter a frame number
    else if( $previewFrame != "" && empty($previewFrameNum) )
    {
        rename($imgDir.$previewFrame, $imgFile);
        list($imgW, $imgH) = getimagesize($imgFile);
        if( $playerW != $imgW || $playerH != $imgH )
        {
            resizePreview($imgFile, $bgColor, $playerW, $playerH, $padW, $padH, $cropW, $cropH);
        }
    }

    // No file uploaded, no preview selected, either they used a frame number, or left all empty
    else
    {
        // If they did not enter a frame number or they entered on larger than the video, get the middle frame
        if( empty($previewFrameNum) || $previewFrameNum > $frames )
            $previewFrameNum = $frames / 2;

        $seconds = $previewFrameNum / $fps;
        exec($ffmpeg." -ss $seconds -i ".str_replace(" ", '\ ', escapeshellcmd("../$videoDir/$vidFile"))." $cropOpt $padOpt $sizeOpt -vframes 1 -f image2 -y $imgFile");
    }

    $sql = "UPDATE `bseVideos` SET `title`='$vidTitle',`videoFile`='$vidID.flv', `previewFile`='".mysql_real_escape_string($previewImg, $conn)."', `playerWidth`='".mysql_real_escape_string($playerW, $conn)."', `playerHeight`='".mysql_real_escape_string($playerH, $conn)."', `originalFile`='$vidFile', `active`='1' WHERE `id`='".mysql_real_escape_string($vidID, $conn)."'";
    if( $dbCon->getQueryResult($sql) == false )
    {
        header("Location: error.php");
        exit();
    }

    exec("rm -f {$imgDir}frame*-*.jpg");

    $log = "tmp/progress_$vidID";

    $pathInfo = pathinfo($vidFile);
    $curDir = dirname($_SERVER['SCRIPT_FILENAME']);
    $absVideoDir = dirname($curDir) . "/$videoDir";

    if( strtolower($pathInfo['extension']) != "flv" && strtolower($pathInfo['extension']) != "mov" )
        $command = $ffmpeg." -i ".str_replace(" ", '\ ', escapeshellcmd("../$videoDir/$vidFile"))." $vidQuality $cropOpt $padOpt $sizeOpt -vcodec flv -acodec libmp3lame -f flv -y - 2>$log | $flvtool2 -U stdin ../$videoDir/$vidID.flv && $curDir/apps/ftp.sh $vidID.flv $absVideoDir {$_SERVER['SERVER_NAME']}";

    else
        $command = $ffmpeg." -i ".str_replace(" ", '\ ', escapeshellcmd("../$videoDir/$vidFile"))." $vidQuality $cropOpt $padOpt $sizeOpt -vcodec copy -acodec libmp3lame -f flv -y - 2>$log | $flvtool2 -U stdin ../$videoDir/$vidID.flv && $curDir/apps/ftp.sh $vidID.flv $absVideoDir {$_SERVER['SERVER_NAME']}";

    execInBackground($command);

    header("Location: encoding.php?vid=$vidID&frames=$frames");
    exit();

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


    function makeMultipleTwo ($value)
    {
        $value = (int)$value;
        return ($value%2==0)?$value:$value-1;
    }

    function execInBackground($cmd, $log = "/dev/null")
    {
        if (substr(php_uname(), 0, 7) == "Windows")
        {
            pclose(popen("start /B ". $cmd, "r"));
        }
        else
        {
            exec("$cmd > $log 2>&1 &");
        }
    }

?>