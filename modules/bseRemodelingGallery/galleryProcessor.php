<?php

    $rootPath = "../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);

    $catid = urlencode($_POST['catid']);
    $page = $bse->removeArgFromURL("catid", $bse->retPage);
    $page .= ( strpos($page, "?") === false ? "?" : "&" ) . "catid=$catid";

    include("includes/config.inc");
    $imgloc = $imageDir . ( substr($imageDir, -1) == "/" ? "" : "/" );



    $gallery =& $bse->getModule("bsePhotoGallery");


    if( isset($_POST['gallerySorderSubmit']) )
    {
        $category =& $gallery->categories->getItemById($_POST['catid']);

        for( $i = 0; $i < count($_POST['sorder']); $i++ )
        {
            echo "sorder[$i] = {$_POST['sorder'][$i]}, ";
            $img =& $category->images->getItemById( $_POST['sorder'][$i] );
            if( $img != null )
            {
                $img->undirty();
                $img->sorder = $i;
                $img->commit();
            }
            echo "img->id = {$img->id} <br />";
        }
        $category->images->arrangeBySortorder();
    }
    
    
    
    
// Add a during gallery to a remodeling image
    if( isset( $_REQUEST['addDuringTo'] ) )
    {
        if( trim($_REQUEST['addDuringTo']) == "" || $_REQUEST['addDuringTo'] <= 0 )
        {
            header("Location: {$bse->rootDir}remodeling/duringGallery.php");
            exit();
        }
        
        $imgid = $bse->db->getEscapedString($_REQUEST['addDuringTo']);
        
        $newid = $bse->db->getQueryData("SELECT MAX( `id` ) AS 'maxid' FROM `bsePhotoGalleries` WHERE `id` < 1000");
        $newid = $newid['maxid'] + 1;
        
        $bse->db->getQueryResult("INSERT INTO `bsePhotoGalleries` SET `id` = '$newid'");
        $bse->db->getQueryResult("INSERT INTO `bsePhotoGalleryCategories` SET `galid`='$newid',`name`='During'");
        $bse->db->getQueryResult("UPDATE `bseRemodelingGalleryImages` SET `during_galid` = '$newid' WHERE `id` = '$imgid'");
        
        header("Location: {$bse->rootDir}remodeling/duringGallery.php?refresh=reloadit");
        exit();
    }
    
    
    


// Add an after image and (optionally) a before image to the remodeling gallery
    if( isset($_POST['remodelsubmit']) )
    {
        $query = $bse->db->getQueryResult("SELECT * FROM `{$gallery->categories->getTable()}` WHERE `galid` = '{$gallery->id}' ORDER BY `sorder` ASC LIMIT 1");
        if( mysql_num_rows($query) > 0 )
        {
            $data = mysql_fetch_array($query);
            $catid = $data['id'];
        }
        $imgid = $_POST['picid'];
        
        if( trim( $_POST['picid'] ) == "new" )
        {
            $image = new bsePhotoGalleryImage($rootPath);
            $imgid = $image->insertNew();
            $image->setImageId($imgid);
            $image->catid = $catid;
            $image->image_file = $_POST['main'];
            $image->commit();
            $gallery->categories->getItemById($catid)->images->add($image);
        }
        
        $imgid = $bse->db->getEscapedString($imgid);
        $before = $bse->db->getEscapedString($_POST['before']);
        $desc = $bse->db->getEscapedString( $_POST['imgDesc']["{$_POST['picid']}"] );
        
        
        $image =& $bse->getModule("bsePhotoGalleryImage");
        $image->setItemId($imgid);

        if( trim($_POST['main']) != $image->image_file )
        {
            $image->image_file = $_POST['main'];
            $image->commit();
        }
        
        $bse->db->getQueryResult("INSERT INTO `bseRemodelingGalleryImages` SET `img_id`='{$imgid}',`before_file`='$before', `description`='$desc' ON DUPLICATE KEY UPDATE `before_file`='$before', `description`='$desc'");
    }    




// Add a during image to the remodeling during gallery
/*
echo "<pre>";
var_dump($_POST);
echo("</pre>");
*/
    if( isset($_POST['remodel_during_submit']) )
    {
        $gallery = new bsePhotoGallery($bse->rootDir);
        $gallery->setGalleryId($_POST['durgalid']);
//echo "Set gallery, id = '{$gallery->id}'<br />";        
        $query = $bse->db->getQueryResult("SELECT * FROM `{$gallery->categories->getTable()}` WHERE `galid` = '{$gallery->id}' ORDER BY `sorder` ASC LIMIT 1");
        if( mysql_num_rows($query) > 0 )
        {
            $data = mysql_fetch_array($query);
            $catid = $data['id'];
//echo "Got catid: '$catid'<br />";
        }
        $imgid = $_POST['durpicid'];
        
//echo "Imgid = '$imgid'<br />";
        if( trim( $_POST['durpicid'] ) == "new" )
        {
//echo "Creating new image<br />";
            $image = new bsePhotoGalleryImage($rootPath);
            $imgid = $image->insertNew();
//echo "New Image id = '$imgid'<br />";
            $image->setImageId($imgid);
            $image->catid = $catid;
            $image->image_file = $_POST['main'];
            $image->commit();
            $gallery->categories->getItemById($catid)->images->add($image);
        }
        
        $imgid = $bse->db->getEscapedString($imgid);
        
        $image =& $bse->getModule("bsePhotoGalleryImage");
        $image->setItemId($imgid);

        if( trim($_POST['main']) != $image->image_file )
        {
//echo "Changed Image file, setting new value to '{$_POST['main']}'<br />";
            $image->image_file = $_POST['main'];
            $image->commit();
        }
        
        header("Location: {$bse->rootDir}remodeling/duringGallery.php?galid={$gallery->id}");
        exit();
    }    







// Delete an image from remodeling main gallery
    if( isset($_REQUEST['delid']) && @trim( $_REQUEST['delid']) != "" )
    {
        $delid = $bse->db->getEscapedString($_REQUEST['delid']);
        
        $bse->db->getQueryResult("DELETE FROM `bseRemodelingGalleryImages` WHERE `img_id` = '$delid'");
    }
    


// Delete an image from remodeling during gallery
    if( isset($_REQUEST['deldurid']) && @trim( $_REQUEST['deldurid']) != "" )
    {
        $delid = $bse->db->getEscapedString($_REQUEST['deldurid']);
        
        $bse->db->getQueryResult("DELETE FROM `bsePhotoGalleryImages` WHERE `id` = '$delid'");
        header("Location: {$bse->rootDir}remodeling/duringGallery.php?galid={$_REQUEST['galid']}");
        exit();
    }
    


    header("Location: $rootPath{$page}");
?>