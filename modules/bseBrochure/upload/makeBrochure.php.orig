<?php
    $curDir = dirname($_SERVER['SCRIPT_FILENAME']);
    $curDir .= (substr($curDir, -1) == "/"? "" : "/");
    $tmpCurDir = getcwd();    
    
    $img = new Imagick();
    $img->setResolution(300, 300);
    
    if( isset($_FILES['pdfFile']) )
    {
        include("../includes/config.inc");
        include("../../includes/config.inc");
        include("../../base/db/bseConnection.php");
        include("../../includes/dbClass.inc");
        include("../includes/bseBrochure.inc");
        
        $bName = $_POST['title'];
        $stdHeight = intval($_POST['bHeight']);
        $stdWidth = intval($_POST['bWidth']);
        $zoomVal = floatval($_POST['maxZoom']);
        
        $dbCon = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
        $conn = $dbCon->getConn();
        $brochure = new bseBrochure($conn, null, "../");
        $newID = $brochure->insertIntoDB();
        $brochure->setValue("name", $bName);
        $brochure->setValue("maxZoom", $zoomVal);
        $brochure->setValue("pdfFile", "$newID.pdf");
        
        $fileName = str_replace(" ", "_", $bName);
        $fileName .= "-$newID.pdf";
        if( move_uploaded_file($_FILES['pdfFile']['tmp_name'], "../docs/$fileName") )
        {
            chdir($curDir);
            chdir("../");
            $curDir = getcwd();
            $curDir .= (substr($curDir, -1) == "/"? "" : "/");
            $img->readImage($curDir."docs/$fileName");

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
                
                for( $i = 0; $i < $img->getNumberImages(); $i++ )
                {
                    $img->setImageIndex($i);
                    if( $img->getImageWidth() / $img->getImageHeight() == $ratio )
                    {
                        saveImages($img, $dbCon, $curDir, $newID, $pageNum, $stdHeight, $stdWidth, $zoomVal);
                        $pageNum++;
                    }
                    
                    else
                    {
                        if( $img->getImageWidth() > $stdWidth * 1.5 )
                        {
                            $leftImg = $img->getImage();
                            $leftImg->cropImage($img->getImageWidth()/2, $img->getImageHeight(), 0, 0);
                            saveImages($leftImg, $dbCon, $curDir, $newID, $pageNum, $stdHeight, $stdWidth, $zoomVal);
                            $leftImg->destroy();
                            $pageNum++;
                            
                            $rightImg = $img->getImage();
                            $rightImg->cropImage($img->getImageWidth()/2, $img->getImageHeight(), $img->getImageWidth()/2, 0);
                            saveImages($rightImg, $dbCon, $curDir, $newID, $pageNum, $stdHeight, $stdWidth, $zoomVal);
                            $rightImg->destroy();
                            $pageNum++;
                        }
                        
                        else
                        {
                            saveImages($img, $dbCon, $curDir, $newID, $pageNum, $stdHeight, $stdWidth, $zoomVal);
                            $pageNum++;
                        }
                    }
                }
            }

            $brochure->setValue("width", $stdWidth);
            $brochure->setValue("height", $stdHeight);
            chdir($tmpCurDir);
        }
    }
    $page = "/";
    if( !empty($_POST['page']) )
        $page = $_POST['page'];
        
    header("Location: $page");

function saveImages(Imagick &$img, bseConnection $dbCon, $curDir, $id, $page, $height, $width, $zoom)
{
    $zmImg = $img->clone();
    $zmImg->resizeImage($width*$zoom, $height*$zoom, Imagick::FILTER_BESSEL, .5);
    $zmImg->writeImage($curDir."pages/zoom$id-$page.jpg");
    $img->resizeImage($width, $height, Imagick::FILTER_CUBIC, .5);
    $img->writeImage($curDir."pages/$id-$page.jpg");
    $dbCon->getQueryResult("INSERT INTO `bseBrochurePages` SET `brochureID`='$id', `imageFile`='$id-$page.jpg', `pageNum`='$page'");
    $zmImg->destroy();
}
?>