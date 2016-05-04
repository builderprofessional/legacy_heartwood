<?php

    include("includes/config.inc");
    
    $errNos = $errDescs = $errStatements = "";
    $install = false;
    
    // Check if the table exists, if not create it
    if ($conn !== false)
    {
        if( mysql_select_db($dbSchema, $conn) )
        {
            if( !table_exists("bseVideos", $conn) )
            {
                if( isset($_POST['modInstall_bseVideo']) )
                {
                    $old = umask(0);
                    doDirDuties("bseVideo/upload/tmp/", $errNos, $errDescs);
                    doDirDuties("bseVideo/images/", $errNos, $errDescs);
                    doDirDuties("bseVideo/videos/", $errNos, $errDescs);
                    umask($old);

                    $sql = getSqlFileContents("bseVideo/includes/install.sql");
                    $install = runSqlFromArray($sql, $errNos, $errDescs, $errStatements);
                    //if( $errDescs == "" )
                        //$install = true;
                }
            }       

            else
            {
                $install = true;
                $docRoot = dirname($_SERVER['SCRIPT_FILENAME']);
                $docRoot .= ( substr($docRoot, -1) == "/" ? "" : "/" );

                if( !file_exists($docRoot."bseVideo/upload/tmp/") )
                {
                    $errNos .= "-1|";
                    $errDescs .= "bseVideo/upload/tmp directory does not exist.|";
                }
                
                if( !file_exists($docRoot."bseVideo/images/") )
                {
                    $errNos .= "-1|";
                    $errDescs .= "bseVideo/images directory could not be created.|";
                }
                
                if( !file_exists($docRoot."bseVideo/videos/") )
                {
                    $errNos .= "-1|";
                    $errDescs .= "bseVideo/videos directory could not be created.|";
                }
                
                if( !table_exists("bseVideos", $conn) )
                {
                    $errNos .= "0|";
                    $errDescs .= "The database does not have the table 'bseVideos'.|";
                }
            }
        }
    }
    
    $errs = explode("|", $errNos);
    $descs = explode("|", $errDescs);
    $lines = explode("|", $errStatements);
    
?>

    <tr>
        <td style="width:10px; ">
            <input type="checkbox" name="modInstall_bseVideo" value="1"<?=($install?' checked="checked"':"")?> />
        </td>
        <td style="width:80%; padding-left:10px; ">
            BSE Video Module
            <?php 
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
            Installed:<br /><?= ($install?($errs[0]!=""?"Error":"Yes"):"No") ?>
        </td>
    </tr>