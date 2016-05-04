<?php

    $rootPath = "../../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = urlencode($bse->retPage);

    $bse->user->logout();

    if( file_exists("{$rootPath}$page") )
        header("Location: {$rootPath}$page");
    else
        header("Location: {$rootPath}");
?>