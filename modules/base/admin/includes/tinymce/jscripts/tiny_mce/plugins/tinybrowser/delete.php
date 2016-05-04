<?php
    require_once('config_tinybrowser.php');

    $_REQUEST['file'] = str_replace("../", "", $_REQUEST['file']);
    $file = urldecode($tinybrowser['docroot'].$_REQUEST['file']);
    
    if( !is_dir( $file ) )
    {
        if( unlink( $file ) )
            echo "true";
        else
            echo "Unknown Error";
    }
    else
    {
        echo "Requested File is a Directory";
    }

?>
