<?php

    $rootPath = "../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);

    $catid = $_REQUEST['catid'];
    $page = $bse->removeArgFromURL("catid", $bse->retPage);
    $page .= ( strpos($page, "?") === false ? "?" : "&" ) . "catid=$catid";

    include("includes/config.inc");
    $imgloc = $imageDir . ( substr($imageDir, -1) == "/" ? "" : "/" );

    $gallery =& $bse->getModule("bsePhotoGallery");
    $category =& $gallery->categories->getItemById($_POST['catid']);


    if( isset($_POST['gallerySorderSubmit']) )
    {
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



    if( isset($_POST['addImagesSubmit']) )
    {
        $imgs = $_POST['imgUrls'];
        
        for( $i = 0; $i < count($imgs); $i++ )
        {
            $newID =& $category->images->insertNew();
            $img =& $category->images->getItemById($newID);
            $img->undirty();
            $img->catid = $catid;
            $img->image_file = $imgs[$i];
            $img->commit();
        }
        
    }
    
    
    
    if( isset($_POST['descsSubmit']) )
    {
        $descriptions = $_POST['imgDescriptions'];
//        echo "<pre>";var_dump($_POST);echo "</pre>";die();
        foreach( $descriptions as $id => $desc )
        {
            $img = $category->images->getItemById($id);
            $img->undirty();
            $img->caption = $desc;
            $img->commit();
        }
    }
    
    
    
    if( isset($_REQUEST['delcat']) )
    {
        $catid = $bse->db->getEscapedString($_REQUEST['catid']);
        $gallery->categories->deleteItem($catid);
        
        $page = $bse->removeArgFromURL("catid", $page);
        header("Location: {$rootPath}$page");
    }
    
    
    
    if( isset( $_POST['catAction'] ) )
    {
        if( $_POST['catAction'] == "rename" )
        {
            $category->undirty();
            $category->name = $_POST['catName'];
            $category->commit();
        }
        else
        {
            $newId = $gallery->categories->insertNew();
            $category =& $gallery->categories->getItemById($newId);
            $category->undirty();
            $category->name = $_POST['catName'];
            $category->galid = $gallery->id;
            $category->commit();
            $page = $bse->removeArgFromURL("catid", $page);
            $page .= ( strpos($page, "?") === false ? "?" : "&" ) . "catid=$newId";
        }
    }


    header("Location: $rootPath{$page}");
?>