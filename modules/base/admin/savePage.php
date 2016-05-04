<?php

    $rootPath = "../../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $ret_page = $bse->retPage;
    if( !$bse->user->loggedIn )
    {
        header("Location: $rootPath");
        exit();
    }

    if( trim($ret_page) != "" )
    {
        $page = $bse->db->getEscapedString($bse->retPage);
        $code = $bse->db->getEscapedString($_POST['code']);
        $title = $bse->db->getEscapedString($_POST['pgeTitle']);
        $desc = $bse->db->getEscapedString($_POST['pgeDesc']);
        $keys = $bse->db->getEscapedString($_POST['pgeKeywords']);
        $qCommand = "";
        $qData = "SET `code`='$code', `metaDesc`='$desc', `metaKeywords`='$keys', `title`='$title'";
        
        $query = $bse->db->getQueryResult("SELECT * FROM `bseContentData` WHERE `page` = '$page'");
        if( mysql_num_rows($query) > 0 )
            $qCommand = "UPDATE `bseContentData` $qData WHERE `page` = '$page'";
            
        else
            $qCommand = "INSERT INTO `bseContentData` $qData, `page` = '$page'";
        
//        die("SQL = '$qCommand'");
        $query = $bse->db->getQueryResult($qCommand);
        if( !$query )
        {
            header("Location: error.php");
            exit();
        }
            
        else
        {
            $bse->user->switchBackDoor();
            header("Location: {$rootPath}$ret_page");
            exit();
        }
    }
    
    else
    {
        header("Location: error.php");
        exit();
    }

?>
