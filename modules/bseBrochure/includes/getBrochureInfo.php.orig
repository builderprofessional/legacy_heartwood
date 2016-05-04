<?php

    header ("content-type: text/xml");
    echo '<?xml version="1.0" encoding="utf-8" ?>
    ';
    
    $bID = 0;
    if( isset($_GET['id']) )
    {
        $bID = $_GET['id'];
    }
    
    else
    {
        echo "";
        exit();
    }
    
    include( "config.inc");
    $pagesDir .= ( substr( $pagesDir, -1) == "/" ? "" : "/" );
    
    
    $rootPath = "../../";
    require("{$rootPath}includes/main/bseMain.php");
    $bse = new bse($rootPath);
    
    $resource = $bse->db->getQueryResult("SELECT * FROM `bseBrochurePages` WHERE `brochureid` = '$bID' ORDER BY `pageNum` ASC");
    
    echo "<data>
        ";
    while( $data = mysql_fetch_array($resource) )
    {
        if( file_exists("../$pagesDir".$data['imageFile']) )
            echo "<page>{$data['imageFile']}</page>
        ";
    }
    echo "
    </data>";

?>
