<?php

    function getModulesParentDir($curDir, $resetRet = true)
    {
        static $ret = "";
        if( $resetRet )
            $ret = "";

        if( basename($curDir) == "modules" )
        {
            $ret .= "../";
            return $ret;
        }

        else if( basename($curDir) != "" )
        {
            $ret .= "../";
            getModulesParentDir( dirname($curDir), false);
            return $ret;
        }
    
        else
            return "";
    }

?>