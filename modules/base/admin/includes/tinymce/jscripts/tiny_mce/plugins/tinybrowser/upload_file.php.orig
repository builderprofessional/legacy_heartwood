<?php

// The following variable is used below when checking whether the user is logged in
$tmpErr = "";


// config_tinybrowser includes bsemain.php, which starts a session with the session name
require_once('config_tinybrowser.php');
require_once('fns_tinybrowser.php');


// Check session, if it exists
if(session_id() != '')
{
    if( !isset($bse) )
        $tmpErr = 'Error! bse object not set.';

    if( !$bse->user->inBackDoor() )
        $tmpErr .= "Error! bse user not in backdoor";
}

//$foldernow = $_SESSION['main_folder'];
//$_SESSION['tb_folder'] = $foldernow;
$foldernow = $_SESSION['tb_folder'];

// Keep a log/errors of the uplaod
$_SESSION['tb_upload_error'] = $tmpErr;
$_SESSION['tb_upload_log'] = "Checking for required variables<br />";

// Check hash is correct (workaround for Flash session bug, to stop external form posting)
if($_SESSION['obfuscate'] != md5($_SERVER['DOCUMENT_ROOT'].$tinybrowser['obfuscate'])) { $_SESSION['tb_upload_error'] .= 'Error! obfuscate not correct.<br />'; } 

// Check  and assign get variables
if(isset($_GET['type'])) { $typenow = $_GET['type']; } else { $_SESSION['tb_upload_error'] .= 'Error! type not set.<br />'; } 
if(isset($_SESSION['tb_folder'])) { $dest_folder = $_SESSION['tb_folder']; } else { $_SESSION['tb_upload_error'] .= 'Error! folder not set<br />'; } 

// Check file extension isn't prohibited
$nameparts = explode('.',$_FILES['upl']['name']);
$ext = end($nameparts);

if(!validateExtension($ext, $tinybrowser['prohibited'])) { $_SESSION['tb_upload_error'] .= 'Error! invalid extension.<br />'; } 

/*
if( trim($_SESSION['tb_upload_error']) != "" )
    die({"status":"error: {$_SESSION['tb_upload_error']}");
*/

// Check file data
$_SESSION['tb_upload_log'] .= "Checking for tmp_name & name<br />";
$success = false;
if ($_FILES['upl']['tmp_name'] && $_FILES['upl']['name'])
{	

/*
    $source_file = $_FILES['Filedata']['tmp_name'];
    $file_name = stripslashes($_FILES['Filedata']['name']);
    if($tinybrowser['cleanfilename']) $file_name = clean_filename($file_name);
    $_SESSION['tb_upload_log'] .= "Source = '$source_file'<br />Dest. Folder = '$dest_folder'<br />Filename = '$file_name'<br />";
    if(is_dir($tinybrowser['docroot'] . $dest_folder))
    {
        $_SESSION['tb_upload_log'] .= "Dest. Folder is good, attempting to copy file from '$source_file' to '".$tinybrowser['docroot'].$dest_folder.$file_name.'_'."'<br />";
		$success = copy($source_file,$tinybrowser['docroot'].$dest_folder.'/'.$file_name.'_');
    }
    else
    {
        $_SESSION['tb_upload_log'] .= "'{$tinybrowser['docroot']}$dest_folder' is not a directory, cannot proceed.<br />";
        session_write_close();
        header('HTTP/1.1 501 Upload Error:\nDestination ('.$tinybrowser['docroot'] . $dest_folder . ') not a directory.');
        ?><html><head><title>File Upload Success</title></head><body style="background-color:#FFF; ">File Upload Error!<br /><br />Log:<br /><?= $_SESSION['tb_upload_log'] ?></body></html><?php
    }
    if($success)
    {
        $_SESSION['tb_upload_error'] = "Success!";
        $_SESSION['tb_upload_log'] .= "Successful Upload.";
        session_write_close();
		header('HTTP/1.1 200 OK'); //  if this doesn't work for you, try header('HTTP/1.1 201 Created');
	?><html><head><title>File Upload Success</title></head><body>File Upload Success</body></html><?php
    }
    else
    {
        $_SESSION['tb_upload_log'] .= "Unknown Upload Error!";
        $_SESSION['tb_upload_error'] = "Error Writing to directory";
        session_write_close();
        header('HTTP/1.1 502 Upload Error:\nAn unknown error occurred during upload.\nIt is most likely a lack of permissions to write to the destination ('.$tinybrowser['docroot'] . $dest_folder . ').'); //  if this doesn't work for you, try header('HTTP/1.1 201 Created');
        ?><html><head><title>File Upload Success</title></head><body style="background-color:#FFF; ">File Upload Error!<br /><br />Log:<br /><?= $_SESSION['tb_upload_log'] ?></body></html><?php
    }
*/

// A list of permitted file extensions
//$allowed = array('png', 'jpg', 'gif','zip');

    if(isset($_FILES['upl']) && $_FILES['upl']['error'] == 0)
    {
        if(move_uploaded_file($_FILES['upl']['tmp_name'], $tinybrowser['docroot'].$foldernow.$_FILES['upl']['name']))
        {
            echo '{"status":"success"}';
            exit;
        }
    }

    echo '{"status":"error"}';
    exit();

}

?>