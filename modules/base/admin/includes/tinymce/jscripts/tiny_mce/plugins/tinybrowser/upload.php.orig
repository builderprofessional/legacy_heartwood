<?php
require_once('config_tinybrowser.php');
// Set language
if(isset($tinybrowser['language']) && file_exists('langs/'.$tinybrowser['language'].'.php'))
{
	require_once('langs/'.$tinybrowser['language'].'.php'); 
}
else
{
	require_once('langs/en.php'); // Falls back to English
}

require_once('fns_tinybrowser.php');

// Check user status
if( !isset($bse) )
{
    echo TB_DENIED;
    exit;
}
else if( !$bse->user->inBackDoor() )
{
    echo TB_DENIED;
    exit;
}

if(!$tinybrowser['allowupload'])
{
	echo TB_UPDENIED;
	exit;
}

$validtypes = array('image','media','file');
$typenow = ((isset($_GET['type']) && in_array($_GET['type'],$validtypes)) ? $_GET['type'] : 'image');
$foldernow = ( isset($_REQUEST['folder']) ? urldecode($_REQUEST['folder']) : '' );
$passfolder = '&folder='.urlencode($foldernow);
if( isset($_REQUEST['folder']) )
    $passfolder .= "&customdir=yes";

$passfeid = (isset($_GET['feid']) && $_GET['feid']!='' ? '&feid='.$_GET['feid'] : '');
$passupfeid = (isset($_GET['feid']) && $_GET['feid']!='' ? $_GET['feid'] : '');
$pageRoot = $tinybrowser['pageRoot'] . ( substr($tinybrowser['pageRoot'], -1) == "/" ? "" : "/" );
$gallerystyle = ( isset($_GET['gallerystyle']) ? ( $_GET['gallerystyle'] == "true" ? true : false ) : false );
$passgalstyle = ( $gallerystyle ? "&gallerystyle=true" : "" );


// Remove value for tb_folder so subsequent calls to tinybrowser will not receive this value
unset($_SESSION['tb_folder']);

$_SESSION['tb_folder'] = $foldernow;
$_SESSION['gallerystyle'] = $_GET['gallerystyle'];

// Assign upload path
if( @$_REQUEST['customdir'] == "yes" )
{
    $uploadpath = $foldernow;
    $_SESSION['tb_customDir'] = "yes";
}
else
{
    $uploadpath = $tinybrowser['path'][$typenow].$foldernow;
    $_SESSION['tb_folder'] = $uploadpath;
    $_SESSION['tb_customDir'] = "no";
}

/*
$uploaddirs=array();
dirtree($uploaddirs,$tinybrowser['filetype'][$typenow],$tinybrowser['docroot'],$tinybrowser['path'][$typenow]);
*/

// determine file dialog file types
switch ($_GET['type'])
{
	case 'image':
		$filestr = TB_TYPEIMG;
		break;
	case 'media':
		$filestr = TB_TYPEMEDIA;
		break;
	case 'file':
		$filestr = TB_TYPEFILE;
		break;
}
$fileexts = str_replace(",",";",$tinybrowser['filetype'][$_GET['type']]);
$filelist = $filestr.' ('.$tinybrowser['filetype'][$_GET['type']].')';

// Initalise alert array
$notify = array(
	'type' => array(),
	'message' => array()
);
$goodqty = (isset($_GET['goodfiles']) ? $_GET['goodfiles'] : 0);
$badqty = (isset($_GET['badfiles']) ? $_GET['badfiles'] : 0);
$dupqty = (isset($_GET['dupfiles']) ? $_GET['dupfiles'] : 0);

if($goodqty>0)
{
	$notify['type'][]='success';
	$notify['message'][]=sprintf(TB_MSGUPGOOD, $goodqty);
}
if($badqty>0)
{
	$notify['type'][]='failure';
	$notify['message'][]=sprintf(TB_MSGUPBAD, $badqty);
}
if($dupqty>0)
{
	$notify['type'][]='failure';
	$notify['message'][]=sprintf(TB_MSGUPDUP, $dupqty);
}
if(isset($_GET['permerror']))
{
	$notify['type'][]='failure';
	$notify['message'][]=sprintf(TB_MSGUPFAIL, $tinybrowser['docroot'].$foldernow);
}

/*

// Assign get variables


// Switch to upload session
$sessid = session_id();
$sessname = session_name();
session_write_close();

session_id("tb-upload-session");
session_name("tb-upload-session");
ini_set("session.save_path", "{$tinybrowser['docroot']}/../tmp");
session_start();

$_SESSION['main_sessid'] = $sessid;
$_SESSION['main_sessname'] = $sessname;
// Assign directory structure to array
*/
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>TinyBrowser :: <?php echo TB_UPLOAD; ?></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Pragma" content="no-cache" />
<?php
if($passfeid == '' && $tinybrowser['integration']=='tinymce')
{
	?><link rel="stylesheet" type="text/css" media="all" href="<?php echo $tinybrowser['tinymcecss']; ?>" /><?php 
}
else
{
	?><link rel="stylesheet" type="text/css" media="all" href="css/stylefull_tinybrowser.css" /><?php 
}
?>
<link rel="stylesheet" type="text/css" media="all" href="css/style.css" />
</head>
<body>

<div class="tabs">
<ul>
<li id="browse_tab"><span><a href="tinybrowser.php?type=<?php echo $typenow.$passfolder.$passfeid.$passgalstyle ; ?>"><?php echo TB_BROWSE; ?></a></span></li>
<li id="upload_tab" class="current"><span><a href="upload.php?type=<?php echo $typenow.$passfolder.$passfeid.$passgalstyle ; ?>"><?php echo TB_UPLOAD; ?></a></span></li>
<?php
if($tinybrowser['allowedit'] || $tinybrowser['allowdelete'])
{
	?><li id="edit_tab"><span><a href="edit.php?type=<?php echo $typenow.$passfolder.$passfeid.$passgalstyle ; ?>"><?php echo TB_EDIT; ?></a></span></li>
	<?php 
}
if($tinybrowser['allowfolders'])
{
	?><li id="folders_tab"><span><a href="folders.php?type=<?php echo $typenow.$passfolder.$passfeid.$passgalstyle; ?>"><?php echo TB_FOLDERS; ?></a></span></li><?php
}
// Display folder select, if multiple exist
$_SESSION['obfuscate'] = $obf = md5($_SERVER['DOCUMENT_ROOT'].$tinybrowser['obfuscate']);
?>
</ul>
</div>

<div class="panel_wrapper">
<div id="general_panel" class="currentmod">
<fieldset>
<legend><?php echo TB_UPLOADFILES; ?></legend>
    <div id="flashcontent">
		<form id="upload" method="post" action="upload_file.php" enctype="multipart/form-data">
			<div id="drop">
				Drop Files Here <span style="text-transform:none; ">or </span>

				<a>Browse</a>
				<input type="file" name="upl" multiple />
			</div>

			<ul>
				<!-- The file uploads will be shown here -->
			</ul>

		</form>
    </div>
</fieldset></div></div>

<!-- JavaScript Includes -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="js/jquery.knob.js"></script>

<!-- jQuery File Upload Dependencies -->
<script src="js/jquery.ui.widget.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="js/jquery.fileupload.js"></script>

<!-- Our main JS file -->
<script src="js/script.js"></script>

</body>
</html>