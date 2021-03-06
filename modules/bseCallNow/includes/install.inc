<?php

    $prefix = "bseCallNow";
    $moduleName = "BSE Call Now";

    include("config.inc");
//    include("$prefix/includes/config.inc");

    $tables = array('bseCallNow');
    $dirs = array();



    $baseErrNos = $baseErrDescs = $baseErrStatements = "";
    $baseInstall = false;
    
    // Check if the table exists, if not create it
    if ($conn !== false)
    {
        if( mysql_select_db($dbSchema, $conn) )
        {
            if( !checkTables($tables, $conn) )
            {
                if( isset($_POST["modInstall_$prefix"]) )
                {
                    $old = umask(0);
                    multiDirDuties($dirs, $baseErrNos, $baseErrDescs);
                    umask($old);

                    $sql = getSqlFileContents("{$prefix}/includes/install.sql");
                    $baseInstall = runSqlFromArray($sql, $baseErrNos, $baseErrDescs, $baseErrStatements);
                }
            }       

            else
            {
                $baseInstall = true;
                $docRoot = dirname($_SERVER['SCRIPT_FILENAME']);
                $docRoot .= ( substr($docRoot, -1) == "/" ? "" : "/" );
                
                checkDirs($docRoot, $dirs, $baseErrNos, $baseErrDescs);
                if( !checkTables($tables, $conn) )
                {
                    $baseErrNos .= "0|";
                    $baseErrDescs .= "The database does not have the table(s) required.|";
                }
            }
        }
        else
        {
            $baseErrNos .= "-256|";
            $baseErrDescs .= "Could not select the schema '$dbSchema'";
        }
    }
    else
    {
        $baseErrNos .= "-256|";
        $baseErrDescs .= "There is no Connection to the Database";
    }
    
    $errs = explode("|", $baseErrNos);
    $descs = explode("|", $baseErrDescs);
    $lines = explode("|", $baseErrStatements);
    
?>

    <tr>
        <td style="width:10px; ">
            <input type="checkbox" name="modInstall_<?=$prefix?>" value="1"<?=($baseInstall==true?' checked="checked"':"")?> />
        </td>
        <td style="width:80%; padding-left:10px; ">
            <?php 
            echo $moduleName;
            for( $i = 0; $i < count($errs)-1; $i++)
            {
                if( $errs[$i] == -1 )
                    echo '<div style="margin-left:13px;">'.$descs[$i]."</div>\n";
                else
                    echo '<div style="margin-left:13px;">MySQL Error: '.$errs[$i].'<span style="margin-left:10px;">'.$descs[$i]."</span></div>\n";
            }
            
            ?>
        </td>
        <td style="text-align:center; ">
            Installed:<br /><?= ($baseInstall?($errs[0]!=""?"Error":"Yes"):"No") ?>
        </td>
    </tr>
