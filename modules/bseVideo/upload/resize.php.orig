<?php

include("../includes/config.inc");

// The file
$path = $imageDir;
$filename = $_GET['image'];
$maxW = (isset($_GET['w']))?($_GET['w']):(150);
$maxH = (isset($_GET['h']))?($_GET['h']):(400);

$filename=str_replace("$path/", '', $filename);
$tempa=explode('?', $filename);
$filename=$tempa[0];
$filename=str_replace('?', '', $filename);
$fullFile="../$path/$filename";

if(!file_exists($fullFile))
{
    exit();
}

// Get new dimensions
list($width_orig, $height_orig) = getimagesize($fullFile);
$ratio_orig = $width_orig/$height_orig;
$nwidth=$maxH*$ratio_orig;
$nheight=$maxW/$ratio_orig;
if( $nwidth>=$maxW ){ $width=$maxW;$height=$nheight; }
if( $nheight>$maxH ){ $height=$maxH;$width=$nwidth; }

// Resample
$image_p = imagecreatetruecolor($width, $height);
$image = imagecreatefromjpeg($fullFile);
imagecopyresampled($image_p, $image, 0, 0, 0, 0, $width, $height, $width_orig, $height_orig);

// Output
header('Content-type: image/jpeg');
//imagejpeg($image_p, "../$path/resize-cache/$filename", 100);
imagejpeg($image_p, null, 100);
imagedestroy($image_p);
imagedestroy($image);
?>