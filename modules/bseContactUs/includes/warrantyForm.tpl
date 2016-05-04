                        <div style="width:100%; ">
<?php

    if ($rstat == "")
    {
        if (trim($whichcomm) !== "") { $legendtag = "<div class=\"contactCommName\">{$whichcomm}</div>"; }
?>
                            <div class="contactFormDiv" style="width:76%; float:left; ">
                                <?= $legendtag ?>

                                <form action="<?=$this->contactPage->getFormSubmitHref()?>" method="post" onsubmit="return checkForm(this);">
                                    <input type="hidden" name="comid" value="$comid" />
                                    <input type="hidden" name="mailed" value="1" />
                                    <input type="hidden" name="type" value="warranty" />
                                    <div style="width:53%; float:left; ">
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel" style="width:115px; text-align:right; padding-right:10px; ">Name:</div>
                                            <div class="norm contactFormInput"><input class="input2" type="text" name="contactName" maxlength="30" value="<?=$_SESSION['name']?>" /></div>
                                        </div>
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel" style="width:115px; text-align:right; padding-right:10px; ">Email:</div>
                                            <div class="norm contactFormInput"><input class="input2" type="text" name="contactEmail" maxlength="30" value="<?=$_SESSION['email']?>" /></div>
                                        </div>
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel" style="width:115px; text-align:right; padding-right:10px; ">Day Phone:</div>
                                            <div class="norm contactFormInput"><input class="input2" type="text" name="contactDayPhone" maxlength="30" value="<?=$_SESSION['dayPhone']?>" /></div>
                                        </div>
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel" style="width:115px; text-align:right; padding-right:10px; ">Eve. Phone:</div>
                                            <div class="norm contactFormInput"><input class="input2" type="text" name="contactEvePhone" maxlength="30" value="<?=$_SESSION['evePhone']?>" /></div>
                                        </div>
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel" style="width:115px; text-align:right; padding-right:10px; ">Cell Phone:</div>
                                            <div class="norm contactFormInput"><input class="input2" type="text" name="contactCellPhone" maxlength="30" value="<?=$_SESSION['cellPhone']?>" /></div>
                                        </div>
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel" style="width:115px; text-align:right; padding-right:10px; ">Community:</div>
                                            <div class="norm contactFormInput"><input class="input2" type="text" name="contactCommunity" maxlength="30" value="<?=$_SESSION['community']?>" /></div>
                                        </div>
                                    </div>
                                    <div style="width:45%; float:left; padding-left:10px; ">
                                        <div class="norm contactFormLabel" style="float:none; ">Your Address:</div>
                                        <div class="norm contactFormInput" style="float:none; "><input class="input2" style="width:250px;" type="text" name="contactAddress1" maxlength="35" value="<?= $_SESSION['adrs1'] ?>" /></div>
                                        <div class="norm contactFormInput" style="float:none; "><input class="input2" style="width:250px;" type="text" name="contactAddress2" maxlength="35" value="<?= $_SESSION['adrs2'] ?>" /></div>
                                        <div class="norm contactFormInput" style="float:none; "><input class="input2" style="width:250px;" type="text" name="contactAddress3" maxlength="35" value="<?= $_SESSION['adrs3'] ?>" /></div>
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel"  style="width:85px; text-align:right; padding-right:10px; ">Floor Plan:</div>
                                            <div class="norm contactFormInput"><input class="input2" style="width:154px; " type="text" name="contactFloorPlan" maxlength="30" value="<?=$_SESSION['floorPlan']?>" /></div>
                                        </div>
                                        <div style="clear:both; ">
                                            <div class="norm contactFormLabel"  style="width:85px; text-align:right; padding-right:10px; ">Closing:</div>
                                            <div class="norm contactFormInput"><input class="input2" style="width:154px; " type="text" name="contactClosing" maxlength="30" value="<?=$_SESSION['closing']?>" /></div>
                                        </div>
                                    </div>
                                    <div style="width:400px; margin-right:auto; margin-left:auto; padding-top:8px; clear:both; ">
                                        <div class="norm contactFormLabel" style="float:none; width:300px; ">Comments / Questions:</div>
                                        <textarea name="contactMessage" style="width:99%; height:100px; "><?= $_SESSION['message'] ?></textarea>
                                        <?= $this->display($this->contactPage->getCaptchaTemplateHref()) ?>

                                        <div style="width:100%; height:8px; clear:both; "></div>
                                        <div class="norm contactFormLabel"><input type="reset" name="reset" value=" Reset / Clear " /></div>
                                        <div class="norm contactFormLabel" style="float:right; "><input type="submit" name="submit" value=" Send Message" /></div>
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
