<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;
    $conPage =& $bse->getModule("bseContactPage");


    $captcha_pass = false;
    if( isset($_SESSION['mathCaptcha_field']) && isset($_SESSION['mathCaptcha_answer']) )
        if( isset($_POST[$_SESSION['mathCaptcha_field']]) )
            if( $_POST[$_SESSION['mathCaptcha_field']] == $_SESSION['mathCaptcha_answer'] )
                $captcha_pass = true;

    if( !$captcha_pass )
    {
        $_SESSION['contactForm'] = $_POST;

        $page = $bse->removeArgFromURL("sent");
        $separator = "?";
        if( strpos($page, "?") !== false )
            $separator = "&";

        header("Location: {$rootPath}$page{$separator}err=captcha");
        exit();
    }
    

// Common variables / Contact Form Variables
    $name     = htmlentities($_POST['contactName']);
    $address1 = htmlentities($_POST['contactAddress1']);
    $address2 = htmlentities($_POST['contactAddress2']);
    $address3 = htmlentities($_POST['contactAddress3']);
    $email    = htmlentities($_POST['contactEmail']);
    $dayphone = htmlentities($_POST['contactDayPhone']);
    $evephone = htmlentities($_POST['contactEvePhone']);
    $message = preg_replace("/\r/", "", $_POST['contactMessage']);
    $message = preg_replace("/\n/", " ", $message);
    $today = date("l, M d, Y");
    $time = date(" g:i A");


    $myaddr    = $address1;
    if (trim($address2) !== "") { $myaddr .= "\r\n" . $address2; }
    if (trim($address3) !== "") { $myaddr .= "\r\n" . $address3; }

    $headers ="";

    $subject = "Contact Us";

    $mymessage  = "Message Sent on $today at $time\n\n";
    $mymessage .= "Name:\n";
    $mymessage .= "$name\n\n";
    $mymessage .= "Address:\n";
    $mymessage .= "$myaddr\n\n";
    $mymessage .= "E-Mail:\n";
    $mymessage .= "$email\n\n";
    $mymessage .= "Day Phone:\n";
    $mymessage .= "$dayphone\n\n";
    $mymessage .= "Evening Phone:\n";
    $mymessage .= "$evephone\n\n";

    if( isset($_POST['type']) && $_POST['type']=="warranty" )     // Process Warranty Request
    {
        $cellphone = htmlentities($_POST['contactCellPhone']);
        $floorplan = htmlentities($_POST['contactFloorPlan']);
        $closing   = htmlentities($_POST['contactClosing']);
        $community = htmlentities($_POST['contactCommunity']);
        $subject = "Warranty Form";

        $mymessage .= "Cell Phone:\n";
        $mymessage .= "$cellphone\n\n";
        $mymessage .= "-------------------------------------------------------------\n";
        $mymessage .= "Community:\n";
        $mymessage .= "$community\n\n";
        $mymessage .= "Plan:\n";
        $mymessage .= "$floorplan\n\n";
        $mymessage .= "Closing:\n";
        $mymessage .= "$closing\n\n";
    }


// ok - now send it

    $MailSubject = $conPage->company . " Website Feedback:  $subject";
    $MailToAddress = $conPage->email;
    //$MailToAddress = "john@lightningsoftwaresolutions.com";    // For Testing Purposes only

    $mymessage .= "-------------------------------------------------------------\n";
    $mymessage .= "Message:\n";
    $mymessage .= "$message\n\n";
    $headers = "From: $name<$email>\n";
    mail( "$MailToAddress", "$MailSubject", "$mymessage", "$headers" );

    $separator = "?";

    if( strpos($page, "?") !== false )
        $separator = "&";

    while( strpos($page, "err=captcha") !== false )
        $page = removeArgument($page, "err=captcha", $separator);

    while( strpos($page, "sent=true") !== false )
        $page = removeArgument($page, "sent=true", $separator);

    if( strpos($page, "?" ) !== false )
    {
        if( strpos($page, "&") !== false )
        {
            $start = strpos($page, "&");
            $page = substr_replace($page, "?", $start, 1);
        }
    }
    
    header("Location: {$rootPath}$page{$separator}sent=true");



function removeArgument($strHaystack, $strToRemove, &$separator)
{
    $ret = $strHaystack;
    $start = strpos($ret, $strToRemove)-1;
    $len = strlen($strToRemove)+1;
    if( $start !== false )
    {
        if( substr($ret, $start, -1) == "?" )
            $separator = "?";
        else
            $separator = "&";

        $ret = str_replace( substr($ret, $start, $len), "", $ret);
    }

    if( strpos($ret, "?") === false )
        $separator = "?";

    return $ret;
}

?>