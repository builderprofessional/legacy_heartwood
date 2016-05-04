<?php

    $rootPath = "../../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    $conn = $bse->db->getConn();
    
    $title = mysql_real_escape_string($_POST['title'], $conn);
    $file = $_POST['file'];
    $file = mysql_real_escape_string($file, $conn);
    
    $sql = "INSERT INTO `bseVideos` SET `title`='$title', `originalFile`='$file', `videoFile`='$file', `active`=0;";
    $result = $bse->db->getQueryResult($sql, $conn);
    if( $result == false )
    {
        header("Location: error.php");
        exit();
    }
    
    session_start();
    $_SESSION['upVidID'] = mysql_insert_id($conn);
    mysql_close($conn);
    header("Location: editVideo.php?vidID={$_SESSION['upVidID']}");
?>