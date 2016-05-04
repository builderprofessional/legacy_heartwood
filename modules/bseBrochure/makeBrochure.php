<?php

    $rootPath = "../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;


    if( !$bse->user->loggedIn )
    {
        header("Location: $rootPath");
        exit();
    }


    $curDir = dirname($_SERVER['SCRIPT_FILENAME']);
    $curDir .= (substr($curDir, -1) == "/"? "" : "/");
    $tmpCurDir = getcwd();    
    
    $img = new Imagick();
    $img->setResolution(300, 300);
    
    if( isset($_POST['pdfFile']) )
    {
        include("includes/config.inc");
        $docsDir .= ( substr($docsDir, -1) == "/" ? "" : "/" );
        
        global $pageDir;
        $pageDir = $pagesDir . ( substr($pagesDir, -1) == "/" ? "" : "/" );
        
        $bName = $_POST['title'];
        $stdHeight = $_POST['bHeight'];
        $stdWidth = $_POST['bWidth'];
        $zoomVal = $_POST['maxZoom'];
        $pdfFile = $_POST['pdfFile'];
        $brochureid = $_POST['brochureid'];
        
        if( @trim( $_POST['brochureid'] ) == "new" )
        {
            $brochure = new bseBrochure();
            $brochureid = $brochure->insertNew();
        }
        
        $brochure =& $bse->getModule("bseBrochure");
        $brochure->setItemId($brochureid);

        $brochure->name = $bName;
        $brochure->maxZoom = $zoomVal;
        $brochure->pdfFile = $pdfFile;
        
        if( file_exists("$docsDir/$pdfFile") )
        {
            chdir($curDir);
            $curDir = getcwd();
            $curDir .= (substr($curDir, -1) == "/"? "" : "/");

            $img->readImage($curDir."$docsDir/$pdfFile");

            if( $img->getNumberImages() > 0 )
            {
                $height = $img->getImageHeight();
                $width = $img->getImageWidth();
                $ratio = $width / $height;
                $pageNum = 1;
    
                if( $stdWidth/$ratio > $stdHeight )
                    $stdWidth = floor($ratio*$stdHeight);
                else
                    $stdHeight = floor($stdWidth / $ratio);
                    
                if( $img->getNumberImages() % 2 != 0 )    // If there is an odd number of pages, add a new blank one to even things out
                {
                    $blank = new Imagick();
                    $blank->newImage($width, $height, new ImagickPixel("white"));
                    $img->addImage($blank);
                }
                
                for( $i = 0; $i < $img->getNumberImages(); $i++ )
                {
                    $img->setImageIndex($i);
                    if( $img->getImageWidth() / $img->getImageHeight() == $ratio )
                    {
                        saveImages($img, $bse->db, $curDir, $brochureid, $pageNum, $stdHeight, $stdWidth, $zoomVal, $i);
                        $pageNum++;
                    }
                    
                    else
                    {
                        if( $img->getImageWidth() > $stdWidth * 1.5 )
                        {
                            $leftImg = $img->getImage();
                            $leftImg->cropImage($img->getImageWidth()/2, $img->getImageHeight(), 0, 0);
                            saveImages($leftImg, $bse->db, $curDir, $brochureid, $pageNum, $stdHeight, $stdWidth, $zoomVal, $i);
                            $leftImg->destroy();
                            $pageNum++;
                            
                            $rightImg = $img->getImage();
                            $rightImg->cropImage($img->getImageWidth()/2, $img->getImageHeight(), $img->getImageWidth()/2, 0);
                            saveImages($rightImg, $bse->db, $curDir, $brochureid, $pageNum, $stdHeight, $stdWidth, $zoomVal, $i);
                            $rightImg->destroy();
                            $pageNum++;
                        }
                        
                        else
                        {
                            saveImages($img, $bse->db, $curDir, $brochureid, $pageNum, $stdHeight, $stdWidth, $zoomVal, $i);
                            $pageNum++;
                        }
                    }
                }
            }

            $brochure->width = $stdWidth;
            $brochure->height = $stdHeight;
            $brochure->commit();
            chdir($tmpCurDir);
        }
        else
        {
            header("Location: error.php?msg=" . urlencode("File: '$docsDir/$pdfFile' not found!") );
        }
    }
    
    $page = $bse->removeArgFromURL("brochureid", $page);
    header("Location: {$rootPath}$page?brochureid=$brochureid");

function saveImages(Imagick &$img, bseConnection $dbCon, $curDir, $id, $page, $height, $width, $zoom, $index)
{
    $img->setImageIndex($index);
    $zmImg = $img->getImage();
    $zmImg->resizeImage($width*$zoom, $height*$zoom, Imagick::FILTER_BESSEL, .5);
    $zmImg->writeImage($curDir."{$GLOBALS['pageDir']}/zoom$id-$page.jpg");
    $img->resizeImage($width, $height, Imagick::FILTER_CUBIC, .5);
    $img->writeImage($curDir."pages/$id-$page.jpg");
    $dbCon->getQueryResult("INSERT INTO `bseBrochurePages` SET `brochureid`='$id', `imageFile`='$id-$page.jpg', `pageNum`='$page'");
    $zmImg->destroy();
}
?>