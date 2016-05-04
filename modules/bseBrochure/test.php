<?php
    $curDir = dirname($_SERVER['SCRIPT_FILENAME']);
    $curDir .= (substr($curDir, -1) == "/"? "" : "/");

    $img = new Imagick();
    $img->setResolution(300, 300);
    $img->readImage($curDir."test.pdf");

    if( $img->getNumberImages() > 0 )
    {
        for( $i = 1; $i <= $img->getNumberImages(); $i++ )
        {
            $img->setImageIndex($i);
            $img->resizeImage(750, 960, Imagick::FILTER_CUBIC, .5);
            $img->writeImage($curDir."$i.jpg");
        }
        echo "Image Conversion Complete";
    }
    
    else
        echo "No Images Found";
?>
