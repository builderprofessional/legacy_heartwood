<?php

    $rootPath = "../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);

    $page = $bse->retPage;
    


//  Save build process changes

    if( isset($_POST['processSorderSubmit']) )
    {
    	$process =& $bse->getModule("bseBuildProcessItems");
        for($i = 0; $i <= count($_POST['sorder']); $i++)
        {
            echo "sorder[$i] = {$_POST['sorder'][$i]}, ";
            $item =& $process->getItemById( $_POST['sorder'][$i] );
            if( $item != null )
            {
                $item->undirty();
                $item->sorder = $i;
                $item->commit();
            }
            echo "item->id = {$item->id}\n";
        }
        $process->arrangeBySortorder();
        exit();
    }
    
    

    if( isset( $_POST['processSave'] ) )
    {
        $id = $bse->db->getEscapedString($_POST['buildid']);
        $title = $bse->db->getEscapedString($_POST['title']);
        $image = $bse->db->getEscapedString($_POST['image']);
        $desc  = $bse->db->getEscapedString($_POST['description']);
        
        $sql = "UPDATE `bseBuildProcess` SET `title`='$title', `description`='$desc', `image_file`='$image' WHERE `id` = '$id'";
        $bse->db->getQueryResult($sql);
    }
    


//  Add new build process
    
    if( isset( $_POST['submitBuildProcess'] ) )
    {
        $title = $bse->db->getEscapedString($_POST['title']);
        $image = $bse->db->getEscapedString($_POST['image']);
        $desc  = $bse->db->getEscapedString($_POST['description']);
        
        $sql = "INSERT INTO `bseBuildProcess` SET `title`='$title', `description`='$desc', `image_file`='$image'";
        $bse->db->getQueryResult($sql);
    }
    
    
    
//  Delete Build Process Item

    if( isset( $_REQUEST['delid'] ) )
    {
        $processItems = $bse->getModule("bseBuildProcessItems");
        $processItems->deleteItem($_REQUEST['delid']);
    }
    
    
    header("Location: {$rootPath}$page");
?>