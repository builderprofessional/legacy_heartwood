<?php

    if( !isset($GLOBALS['broInc']) )
        $GLOBALS['included'] = false;
        
    if( !isset($GLOBALS['conInc']) )
        $GLOBALS['conInc'] = false;
        
    if( !isset($GLOBALS['configInc']) )
        $GLOBALS['configInc'] = false;
    
    function &createBrochureClass($root, $brochureID)
    {
        $path = "{$root}modules/bseBrochure/includes/";
        
        include("{$root}modules/includes/config.inc");
        include("{$path}config.inc");

        if( !$GLOBALS['broInc'] )
        {
            require_once("{$root}modules/includes/dbClass.inc");
            require_once("{$path}bseBrochure.inc");
            $GLOBALS['broInc'] = true;
        }
        
        if( !$GLOBALS['conInc'] )
        {
            require_once("{$root}modules/base/db/bseConnection.php");
            $GLOBALS['conInc'] = true;
        }
        
        $db = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
        $brochureID = mysql_real_escape_string($brochureID, $db->getConn());
        $dataArray = $db->getQueryData("SELECT * FROM `bseBrochures` WHERE `id` = '$brochureID'");
        return new bseBrochure($db->GetConn(), $dataArray, "{$root}modules/bseBrochure/");
    }
    
    
    function getUploadHref($root, $returnPage="")
    {
        return "{$root}modules/bseBrochure/upload/upload.php?page=$returnPage";
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
            $args .= "{$separator}page=$returnPage";
        
        return "{$root}modules/bseBrochure/edit.php$args";
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
            $args .= "{$separator}page=$returnPage";
        
        return "{$root}modules/bseBrochure/delete.php$args";
    }
?>