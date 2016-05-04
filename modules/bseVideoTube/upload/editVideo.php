<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<?php
    include("../../../Savant3.php");
    include("../../includes/config.inc");
    include("../includes/config.inc");
    include("../../base/db/bseConnection.php");
    $dbCon = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);

    session_start();
    if( isset($_GET['developing']) )
        $_SESSION['upVidID'] = 1;

    $id = $_SESSION['upVidID'];
    unset($_SESSION['upVidID']);
    if( isset($_GET['vidID']) )
        $id = $_GET['vidID'];
    $edit = isset($_GET['vidID']);

    // This is for use by the host application
    $_SESSION['newVidID'] = $id;
    
    $data = $dbCon->getQueryData("SELECT * FROM `bseVideos` WHERE `id` = '$id'");
    $title = $data['title'];
    $previewImgWidth = 165;

    if( $edit )
    {
        $vidFile = ($data['originalFile']==""?$data['videoFile']:$data['originalFile']);
        if( !file_exists(realpath("../$videoDir")."/$vidFile") )
            $vidFile = $data['videoFile'];

        if( !file_exists(realpath("../$videoDir")."/$vidFile") )
            $vidFile = "error";
    }

    else
        $vidFile = $data['videoFile'];

    $file = "../$videoDir/$vidFile";
    $movie = new ffmpeg_movie($file);
    $fps = $movie->getFrameRate();
    $durSecs = $movie->getDuration();
    $frmInterval = $durSecs / 30;
    if( $frmInterval < 1 )
        $frmInterval = 1;
    $frmInterval = 1/$frmInterval;

    $vidWidth = $movie->getFrameWidth();
    $vidHeight = $movie->getFrameHeight();
    if( $movie->hasAudio() )
    {
        $audEnable = true;
        $audSampRate = $movie->getAudioSampleRate();
        if( $audSampRate > 44100 )
            $audSampRate = 44100;

        $audBitRate = intval($movie->getAudioBitRate()/1000);
        if( $audBitRate > 192 || $audBitRate == 0 )
            $audBitRate = 192;
    }

    exec("$ffmpeg -i ".str_replace(" ", '\ ', escapeshellcmd($file))." -r $frmInterval -vframes 35 -f image2 ../$imageDir/frame%d-$id.jpg");

    $plWidth = $vdWidth;
    if( isset($data['playerWidth']) && $data['playerWidth'] != "0" )
        $plWidth = $data['playerWidth'];
    if( empty($plWidth) || $plWidth == 0 )
        $plWidth = $vidWidth;

    $plHeight = $vdHeight;
    if( isset($data['playerHeight']) && $data['playerHeight'] != "0" )
        $plHeight = $data['playerHeight'];
    if( empty($plHeight) || $plHeight == 0 )
        $plHeight = $vidHeight;
        
    if( $forceProperties )
    {
        $plWidth = $vdWidth;
        $plHeight = $vdHeight;
        
        $ratio = $vidWidth/$vidHeight;
        
        if( $vdWidth / $ratio > $vdHeight )
        {
            $vidHeight = $vdHeight;
            $vidWidth = floor($vdHeight * $ratio);
        }
        
        else
        {
            $vidWidth = $vdWidth;
            $vidHeight = floor($vdWidth / $ratio);
        }
    }

?>
    <head>
        <script type="text/javascript" src="vidEdit.js"></script>
        <script type="text/javascript">
            var imgDir = "../<?=$imageDir?>/";
            var ratio = <?= $vidWidth / $vidHeight ?>;
            var picW = <?=$vidWidth?>;
            var picH = <?=$vidHeight?>;
        </script>
        <style type="text/css">
        td {
            font-family: tahoma;
            font-size: 10pt;
        }
        img{ display:block; }
        </style>
    </head>
    <body>
        <form method="post" action="convertVideo.php" enctype="multipart/form-data">
            <div style="width:85%; margin-left:auto; margin-right:auto; margin-bottom:35px; ">
                <center><h3>Editing Your Video</h3></center>
                <div style="font-size:18px; font-weight:900; ">Previewing Your Edits</div>
                <p style="margin:0; padding:0; ">
                    You've successfully uploaded your video, now you can edit it to fit in your player, or resize your player to your liking.
                    First, you'll want to choose an image from below to use as a preview image.
                    This will load the picture into the preview box at the bottom of the page, so you can see what your changes will look like.
                </p>
                <div style="font-size:18px; font-weight:900; margin-top:10px; ">The Options Box</div>
                <p style="margin:0; padding:0; ">
                    Below the preview frames list is the 'Options Box' which contains text boxes to set your desired size(s).
                    The keep aspect ratio checkbox will keep the proportions of the movie as you resize it.
                    If you want to have a smaller file size, you can change the quality of the video with the dropdown box.
                    The color selector is for the background of the video player. If your movie is smaller than the player, you can choose a color that matches your website's color scheme, or you can leave the traditional 'black bars' on your movie.
                </p>
                <div style="font-size:18px; font-weight:900; margin-top:10px; ">Selecting a Preview Image</div>
                <p style="margin:0; padding:0; ">
                    As stated above, you may select an image from those listed in the 'Preview Frames List' below.
                    If you already have an image you want to use for the preview image, you may enter the file in the file box above the Preview Frames List.
                    (Make sure you check the 'Upload Preview Image' checkbox to use an uploaded image).
                    You may also know a specific frame of the movie you want to be the preview.
                    If so, you may enter the frame number in the box above the preview selctor.
                    <br /><br />
                    The order of priority for a preview image is as follows:<br />
                    First, the uploaded preview image (make sure you check the 'Upload Preview Image' checkbox to use the uploaded file).<br />
                    Second, the frame number box. If you enter a frame number, it will be used instead of a selected frame.<br />
                    Third, the selected frame from the list of images. If you do not check the 'Upload Preview Image' checkbox, and do not enter a frame number in the 'Custom Frame #' box, then whichever image you select from the list will be used as a preview image.
                </p>
            </div>
            <div>Video Title:</div>
            <input type="text" name="vidTitle" value="<?=$title?>" style="width:250px; " />
            <div style="margin-top:35px; ">
                Upload Preview Image <input type="checkbox" name="uploadPreview" /><br />
                <input type="file" name="uploadPreviewImg" style="width:450px; " />
            </div>
            <div style="margin-top:8px; ">Select Preview Image Below, or Enter Custom Frame #: <input type="text" name="previewFrameNum" style="width:50px; " /> (<?= $movie->getFrameCount()?> frames total)</div>
            <div style="margin-top:5px; ">Preview Frames List</div>
            <div style="margin-bottom:10px; width:100%; height:300px; overflow-y:scroll; border-style:solid; border-color:0; border-width:1px; ">
            <?php
                $i = 3;  // The first two frames are blank for some reason, so I started the loop at the 3rd image
                while( file_exists("../$imageDir/frame$i-$id.jpg") )    // Loop through all of the frames created by the command above (ffmpeg...)
                {
                    echo'
                <div id="frame'.$i.'-'.$id.'" style="float:left; width:auto; height:auto; padding:8px; cursor:pointer; " onclick="selectPreview(this, '.$id.');"><img style="width:'.$previewImgWidth.'; " src="resize.php?image=frame'.$i.'-'.$id.'.jpg&w='.$previewImgWidth.'" /></div>';
                    $i++;
                    if( $i > floor($durSecs) + 2 || $i > 32 )
                        break;
                }
            ?>
            </div>
            <div><?php $sizeHidden=""; if( $forceProperties ) {$sizeHidden="display:none; ";} ?>
                <div style="float:left; width:600px; border-style:solid; border-color:0; border-width:1px; margin-top:35px; margin-right:20px; <?=$sizeHidden?>">
                    <div style="margin-top:8px; font-size:26px; font-weight:900; width:100%; text-align:center; "><?= $title ?></div>
                    <div style="margin-top:10px; ">
                        <div style="float:left; width:29%; margin-bottom:12px; position:relative; top:3px; ">
                            <div><div style="float:left; width:100px; text-align:right; margin-right:8px; ">Video Width:</div><div style="float:left; width:50px;"><input id="videoW" type="text" name="videoW" style="width:100%;" onblur="setVideoW(this.value);" value="<?=$vidWidth?>" /></div></div>
                            <div><div style="float:left; width:100px; text-align:right; margin-right:8px; ">Video Height:</div><div style="float:left; width:50px;"><input id="videoH" type="text" name="videoH" style="width:100%;" onblur="setVideoH(this.value);" value="<?=$vidHeight?>" /></div></div>
                            <div><div style="float:left; width:100px; text-align:right; margin-right:8px; ">Player Width:</div><div style="float:left; width:50px;"><input id="playerW" type="text" name="playerW" style="width:100%;" onblur="setPlayerW(this.value);" value="<?=$plWidth?>" /></div></div>
                            <div><div style="float:left; width:100px; text-align:right; margin-right:8px; ">Player Height:</div><div style="float:left; width:50px;"><input id="playerH" type="text" name="playerH" style="width:100%;" onblur="setPlayerH(this.value);" value="<?=$plHeight?>" /></div></div>
                            <div><div style="float:left; width:138px; text-align:right; margin-right:8px; ">Keep Aspect Ratio:</div><div style="float:left; width:10px;"><input id="aspectR" type="checkbox" name="aspectR" checked="checked" /></div></div>
                            <div style="clear:both; "></div>
                            <div style="margin-left:18px; margin-top:20px; ">Video Quality:</div>
                            <div style="margin-left:18px; width:80%; "><select name="vidQuality" style="width:100%; "><option value="-sameq -ar <?=$audSampRate?>">Best</option><option value="-qscale 5 -ar <?=$audSampRate?>">High</option><option value="-qscale 11 -ar <?=($audSampRate>22050?"22050":$audSampRate)?>">Medium</option><option value="-qscale 22 -ar <?=($audSampRate>11025?11025:$audSampRate)?>">Low</option></select></div>
                            <div style="width:100px; height:35px; margin-left:auto; margin-right:15px; margin-top:25px; margin-bottom:5px; text-align:right; "><input type="button" value="Reset" onclick="resetSizes(<?=$vidWidth?>,<?=$vidHeight?>,<?=$plWidth?>,<?=$plHeight?>);" /></div>
                        </div>
                        <div style="float:left; width:71%; ">
                            <?php $savant = new Savant3(); $savant->rootDir = "../../../"; echo $savant->fetch("../../includes/colorPicker.tpl"); ?>
                        </div>
                    </div>
                </div>
                <div style="float:left; ">
                    <div style="margin-top:20px; ">This is a preview of how your movie will look with the changes you make above</div>
                    <div id="playerPreview" style="position:relative; width:<?=$plWidth?>px; height:<?=$plHeight?>px; background-color:#<?=$backgroundColor?>; overflow:hidden; ">
                        <img id="previewImg" style="display:none; position:relative; left:0; top:0; width=<?=$vidWidth?>; height=<?=$vidHeight?>; border:none; " />
                    </div>
                </div>
                <div style="width:100%; clear:both; "></div>
            </div>
            <div style="margin-top:25px; display:none; ">Show Advanced Options <input type="checkbox" name="advancedOptions" onclick="showHideAdvances(this.checked);" /></div>
            <input id="bgColorInput" type="hidden" name="bgColor" value="<?=$backgroundColor?>" />
            <input id="previewFrame" type="hidden" name="previewFrame" />
            <input type="hidden" name="vidID" value="<?=$id?>" />
            <input type="hidden" name="vidFile" value="<?=$vidFile?>" />
            <input type="hidden" name="vidFrameCount" value="<?=$movie->getFrameCount()?>" />
            <input type="hidden" name="vidFPS" value="<?=$fps?>" />
            <input type="button" value="Cancel" onclick="document.location.href='<?=$_SESSION['returnPage']?>'" /> <input type="submit" value="Save" />
        </form>
    </body>
</html>