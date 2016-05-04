<?

$baseDir = "http://";
if( isset($_SERVER['HTTPS']) )
    if( $_SERVER['HTTPS'] != "off" )
        $baseDir = "https://";
        
$baseDir .= $_SERVER['SERVER_NAME'].dirname($_SERVER['SCRIPT_NAME'])."/";

    $rootPath = "../../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    if( !$bse->user->inBackDoor() )
    {
        header("Location: $rootPath");
        exit();
    }

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <script language="javascript" type="text/javascript" src="vidEdit.js"></script>
    <script language="javascript" type="text/javascript" src="<?= $bse->getFileHref("tb_standalone.js.php") ?>"></script>

    <link rel="stylesheet" type="text/css" media="screen" href="<?= $bse->getFileHref("shadowbox.css") ?>" />
    <script language="javascript" type="text/javascript" src="<?= $bse->getFileHref("shadowbox.js") ?>"></script>
</head>
<body style="background-color:#FFF; ">
    <div style="width:400px; margin:auto;">
        <h2 style="font-family:Arial, Verdana, Sans, Times; font-weight:900; font-size:16px;">Use This Form to Upload Your Video</h2>
        <form method="post" action="saveInfo.php">
            <div class="inputWrapper"><div>Video Title</div><input type="text" name="title" /></div>
            <div class="inputWrapper tb_input"><div>Video File: </div><input  id="videoFile" type="text" name="file" /><img style="margin-left:2px; cursor:pointer; " alt="Browse for file" title="Browse for File" src="<?= $bse->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('video','videoFile', '<?= urlencode("modules/bseVideo/videos") ?>');" /></div>
            <input type="submit" value="Save" />
        </form>

    </div>
</body>
<script type="text/javascript">
    Shadowbox.init();
</script>
</html>