<?php

    $prefix = "bseAvailableHomes";
    $moduleName = "BSE Available Homes";

    include("config.inc");
    include("$prefix/includes/config.inc");
    $imageDir .= ( substr($imageDir, -1)=="/"?"":"/");
    $modFile = "bseAvailableHomes.inc";
    $modVersion = "0.2";

    $tables = array('bseAvailableHome'=>'bseHomes','bseAvailableHomes'=>'bseHomesPage',''=>'sent_mails');
    $dirs = array("$prefix/$imageDir","$prefix/{$imageDir}_thumbs/");
    



    $errNos = $errDescs = $errStatements = "";
    $installed = false;
    
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
                    multiDirDuties($dirs, $errNos, $errDescs);
                    umask($old);

                    $sql = getSqlFileContents("{$prefix}/includes/install.sql");
                    $installed = runSqlFromArray($sql, $errNos, $errDescs, $errStatements);
                    if( $installed )
                    {
                        setModuleInformation($prefix, $modFile, $modVersion, $tables);
                    }
                }
            }       

            else
            {
                $installed = true;
                $docRoot = dirname($_SERVER['SCRIPT_FILENAME']);
                $docRoot .= ( substr($docRoot, -1) == "/" ? "" : "/" );
                
                checkDirs($docRoot, $dirs, $errNos, $errDescs);
                if( !checkTables($tables, $conn) )
                {
                    $errNos .= "0|";
                    $errDescs .= "The database does not have the table(s) required.|";
                }
            }
        }
        else
        {
            $errNos .= "-256|";
            $errDescs .= "Could not select the schema '$dbSchema'";
        }
    }
    else
    {
        $errNos .= "-256|";
        $errDescs .= "There is no Connection to the Database";
    }
    
    $errs = explode("|", $errNos);
    $descs = explode("|", $errDescs);
    $lines = explode("|", $errStatements);
    
?>

    <tr>
        <td style="width:10px; ">
            <input type="checkbox" name="modInstall_<?=$prefix?>" value="1"<?=($installed?' checked="checked"':"")?> />
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
            Installed:<br /><?= ($installed?($errs[0]!=""?"Error":"Yes"):"No") ?>
        </td>
    </tr>