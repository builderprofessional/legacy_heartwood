<?php
    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $_SESSION['mailLink'];
    unset($_SESSION['mailLink']);




// Remove old data from the database

    $bse->db->getQueryResult("DELETE FROM `sent_mails` WHERE `time_sent` <= " . ( (int)time() - 180) );




// test for newlines in posted fields
    if ( ereg("[\n\r]", $_POST[$_SESSION['mailFriend']['tofield']] . $_POST['from'] . $_POST['subject']) ) 
    {
        sleep(rand(2, 5)); // delay spammers a bit then return 'server error'
        header("Location:{$rootPath}$page&errstr=9");
        exit;
    }
    



// Check for the captcha
    $captcha_pass = false;
    if( isset($_SESSION['mathCaptcha_field']) && isset($_SESSION['mathCaptcha_answer']) )
        if( isset($_POST[$_SESSION['mathCaptcha_field']]) )
            if( $_POST[$_SESSION['mathCaptcha_field']] == $_SESSION['mathCaptcha_answer'] )
                $captcha_pass = true;

    if( !$captcha_pass )
    {
        $field = $_SESSION['tofield'];
        $_SESSION['mailFriend'] = $_POST;
        $_SESSION['to_field'] = $field;
/*
echo "<pre>";
var_dump($_SESSION);
echo "</pre>";
exit();
*/
        header("Location: {$rootPath}$page&err=captcha");
        exit();
    }
    


if (isset($_POST["sendthis"]))
{
    $to = mysql_real_escape_string($_POST[$_SESSION['tofield']]);
    $name = mysql_real_escape_string($_POST["name"]);
    $email = mysql_real_escape_string($_POST["email"]);
    $message = mysql_real_escape_string($_POST["message"]);
// establish page link
    $pglink = mysql_real_escape_string($_POST['weblink']);
// validate message string

// clean it
    $message = stripslashes($message);
//Your website name goes here:
    $site_name = $_SERVER['SERVER_NAME'];
//The subject of the mail
    $the_subject = "$name wants to show you a home on $site_name";
//Edit the body of the message to be sent here
    $body = "Hello,\r\n\r\nYour friend " . $name . " <" . $email . "> wants you to see our website at http://{$_SERVER['SERVER_NAME']} and has sent this message along with a link to the website:\r\n\r\n" . $name . " said: " . $message . "\r\n\r\nVisit: " . $pglink . "\r\n\r\nThank you!";

// Ensure that the email only goes to one person

    if( strpos($to, ",") !== false )
    {
        $addresses = explode(",", $to);
        $to = $addresses[0];
    }
    $recipient = $to;
    $subject = $the_subject;
    $additional_headers = ("From: $name <$email>\n");
    $query = $bse->db->getQueryResult("SELECT * FROM `sent_mails` WHERE `ip_address` = '{$_SERVER['REMOTE_ADDR']}' OR `from_email`='$email'");
    $curTime = time();
    $allowSend = true;
    while( $data = mysql_fetch_assoc($query) )
    {
        if( $curTime - $data['time_sent'] < 180 )      // if it has been 3 minutes since last sent email, allow sending
        {
            $errstr = urlencode("You must wait at least 3 minutes after sending an email to send another one.");
            $allowSend = false;
            break;
        }
    }
    if( $allowSend ) if (mail($recipient, $subject, $body, $additional_headers)) 
    {
        $errstr = "1";
        $bse->db->getQueryResult( "INSERT INTO `sent_mails` SET `ip_address`='{$_SERVER['REMOTE_ADDR']}',`from_email`='$email',`time_sent`='" . time() . "'" );
    } 
    else 
    {
        $errstr = "0";
    }
//die("recipient = '$recipient'<br />Subject = '$subject'<br />Message = '$body'<br />Headers = '$additional_headers'<br />");
// return with err string
    header("Location:{$rootPath}$page&errstr={$errstr}");
    exit;

}

?>
