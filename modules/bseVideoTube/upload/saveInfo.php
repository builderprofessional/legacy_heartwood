<?php

    include("../../includes/config.inc");
    include("../../base/db/bseConnection.php");
                                                                               
    $dbCon = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
    $conn = $dbCon->getConn();
    
    $title = mysql_real_escape_string($_POST['title'], $conn);
    $file = substr(strrchr(str_replace("\\", "/", $_POST['file']), "/"), 1);
    $file = mysql_real_escape_string($file, $conn);
    
    $sql = "INSERT INTO `bseVideos` SET `title`='$title', `videoFile`='$file', `active`=0;";
    $result = $dbCon->getQueryResult($sql, $conn);
    if( $result == false )
    {
        header("Location: error.php");
        exit();
    }
    
    session_start();
    $_SESSION['upVidID'] = mysql_insert_id($conn);
    mysql_close($conn);
    if( isset($_POST['sid']) )
    {
        $sid = stripslashes($_POST['sid']);
        exec("rm -rf tmp/$sid/ > /dev/null");
    }
    header("Location: editVideo.php");
?>