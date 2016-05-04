<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;



    if( isset($_POST['detailsDefaultMeta']) )
    {
        $countItems = count($_POST['title']);
        $cmd = "INSERT INTO `bseCommunityDetailDefaultMetaData` ";
        $where = "";
        $set = "";

        if( $_POST['insert'] == 'true' )
        {
            $set = "(`panel`,`title`,`desc`,`keywords`) VALUES";

            for( $i = 1; $i <= $countItems; $i++ )
            {
                $panel = $i;
                $title = $bse->db->getEscapedString($_POST['title'][$i]);
                $desc = $bse->db->getEscapedString($_POST['desc'][$i]);
                $keys = $bse->db->getEscapedString($_POST['keys'][$i]);
                $set .= "('$panel','$title','$desc','$keys')".($i == $countItems ? "" : ",");
            }
        }
        else
        {
            $cmd = "UPDATE `bseCommunityDetailDefaultMetaData` ";
            $set = "SET ";
            $where = "WHERE `panel` IN (";
            $titleArg = "`title` = CASE `panel` ";
            $descArg = "`desc` = CASE `panel` ";
            $keysArg = "`keywords` = CASE `panel` ";

            for( $i = 1; $i <= $countItems; $i++ )
            {
                $title = $bse->db->getEscapedString($_POST['title'][$i]);
                $desc = $bse->db->getEscapedString($_POST['desc'][$i]);
                $keys = $bse->db->getEscapedString($_POST['keys'][$i]);

                $titleArg .= "WHEN '$i' THEN '$title' ";
                $descArg .= "WHEN '$i' THEN '$desc' ";
                $keysArg .= "WHEN '$i' THEN '$keys' ";
                $where .= "$i" . ($i == $countItems ? "" : ",");
            }
            $titleArg .= "END, ";
            $descArg .= "END, ";
            $keysArg .= "END";

            $set .= $titleArg . $descArg . $keysArg;
            $where .= ")";
        }
        $sql = "$cmd $set $where";
//die($sql);
        $bse->db->getQueryResult($sql);
    }


    header("Location: $rootPath{$page}");
?>