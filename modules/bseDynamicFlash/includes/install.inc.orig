<?php

    $prefix = "bseDynamicFlash";
    $moduleName = "BSE Dynamic Flash Slideshow";

    include("includes/config.inc");
    include("$prefix/includes/config.inc");

    $tables = array('bseDynamicFlash'=>'bseFlashSlideshows', 'bseDynamicFlashImages'=>'bseFlashSlideshowImages', 'bseDynamicFlashImages'=>'bseFlashSlideshowImages');
    $modFile = "bseDynamicFlash.inc";
    $modVersion = "0.1";
    $dirs = array("$prefix/$imageDir");



    $ErrNos = $ErrDescs = $ErrStatements = "";
    $Install = false;
    
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
                    multiDirDuties($dirs, $ErrNos, $ErrDescs);
                    umask($old);

                    $sql = getSqlFileContents("{$prefix}/includes/install.sql");
                    $Install = runSqlFromArray($sql, $ErrNos, $ErrDescs, $ErrStatements);
                    if( $Install )
                    {
                        setModuleInformation($prefix, $modFile, $modVersion, $tables);
                    }
                }
            }       

            else
            {
                $Install = true;
                $docRoot = dirname($_SERVER['SCRIPT_FILENAME']);
                $docRoot .= ( substr($docRoot, -1) == "/" ? "" : "/" );
                
                checkDirs($docRoot, $dirs, $ErrNos, $ErrDescs);
                if( !checkTables($tables, $conn) )
                {
                    $ErrNos .= "0|";
                    $ErrDescs .= "The database does not have the table(s) required.|";
                }
            }
        }
        else
        {
            $ErrNos .= "-256|";
            $ErrDescs .= "Could not select the schema '$dbSchema'";
        }
    }
    else
    {
        $ErrNos .= "-256|";
        $ErrDescs .= "There is no Connection to the Database";
    }
    
    $errs = explode("|", $ErrNos);
    $descs = explode("|", $ErrDescs);
    $lines = explode("|", $ErrStatements);
    
?>

    <tr>
        <td style="width:10px; ">
            <input type="checkbox" name="modInstall_<?=$prefix?>" value="1"<?=($Install?' checked="checked"':"")?> />
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
            Installed:<br /><?= ($Install?($errs[0]!=""?"Error":"Yes"):"No") ?>
        </td>
    </tr>