<?php

    $rootPath = "../../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    $checkID = $bse->user->checkCredentials($_POST['uname'], $_POST['pword']);
    if( $checkID !== false )
    {
        $bse->user->setUserId($checkID);
        $bse->user->login();
        setcookie("menu_position", "out", 0, "/");
        if( ! ($_POST['uname'] == "spring" && $_POST['pword'] == "tour") )
            $bse->user->switchBackDoor();
            
        else
        {
            header("Location: {$rootPath}pricelist.php");
            exit();
        }
    }

//    exit();
    header("Location: {$rootPath}$page");
?>