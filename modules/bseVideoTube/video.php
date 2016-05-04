<?php

    if( !isset($GLOBALS['vidInc']) )
        $GLOBALS['vidInc'] = false;
        
    if( !isset($GLOBALS['conInc']) )
        $GLOBALS['conInc'] = false;
        
    if( !isset($GLOBALS['configInc']) )
        $GLOBALS['configInc'] = false;
    
    function &createVideoClass($root, $videoID)
    {
        $path = "{$root}modules/bseVideo/includes/";
        
        include("{$root}modules/includes/config.inc");
        include("{$path}config.inc");

        if( !$GLOBALS['vidInc'] )
        {
            require_once("{$path}dbClass.inc");
            require_once("{$path}bseVideo.inc");
            $GLOBALS['vidInc'] = true;
        }
        
        if( !$GLOBALS['conInc'] )
        {
            require_once("{$root}modules/base/db/bseConnection.php");
            $GLOBALS['conInc'] = true;
        }
        
        $db = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
        $videoID = mysql_real_escape_string($videoID, $db->getConn());
        $dataArray = $db->getQueryData("SELECT * FROM `bseVideos` WHERE `id` = '$videoID'");
        return new bseVideo($db->GetConn(), $dataArray, "{$root}modules/bseVideo/");
    }
    
    
    function &getBseConnection($root)
    {
        $path = "{$root}modules/includes/";
        include("{$path}config.inc");
        
        if( !$GLOBALS['conInc'] )
        {
            require_once("{$root}modules/base/db/bseConnection.php");
            $GLOBALS['conInc'] = true;
        }
        
        return new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
    }
    
    
    function getUploadHref($root, $returnPage="")
    {
        return "{$root}modules/bseVideo/upload/upload.php?page=../../../$returnPage";
    }
    
    
    function getEditHref($root, $id="", $returnPage="")
    {
        $separator = "?";
        $args = "";
        if( isset($id) )
        {
            $args = "{$separator}vid=$id";
            $separator = "&";
        }
            
        if( isset($returnPage) )
            $args .= "{$separator}page=../../$returnPage";
        
        return "{$root}modules/bseVideo/edit.php$args";
    }
    
    
    function getDeleteHref($root, $id="", $returnPage="")
    {
        $separator = "?";
        $args = "";
        if( isset($id) )
        {
            $args = "{$separator}vid=$id";
            $separator = "&";
        }
            
        if( isset($returnPage) )
            $args .= "{$separator}page=../../$returnPage";
        
        return "{$root}modules/bseVideo/delete.php$args";
    }
?>