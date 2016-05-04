<?

# PHP File Uploader with progress bar Version 1.12
# Copyright (C) Raditha Dissanyake 2003
# http://www.raditha.com

# Licence:
# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
# 
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
# 
# The Initial Developer of the Original Code is Raditha Dissanayake.
# Portions created by Raditha are Copyright (C) 2003
# Raditha Dissanayake. All Rights Reserved.
# 

# CHANGES:
# 1.00 cookies were abolished!
# 1.20 changed the form submit mechanism to filter for certain types
#      of files



	$sid = md5(uniqid(rand()));
	/*
	 * if your php installation cannot produce md5 hashes delete the above line and
	 * uncomment the line below.
	 *
	 * $sid = urlencode(uniqid(rand()));
	 */
	 
$baseDir = "http://";
if( isset($_SERVER['HTTPS']) )
    if( $_SERVER['HTTPS'] != "off" )
        $baseDir = "https://";
        
$baseDir .= $_SERVER['SERVER_NAME'].dirname($_SERVER['SCRIPT_NAME'])."/";
$root = dirname($_SERVER['SCRIPT_FILENAME']);

session_start();
$_SESSION['sid'] = $sid;
$_SESSION['baseDir'] = $baseDir;
$_SESSION['returnPage'] = $_GET['page'];
$_SESSION['root'] = $root;
unset($_SESSION['pcnt'], $_SESSION['encPcnt']);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <script language="javascript" type="text/javascript" src="vidEdit.js"></script>
</head>
<body>
    <div style="width:400px; margin:auto;">
        <h2 style="font-family:Arial, Verdana, Sans, Times; font-weight:900; font-size:16px;">Use This Form to Upload Your Video</h2>
        <iframe frameborder="0" width="100%" height="200px" name="upForm" src="form.php"></iframe>
        <form id="vidSaveFrm" method="post" action="saveInfo.php" onsubmit="setValues(100);">
            <input id="upFile" type="hidden" name="file" />
            <input type="hidden" name="sid" value="<?=$sid?>" />
        </form>
        
        <div id="progress" style="width:350px; display:none; ">
            <div style="width:100%; text-align:center; ">Uploading Video<br />Please wait for the file to finish uploading.</div>
            <div id="complete" style="margin-top:25px; width:100%; margin-left:auto; margin-right:auto; font-weight:900; font-family:Arial; font-size:12px; text-align:center; ">0.00% Uploaded</div>
            <div style="width:100%; ">
                <div style="border-style:inset; border-width:4px; border-color:#BABABA; height:20px; width:100%; text-align:left; ">
                    <div id="bar" style="background-color:#5533DD; height:100%; width:0%; "></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>