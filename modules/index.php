<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <style>
        table 
        {
            border-collapse:collapse;
        }
        
        td
        {
            border-style:solid; 
            border-color:#000000; 
            border-width:1px;
        }
    </style>
<body>
    <div style="width:100%; text-align:center; font-size:20px; font-weight:900; font-family:Arial, Verdana, Sans; ">BSE Modules Install Page</div>

<?php


    function setModuleInformation($directory, $filename, $fileversion, $tables)
    {
        $sql_cmd = "";
        $where = "";
        $date = date("Y-m-d H:i:s");


        $fileid = 0;
        $query = mysql_query("SELECT * FROM `bseModuleFiles` WHERE `file_name`='$filename'");

        if( mysql_num_rows($query) > 0 )     // File found
        {
            $data = mysql_fetch_array($query);
            $fileid = $data['file_id'];
            if( $fileversion != $data['file_version'] )
                mysql_query("UPDATE `bseModuleFiles` SET `file_name` = '{$filename}$date' WHERE `file_id` = '{$data['file_id']}'");
        }        

        $modFile_sql = "INSERT INTO `bseModuleFiles` SET `file_name`='$filename', `module_directory`='$directory', `file_version`='$fileversion', `file_installed`='1', `file_install_date`='$date'";
        mysql_query($modFile_sql) or die("Error on line ".__LINE__.": ". mysql_error() ."<br />sql = '$modFile_sql'" );
        $fileid = mysql_insert_id();
        
        $mod_sql = "INSERT INTO `bseModules` (`file_id`, `module_name`, `db_table_name`, `module_installed`)
        VALUES
            ";
        
        $tblCase = "(CASE `module_name` ";
        foreach($tables as $mod => $table )
        {
            $mod_sql .= "($fileid,'$mod','$table',1),";
            $tblCase .= "WHEN '$mod' THEN '$table' ";
        }
        
        $mod_sql = substr($mod_sql, 0, strlen($mod_sql) - 1);    // Remove the last comma
        $tblCase .= "END)";
        $mod_sql .= "ON DUPLICATE KEY UPDATE `file_id` = '$fileid', module_name = VALUES(`module_name`), `db_table_name` = $tblCase, `module_installed` = 1";
        mysql_query($mod_sql) OR die("Error on line ".__LINE__.": ". mysql_error() ."<br />sql = '$mod_sql'" );
    }


    function doDirDuties($dir, &$errNums, &$errTexts)
    {
        $docRoot = dirname($_SERVER['SCRIPT_FILENAME']);
        $docRoot .= ( substr($docRoot, -1) == "/" ? "" : "/" );
        if( !file_exists($docRoot.$dir) )
        {
            if( !mkdir($dir, 0777) )
            {
                $errNums .= "-1|";
                $errTexts .= "$dir directory could not be created.|";
            }
        }
        else if( substr(sprintf('%o', fileperms($docRoot.$dir)), -4) != "0777" )
        {
            if( !chmod($docRoot.$dir, 0777) )
            {
                $errNums .= "-1|";
                $errTexts .= "$dir directory could not be chmoded.|";
            }
        }
    }



    function checkTables($tables, $con)
    {
        $ret = true;
        foreach( $tables as $table )
        {
            if( !table_exists($table, $con) )
            {
                $ret = false;
                break;
            }
        }

        return $ret;
    }


    function checkDirs($docRoot, $dirs, &$errNums, &$errTexts)
    {
        foreach( $dirs as $dir )
        {
            if( !file_exists($docRoot.$dir) )
            {
                $errNos .= "-1|";
                $errDescs .= "$dir directory does not exist.|";
            }
        }
    }


    function multiDirDuties($dirs, &$errNums, &$errTexts)
    {
        $ret = true;
        foreach( $dirs as $dir )
        {
            doDirDuties($dir, $errNums, $errTexts);
        }
    }


    include("config.inc");
    include("includes/utilities/sqlFileFuncs.inc");
    $conn = mysql_connect($dbHost, $dbUser, $dbPass);
    if( !scheme_exists($dbSchema, $conn) )
    {
        echo "The Database ($dbSchema) was not found on the host, $dbHost!<br />Please create that database or edit the config file to point to the correct database.<br />Cannot continue, exiting!";
    }

    else
    {
        mysql_select_db($dbSchema);
?>
    <form method="post">
        <table style="width:60%; ">
<?php

// Check if modules are installed, if not, prompt to install them.
    $dir = opendir("./");
    while( false !== ($file = readdir($dir)) )
    {
        if( is_dir($file) && $file != "." && $file != ".." )
        {
            if( file_exists( "$file/includes/install.inc" ) )
                include("$file/includes/install.inc");
        }
    }

?>
        </table>
        <input type="submit" value="Install" />
    </form>
<?php
    }
?>
</body>
</html>