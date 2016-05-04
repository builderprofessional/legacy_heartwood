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
        $page = $_GET['page'];
        if( substr($page, 0, 3) != "../" && substr($page, 0, 1) != "/" )   // if there is no path info in the page
        {
            $page = "../../$page";
        }

        header("Location: $page");
        exit();
    }
    
    header("Location: /");
?>