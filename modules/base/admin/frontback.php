<?php


    $rootPath = "../../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    $bse->user->switchBackDoor();
    header("Location: {$rootPath}$page");
?>
