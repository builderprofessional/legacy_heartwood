<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<?php
    session_start();
    $vidID = $_GET['vid'];
    $frames = $_GET['frames'];
    $page = $_SESSION['returnPage'];
    if( substr($page, 0, 3) != "../" && substr($page, 0, 1) != "/" )   // if there is no path info in the page
    {
        $page = "../../../$page";
    }
    unset($_SESSION['returnPage']);
?>
<head>
    <script type="text/javascript" src="vidEdit.js"></script>
</head>
<body <?php if( isset($_GET['vid']) && isset($_GET['frames']) ){ echo 'onload="startTracking(\'encProgress.php?vid='.$vidID.'&frames='.$frames.'\', \'Converted\');"';}?>>
    <div id="progress" style="width:350px; margin-left:auto; margin-right:auto; ">
        <div style="width:350px; text-align:center; "><?php if( isset($_GET['vid']) && isset($_GET['frames']) ) { echo 'Converting Video<br />Feel free to navigate away from this page at any time.'; } else{ echo 'There seems to be a problem tracking thr progress of the video conversion.<br />The video is being converted, however, and will finish in a few minutes.';}?></div>
        <div id="complete" style="margin-top:25px; width:150px; margin-left:auto; margin-right:auto; font-weight:900; font-family:Arial; font-size:12px; text-align:center; ">0% Converted</div>
        <div style="width:350px; ">
            <div style="border-style:inset; border-width:4px; border-color:#BABABA; height:20px; width:100%; text-align:left; ">
                <div id="bar" style="background-color:#5533DD; height:100%; width:0%; "></div>
            </div>
            <div style="width:100%; text-align:center; margin-top:10px;"><a href="<?=$page?>">Click Here to Finish the Upload Process.</a></div>
        </div>
    </div>
</body>
</html>