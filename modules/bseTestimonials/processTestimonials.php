<?php

    $rootPath = "../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);

    $page = $bse->retPage;
    


//  Save Testimonial changes

    if( isset( $_POST['testimonySave'] ) )
    {
/* Old Code
        $id = $bse->db->getEscapedString($_POST['testid']);
        $title = $bse->db->getEscapedString($_POST['title']);
        $image = $bse->db->getEscapedString($_POST['image']);
        $desc  = $bse->db->getEscapedString($_POST['description']);
        
        $sql = "UPDATE `bseBuildProcess` SET `title`='$title', `description`='$desc', `image_file`='$image' WHERE `id` = '$id'";
        $bse->db->getQueryResult($sql);
*/

        $testimony =& $bse->getModule("bseTestimonialItem");
        $testimony->setItemId($_POST['testid']);
        $testimony->customerName = $_POST['customer'];
        $testimony->image_file = $_POST['image'];
        $testimony->content = $_POST['content'];
        $testimony->commit();
    }
    


//  Add new Testimony
    
    if( isset( $_POST['submitTestimony'] ) )
    {
/*  Old Code
        $title = $bse->db->getEscapedString($_POST['title']);
        $image = $bse->db->getEscapedString($_POST['image']);
        $desc  = $bse->db->getEscapedString($_POST['description']);
        
        $sql = "INSERT INTO `bseBuildProcess` SET `title`='$title', `description`='$desc', `image_file`='$image'";
        $bse->db->getQueryResult($sql);
*/

        $testimonies = $bse->getModule("bseTestimonialItems");
        $newid = $testimonies->insertNew();
        $testimony =& $testimonies->getItemById($newid);
        $testimony->customerName = $_POST['customer'];
        $testimony->image_file = $_POST['image'];
        $testimony->content = $_POST['content'];
        $testimony->commit();
    }
    
    
    
//  Delete Testimony Item

    if( isset( $_REQUEST['delid'] ) )
    {
        $testimonies = $bse->getModule("bseTestimonialItems");
        $testimonies->deleteItem($_REQUEST['delid']);
    }
    
    
    header("Location: {$rootPath}$page");
?>