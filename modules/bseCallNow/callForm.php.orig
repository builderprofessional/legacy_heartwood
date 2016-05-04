<?php

    if( isset($_POST['mailIt']) )
    {
        $rootPath = "../../";
    
        require("{$rootPath}modules/includes/main/bseMain.php");
        $bse = new bse($rootPath);
        $page = $bse->curPage;
        
    
        $name = $_POST['name'];
        $acode = $_POST['aCode'];
        $phone = $_POST['phNumber'];
        $ext = $_POST['phExtension'];
        $message = "";
        $builderid = $bse->db->getEscapedString($_REQUEST['builderid']);



        // Get the addresses to send this to.
        // $to is a list of email addresses separated by commas.
        $to = "";
        $sql = "SELECT * FROM `bseCallNow` WHERE `builderid` = '$builderid'";
        $result = $bse->db->getQueryResult($sql);
        
        if( mysql_num_rows($result) > 0 )
        {
            while( $data = mysql_fetch_array($result) )
                $to .= $data['address'].",";
            
            $to = substr($to, 0, strlen($to) - 1);
        }
        
        else     // This user has not set anyone to receive call now message, use their default email
        {
            $builder = new bseUser($bse->rootDir);
            $builder->setUserId($_REQUEST['builderid']);
            if( @trim($builder->userData->email) != "" )
            {
                $to = $builder->userData->email;
            }
            else
            {
                $to = "rick@bsecompanies.com";  // if still no data, send the message to Rick and inform him there needs to be an address added
                $message = "\n\nAdmin Message: Please forward this message to builder " . $builder->getName() . " and ask them to set up an email address for the call-now module and/or account data for the website {$_SERVER['SERVER_NAME']}.\nSincerely,\nWebsite Artificial Intelligence :)";
            }
        }

        //$to = "john@bsecompanies.com";      // For Testing
        $from = "From: Phone Call Server <admin@teambse.com>";
        
        mail($to, "Phone Call Request", "Name: $name\nNumber: $acode-$phone\next: $ext\n\nFrom: {$_SERVER['SERVER_NAME']}$message", $from);
        echo "<html><body style='overflow:hidden; text-align:center; padding:0; margin:0; '><div style='width:100%; height:100%; text-align:center; position:relative; '><img src='iface/panel.png' style='position:absolute; top:0; left:0; width:100%; height:100%; z-index:0;' />
        <div style='position:relative; z-index:1; font-family:Arial, Verdana; font-size:13px; padding-top:75px; '>
            <div style='width:100%; text-align:center; font-size:14px; font-weight:900; '>Your Request Has Been Sent<br />You Should Receive a Call Shortly.</div>
            <div style='width:100%; text-align:center; font-size:14px; font-weight:900; padding-top:45px; '>Thank you for your interest in our business!</div>
        </div>
        <script type='text/javascript' >setTimeout('parent.Shadowbox.close();', 4000);</script>
        </body></html>";
        exit();
    }
?>
<html>
<body style="overflow:hidden; text-align:center; font-family:Arial, Verdana; font-size:14px; ">
    <img src='iface/panel.png' style='position:absolute; top:0; left:0; width:100%; height:100%; z-index:0;' />
    <div style="width:95%; margin:auto; text-align:center; font-weight:700; margin-top:45px; position:relative; z-index:2;">To schedule a phone call, fill out the form below. A company employee will call you back in a few moments if they are available. If this request is after hours, or on a weekend, it may be the morning of the next working day that you will receive a call back. We look forward to talking to you soon.</div>
    <div style='width:95%; margin:auto; height:100%; text-align:center; position:relative; '>
        <div style="position:relative; z-index:1; margin-top:10px; margin-left:10px; ">
            <form method="post" style="position:relative; z-inedx:1; ">
                <input type="hidden" name="mailIt" value="yes" />
                <input type="hidden" name="builderid" value="<?= $_REQUEST['builderid'] ?>" />
                <div style="margin-bottom:10px; font-weight:700; margin-top:35px; ">Enter your name and phone number below:</div>
                <div style="width:305px; margin:auto; clear:both; text-align:center; font-family:Arial, Verdana; font-size:12px; position:relative; z-inedx:1; ">
                    <div style="float:left; width:70px; text-align:left; ">
                        Area Code:
                        <input type="text" style="width:99%; " name="aCode" />
                    </div>
                    <div style="float:left; width:150px; margin-left:5px; text-align:left; ">
                        Phone Number:
                        <input type="text" style="width:99%; " name="phNumber" />
                    </div>
                    <div style="float:left; width:70px; margin-left:5px;text-align:left; ">
                        Extension:
                        <input type="text" style="width:99%; " name="phExtension" />
                    </div>
                </div>
                <div style="width:85%; margin:auto; clear:both; ">
                    <div style="text-align:left; ">
                        Name:<br />
                        <input type="text" style="width:99%; " name="name" />
                    </div>
                </div>
                <div style="width:292px; text-align:right; clear:both; margin-top:10px; ">
                    <input type="button" value="Cancel" onmouseup="parent.Shadowbox.close();" /> <input type="submit" value="Request" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>