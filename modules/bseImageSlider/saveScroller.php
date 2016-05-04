<?php

    include("sliderInc.php");
    include("../base/user/userInc.php");

    includeUserFiles("../../");

    session_start();
    $db = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
    $con = $db->getConn();

    if( $_SESSION['user']->loggedIn !== true )
    {
        header("Location: ../../");
        exit();
    }


    if( isset($_POST['delSliderSubmit']) )
    {
        $id = $db->getEscapedString($_POST['slider_id']);
        $db->getQueryResult("DELETE FROM `bseImageSlider` WHERE `id`='$id' LIMIT 1");
    }
        

    if( isset($_POST['sliderSubmit']) )
    {
        if( trim($_POST['slider_id']) != "new" )
            $slider = createSliderObject("../../", $_POST['slider_id']);
        else
        {
            $db->getQueryResult("INSERT INTO `bseImageSlider` SET `active`='0'", $con);
            $id = mysql_insert_id($con);
            $slider = createSliderObject("../../", $id);
        }
        $slider->setValue("name", $_POST['name']);
        $slider->setValue("scrollWidth", $_POST['width']);
        $slider->setValue("imageHeight", $_POST['height']);
        $slider->setValue("sliderSpeed", $_POST['sliderSpeed']);
        $slider->setValue("backgroundColor", $_POST['bgColor']);

        $space = $_POST['spacing'];
        if( $_POST['spacing'] % 2 != 0 )
           $space++;
        $slider->setValue("spacing", $space);
        if( $slider->active != 1 && $_POST['active'] == 1 )
        {
            $db->getQueryResult("UPDATE `bseImageSlider` SET `active`=0");
            $slider->setValue("active", "1");
        }
        $_SESSION['slider_edit_id'] = $slider->id;
    }


    if( isset($_POST['sliderImageSubmit']) )
    {
        $imgID = $_POST['img_id'];
        $mypic = "";

        if( $_POST['img_id'] == "new" || trim($_FILES['slider_file']['name']) != "" )
        {
            include("includes/config.inc");
            include("../includes/upload_class2.php");

            $handle = new upload($_FILES['slider_file']);
            if ($handle->uploaded) 
            {
                $handle->file_safe_name    = true;
                $handle->file_auto_rename  = true;
                $handle->image_resize      = false;
                $handle->image_convert     = "jpg";
                $handle->jpeg_quality      = 100;
                $handle->process($imageDir.( substr($imageDir, -1)=="/"?"":"/") );
                if ($handle->processed) 
                {
                    $mypic = $handle->file_dst_name;
                    $handle->clean();
                }
                else 
                {
                    $_SESSION['uploadError'] = $handle->log;
                    header("Location: ../../siteAdmin.php?module=slider&err=upload");
                    exit();
                }
            }
            if( trim($mypic) != "" && trim($_POST['img_id']) == "new" )
            {
                $db = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
                $con = $db->GetConn();
                $sliderID = mysql_real_escape_string($_POST['slider_id'], $con);
                $query = $db->getQueryResult("INSERT INTO `bseSlideImage` SET `slider_id`='$sliderID',`sorder`='255'", $con);
                $imgID = mysql_insert_id($con);
            }
        }

        $slider = createSliderObject("../../", $_POST['slider_id']);
        $img = $slider->getImageById($imgID);

        if( trim($mypic) !== "" )
        {
            $img->setValue("image_file", $mypic);
        }
        $img->setValue("description", $_POST['desc']);
        
    }

    if( isset($_POST['delid']) )
    {
        $slider = createSliderObject("../../", $_POST['slider_id']);
        $slider->delete($_POST['img_id']);
//die("slider_id = ".$_POST['slider_id'].", img_id = ".$_POST['img_id']);
    }

    $_SESSION['slider'] = createSliderObject("../../");
    header("Location: ../../siteAdmin.php?module=slider");
?>