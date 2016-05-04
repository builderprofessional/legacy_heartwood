<?php
require_once("config_tinybrowser.php");

$tbpath = pathinfo($_SERVER['SCRIPT_NAME']);
$tbmain = $tbpath['dirname'].'/tinybrowser.php';
?>

function tinyBrowserPopUp(type,formelementid,folder,gallerystyle) {
    if( gallerystyle == undefined )
        gallerystyle = false;

    var galbool = "false";
    if( gallerystyle == true )
        galbool = "true";

    tburl = "<?php echo (@$_SERVER['HTTPS']!=""?"https://":"http://").$_SERVER['HTTP_HOST'].$tbmain; ?>" + "?type=" + type + "&feid=" + formelementid + "&gallerystyle=" + galbool;
    if (folder !== undefined) tburl += "&folder="+folder+"%2F";
    Shadowbox.open({
        content: tburl,
        player:  'iframe',
        title:   'BSE File Browser',
        height:  <?php echo $tinybrowser['window']['height']+15; ?>,
        width:   <?php echo $tinybrowser['window']['width']+15; ?>,
    });
    return false;
}
