<?php
session_id("tb-upload-session");
require_once('config_tinybrowser.php');
require_once('fns_tinybrowser.php');

// delay script if set
if($tinybrowser['delayprocess']>0) sleep($tinybrowser['delayprocess']);

// Initialise files array and error vars
$files = array();
$good = 0;
$bad = 0;
$dup = 0;
$total = (isset($_GET['filetotal']) ? $_GET['filetotal'] : 0);

$_SESSION['tb_upload_log'] .=  "Changing directory to {$tinybrowser['docroot']}<br />";
$odir = getcwd();
chdir($tinybrowser['docroot']);
// Assign get variables
$folder = urldecode($_GET['folder']);
$folderpass = urldecode($_GET['folder']);
if( isset($_SESSION['tb_folder']) && @trim($_SESSION['tb_folder']) != "" )
{
    $folder = $folderpass = urldecode($_SESSION['tb_folder']);
}

$gallerystyle = ( isset($_SESSION['gallerystyle']) ? ( $_SESSION['gallerystyle'] == "true" ? true : false ) : false );
$passgalstyle = ( $gallerystyle ? "&gallerystyle=true" : "" );

$passfeid = (isset($_GET['feid']) ? '&feid='.$_GET['feid'] : '');
if ($handle = opendir($folder))
{
    $_SESSION['tb_upload_log'] .=  "Success! Checking all files for duplicates in '" . getcwd() . "/$folder'.<br />";
	while (false !== ($file = readdir($handle)))
	{
		if ($file != "." && $file != ".." && substr($file,-1)=='_')
		{
    $_SESSION['tb_upload_log'] .=  "File = '$file'<br />";
			//-- File Naming
			$tmp_filename = $folder.$file;
			$dest_filename	 = $folder.rtrim($file,'_');
        
			//-- Duplicate Files
			if(file_exists($dest_filename)) { unlink($tmp_filename); $dup++; continue; }

			//-- Bad extensions
			$nameparts = explode('.',$dest_filename);
			$ext = end($nameparts);
			
			if(!validateExtension($ext, $tinybrowser['prohibited'])) { unlink($tmp_filename); continue; }
        
			//-- Rename temp file to dest file
    $_SESSION['tb_upload_log'] .=  "Renaming file from '$tmp_filename' to '$dest_filename'<br />";
			rename($tmp_filename, $dest_filename);
			$good++;
			
			//-- if image, perform additional processing
			if($_GET['type']=='image')
			{
				//-- Good mime-types
				$imginfo = getimagesize($dest_filename);
    	   		if($imginfo === false) { unlink($dest_filename); continue; }
				$mime = $imginfo['mime'];

				// resize image to maximum height and width, if set
				if($tinybrowser['imageresize']['width'] > 0 || $tinybrowser['imageresize']['height'] > 0)
    			{
					// assign new width and height values, only if they are less than existing image size
					$widthnew  = ($tinybrowser['imageresize']['width'] > 0 && $tinybrowser['imageresize']['width'] < $imginfo[0] ? $tinybrowser['imageresize']['width'] : $imginfo[0]);
					$heightnew = ($tinybrowser['imageresize']['height'] > 0 && $tinybrowser['imageresize']['height'] < $imginfo[1] ? $tinybrowser['imageresize']['height'] :  $imginfo[1]);

					// only resize if width or height values are different
					if($widthnew != $imginfo[0] || $heightnew != $imginfo[1])
					{
						$im = convert_image($dest_filename,$mime);
						resizeimage($im,$widthnew,$heightnew,$dest_filename,$tinybrowser['imagequality'],$mime);
						imagedestroy($im);
					}
				}

				// generate thumbnail
                $_SESSION['tb_upload_log'] .=  "Generating Thumbnail<br />";
				$thumbimg = $folder.'_thumbs/_'.rtrim($file,'_');
				if (!file_exists($thumbimg))
				{
					$im = convert_image($dest_filename,$mime);
					resizeimage	($im,$tinybrowser['thumbsize'],$tinybrowser['thumbsize'],$thumbimg,$tinybrowser['thumbquality'],$mime);
					imagedestroy ($im);
				}
			}

      	}
	}
	closedir($handle);
}
$bad = $total-($good+$dup);
chdir($odir);

$uploadLog = $_SESSION['tb_upload_log'];
$uploadErr = $_SESSION['tb_upload_error'];
$custDir = $_SESSION['tb_customDir'];
$sessid = $_SESSION['sessid'];
session_unset();
session_write_close();

session_id($sessid);
session_start();
// Check for problem during upload, comment the next two lines to see debug information
if($total>0 && $bad==$total) Header('Location: ./upload.php?type='.$_GET['type']."&customdir={$custDir}&folder=$folderpass".$passfeid.$passgalstyle.'&permerror=1&total='.$total);
else Header('Location: ./upload.php?type='.$_GET['type'].$passfeid."&customdir={$custDir}&folder=".$folderpass.$passgalstyle.'&badfiles='.$bad.'&goodfiles='.$good.'&dupfiles='.$dup);
$error = "";
if( $total > 0 && $bad==$total )
    $error = "Permissions";
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Pragma" content="no-cache" />
		<title>TinyBrowser :: Process Upload</title>
	</head>
	<body style="background-color:#FFF; ">
		<p>Upload Result: <?= $uploadErr ?></p>
        <p>Upload Log:<br /><?= $uploadLog ?></p>
	</body>
</html>