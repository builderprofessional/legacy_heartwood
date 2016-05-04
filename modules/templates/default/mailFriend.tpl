<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
        <title>Mail a Friend</title>
        <link rel="stylesheet" type="text/css" media="screen" href="<?= $this->rootDir ?>css/site_style.css.php" />
        <script language="JavaScript" type="text/javascript">
<!--
            function validateForm(theForm) 
            {
                var to      = theForm.to.value;
                var name    = theForm.name.value;
                var email   = theForm.email.value;
                var message   = theForm.message.value;

                if (to == "") 
                {
                    alert("Please fill in your friend's name and email address.");
                    theForm.to.focus();
                    return false;
                }
                if (name == "") 
                {
                    alert("Please fill in your name.");
                    theForm.name.focus();
                    return false;
                }
                if (email == "") 
                {
                    alert("Please fill in your email address.");
                    theForm.email.focus();
                    return false;
                }

                if (!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(theForm.email.value)) 
                {
                    alert("Your E-mail address appears invalid. Try Again.");
                    theForm.email.focus();
                    return false;
                }

                return true;
            }

//-->
        </script>
    </head>
    <body style="background:#FFF; ">
        <div style="width:100%; text-align:center; margin-top:20px; margin-bottom:12px; ">
            <img src='../iface/mailbnr2.png' border='0' width='230' height='72' alt='Mail a friend'>
        </div>

<?php

    if (isset($_REQUEST['errstr'])) 
    {
        $errstr = trim(urldecode($_REQUEST['errstr']));
        if ($errstr == "1")   {     ?>

        <div style="margin-top:2.1em; text-align:center; " class="norm">Your message was successfully sent.</div>

<?php   }
        else 
        {
            if ($errstr == "0") { $errstr = "Unknown"; }
?>
        <div style="margin-top:2.1em; text-align:center; " class="norm">Your message failed to be sent because of a server error.<br />(<?= $errstr ?>)</div>

<?php   }
    }
    else 
    {
// offer form
        $id = $_REQUEST['homeid'];
        $thelink = ( @!empty($_SERVER['HTTPS']) && @trim(strtolower($_SERVER['HTTPS'])) != "off" ? "https://" : "http://" ) . $_SERVER['SERVER_NAME'] . "/" . $_SESSION['mailpage'];

// form
?>
        <div id="sectionContent">
            <form METHOD=POST id="mailForm" action="<?= $this->rootDir ?>modules/bseAvailableHomes/send_mailfriend.php" onSubmit="return validateForm(this)">
                <input type="hidden" name="weblink" value="<?= $thelink ?>" />
                <input type="hidden" name="homeid" value="<?= $id ?>" />
                <div style="width:400px; margin:auto; border:solid thin #808080; padding:3px; background-color:#efefef;">
                    <div class='norm mailfriend_label'>
                            To: (Name and email)
                    </div>
                    <div class='norm mailfriend_input'>
                        <input class='norm mailfriend_input' type="text" name="<?= $this->tofield ?>" value="<?= $_SESSION['mailFriend'][$_SESSION['to_field']] ?>" />
                    </div>
                    <div class='norm mailfriend_label'>
                        Your Name:
                    </div>
                    <div class='norm mailfriend_input'>
                        <input class='norm mailfriend_input' type="text" name="name" value="<?= $_SESSION['mailFriend']['name'] ?>" />
                    </div>
                    <div class='norm mailfriend_label'>
                        Your Email Address:
                    </div>
                    <div class='norm mailfriend_input'>
                        <input class='norm mailfriend_input' type="text" name="email" value="<?= $_SESSION['mailFriend']['email'] ?>" />
                    </div>
                    <div class='norm mailfriend_label'>
                        Your Message:
                    </div>
                    <div class='norm mailfriend_input'>
                        <textarea class='norm' style="width:100%; height:80px; " name="message"><?= $_SESSION['mailFriend']['message'] ?></textarea>
                    </div>
                    <?php $this->display("captcha.tpl"); ?>
                    <div class='norm' style="width:70%; clear:both; margin:auto; ">
                        <input type="hidden" name="sendthis" value="true" />
                        <input type='submit' value="Submit" style="float:right; " />
                        <input type="reset" value="Reset Fields" />
                    </div>
                    <div style="width:100%; clear:both; "></div>
                </div>
            </form>
        </div>
<?php
    }
?>

        <table align='center' border='0' cellpadding='0' cellspacing='0'>
            <tr>
                <td align='left' valign='top' width='550' class='norm_sml' style="font-size:11px; font-weight:900; ">
                    <div style="margin-top:45px; ">
                        Please Note: Your message will include a direct link to the home you were viewing. Do not include html links or cc: Your message will be filtered for html links, Bcc: and Cc: tags to prevent spam. - Thanks!<br><br>
                    </div>
                </td>
            </tr>
        </table>
    </body>
<?php
    if( isset($_REQUEST['err']) && @$_REQUEST['err'] == "captcha" )
    {
        echo "
        <script type=\"text/javascript\"> <!-- 
            alert('The security answer you provided was incorrect!\\nPlease enter the correct security answer.');
            document.getElementById('captcha_code').focus();
        // -->
        </script>
";
    }
?>
</html>