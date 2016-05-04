                        <div style="width:100%; ">
<?php

    if( isset($_GET['commid']) )
    {
        $con = null;
        $com = $this->getModule("bseCommunity");
        if( @$com->id != $_GET['commid'] )
            $com->setCommunityId($_GET['commid']);



        if( @trim($_SESSION['contactForm']['contactMessage']) == "" )
            $_SESSION['contactForm']['contactMessage'] = "This request is for information regarding your community named '{$com->name}'.\n\n";

    }


    if ($rstat == "")
    {
        if (trim($whichcomm) !== "") { $legendtag = "<div class=\"contactCommName\">{$whichcomm}</div>"; }
?>

                            <div class="contactFormDiv" style="width:100%; float:left;">
                                <?= $legendtag ?>

                                <form action="<?=$this->contactPage->getFormSubmitHref()?>" method="post" onsubmit="return checkForm(this);">
                                    <input type="hidden" name="comid" value="<?= $_GET['commid'] ?>" />
                                    <input type="hidden" name="mailed" value="1" />
                                    <input type="hidden" name="type" value="contact" />
                                    <div style="width:53%; float:left; ">
                                        <div class="inputWrapper">
                                            <div>Name:</div>
                                            <input type="text" name="contactName" maxlength="30" value="<?=@$_SESSION['contactForm']['contactName']?>" />
                                        </div>
                                        <div class="inputWrapper">
                                            <div>Email:</div>
                                            <input type="text" name="contactEmail" maxlength="30" value="<?=@$_SESSION['contactForm']['contactEmail']?>" />
                                        </div>
                                        <div class="inputWrapper">
                                            <div>Day Phone:</div>
                                            <input type="text" name="contactDayPhone" maxlength="30" value="<?=$_SESSION['contactForm']['contactDayPhone']?>" />
                                        </div>
                                        <div class="inputWrapper">
                                            <div>Eve. Phone:</div>
                                            <input type="text" name="contactEvePhone" maxlength="30" value="<?=$_SESSION['contactForm']['contactEvePhone']?>" />
                                        </div>
                                    </div>
                                    <div style="width:45%; float:left; padding-left:10px; ">
                                        <div class="inputWrapper">
                                            <div style="float:none; width:100%; text-align:left; ">Your Address:</div>
                                        </div>
                                        <div class="norm contactFormInput" style="float:none; "><input style="width:250px;" type="text" name="contactAddress1" maxlength="35" value="<?= $_SESSION['contactForm']['contactAddress1'] ?>" /></div>
                                        <div class="norm contactFormInput" style="float:none; "><input style="width:250px;" type="text" name="contactAddress2" maxlength="35" value="<?= $_SESSION['contactForm']['contactAddress2'] ?>" /></div>
                                        <div class="norm contactFormInput" style="float:none; "><input style="width:250px;" type="text" name="contactAddress3" maxlength="35" value="<?= $_SESSION['contactForm']['contactAddress3'] ?>" /></div>
                                    </div>
                                    <div style="width:440px; margin-right:auto; margin-left:auto; padding-top:8px; clear:both; ">
                                        <div class="norm contactFormLabel" style="float:none; width:300px; ">Comments / Questions:</div>
                                        <textarea name="contactMessage" style="width:100%; height:160px; "><?= $_SESSION['contactForm']['contactMessage'] ?></textarea>
                                        <div style="margin:20px auto 12px; width:70%; font-size:13px; font-weight:900; text-align:center; ">For security purposes, please answer the simple math question below:</div>
                                        <?= $this->display($this->contactPage->getCaptchaTemplateHref()) ?>

                                        <div style="width:100%; height:15px; clear:both; "></div>
                                        <div class="norm contactFormLabel"><input type="reset" name="reset" value="Reset / Clear" /></div>
                                        <div class="norm contactFormLabel" style="float:right; "><input type="submit" name="submit" value="Send Message" style="padding-top:1px; " /></div>
                                    </div>
                                </form>
                            </div>
<?php
    }
    else
    {
        echo $rstat;
    }
?>
                        </div>
