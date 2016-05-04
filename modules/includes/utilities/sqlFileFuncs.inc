<?php

    function getSqlFileContents($sqlFile)
    {
        $docRoot = dirname($_SERVER['SCRIPT_FILENAME']);
        $docRoot .= ( substr($docRoot, -1) == "/" ? "" : "/" );
        $f = fopen($docRoot.$sqlFile,"r");
        $sqlFileData = fread($f,filesize($docRoot.$sqlFile));
        $sqlArray = explode(';',$sqlFileData);
        return $sqlArray;
    }

        

    function runSqlFromArray($dataAry, &$sqlErrorCode, &$sqlErrorText, $sqlErrorStatement)
    {
        $ret = true;
        foreach ($dataAry as $stmt) 
        {
            if (strlen($stmt)>3)
            {
                $result = mysql_query($stmt);
                if( $result === false )
                {
                    $sqlErrorCode      .= mysql_errno()."|";
                    $sqlErrorText      .= mysql_error()."|";
                    $sqlErrorStatement .= $stmt."|";
                    return false;
                }
            }
        }
        return $ret;
    }

    function table_exists($table, $dbCon) 
    {
        $ret = false;
        $result = mysql_query("SHOW TABLES LIKE '$table'", $dbCon);
        
        if( $result == true )
        {
            if( mysql_num_rows($result) > 0 )
            {
                $ret = true;
            }
        }

        return $ret;
    }
    
    function scheme_exists($schema, $dbCon)
    {
        $ret = false;
        $result = mysql_query("show databases like '$schema'", $dbCon);
        
        if( $result && $schema != "" )
            if (mysql_num_rows($result)>0 )
                $ret = true;

        return $ret;
    }

?>