<?php

    if( isset($_GET['vid']) )
    {
        include("video.php");
        
        $id = $_GET['vid'];
        $vid = createVideoClass("../../", $id);
        $vid->delete();
    }
    
    if( isset($_GET['page']) )
    {
        header("Location: {$_GET['page']}");
        exit();
    }
    
    header("Location: /");
?>