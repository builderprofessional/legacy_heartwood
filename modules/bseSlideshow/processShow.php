<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;
    $show = $bse->getModule("bseSlideshow");



// Check to see if the slide show editing form below has been posted. If so, update the database & upload the picture.
    if( isset($_POST['updateShow']) )
    {
        $dur = $_POST['duration'];
        $file = $_FILES['image']['name'];
        if( move_uploaded_file($_FILES['image']['tmp_name'], "{$rootPath}modules/bseSlideshow/images/$file") )
        {
            $bse->db->getQueryResult("INSERT INTO `{$show->images->table}` SET `show_id`='1',`file`='$file'");
        }
        $bse->db->getQueryResult("UPDATE `{$show->table}` SET `duration`='$dur' WHERE `id`='1'");
    }


// Check to see if the picture sort order form below has been posted. If so, update the database with the correct order.
    if( isset($_POST['updateOrder']) )
    {
        $catid = $_POST['catid'];
        $sql = "UPDATE `{$show->images->table}` SET `sorder` = CASE `id` ";

        for( $i = 0; $i < count($_POST['sorder']); $i++ )
        {
            $id = $_POST['sorder'][$i];
            $sorder = $i;
            $sql .= "WHEN '$id' THEN '$sorder' ";
        }
        $sql .= "END";

        $bse->db->getQueryResult($sql) OR die(mysql_error());
    }


// Check if we are deleting an image
    if( isset($_REQUEST['delid']) )
    {
        $delid = $_REQUEST['delid'];
        $sql = "DELETE FROM `{$show->images->table}` WHERE `id` = '$delid'";
        $bse->db->getQueryResult($sql) OR die(mysql_error() );
        header("Location: ./");
    }
    
    header("Location: $rootPath{$page}");
?>