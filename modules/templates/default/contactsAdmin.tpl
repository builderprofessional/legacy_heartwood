<?= $this->contactsInfo->getStyleLink() ?>
<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>

<div style="margin:15px auto 25px; clear:both; width:97%; ">

    <div style="border:solid 1px; margin-top:35px; ">
    <div style="clear:both; width:100%; text-align:center; margin-bottom:10px; font-size:16px; font-weight:900; ">Contact Page Options</div>
    <div style="width:80%; margin:auto; margin-bottom:25px; text-align:center; ">
        Use this form to set the information and options for the "Contact Us" page.
        The information in the fields below will show up on the left side of the "Contact Us" page.
        If you leave a field blank, the page will ignore that field.<br /><br />
        There are three option checkboxes below. To use a contact form, select the "Use Contact Form" checkbox.
        To use the warranty form, select the "Use Warranty Form" checkbox.
        To list your staff on a staff page, select the "Use Staff Page" checkbox.
        If all of the fields are unchecked, you will have a blank page with the content editor box available for you to customize your page however you want.
    </div>
    <form method="post" action="<?=$this->contactsInfo->getSaveFormSubmitHref()?>">
        <input type="hidden" name="pageId" value="<?=$this->contactsInfo->id?>" />
        <div class="norm" style="float:left; width:47%; ">
            <div class="inputWrapper">
                <div>Company: </div><input type="text" name="company" value="<?=$this->contactsInfo->company?>" />
            </div>
            <div class="inputWrapper">
                <div>Address 1: </div><input type="text" name="address1" value="<?=$this->contactsInfo->address1?>" />
            </div>
            <div class="inputWrapper">
                <div>Address 2: </div><input type="text" name="address2" value="<?=$this->contactsInfo->address2?>" />
            </div>
            <div class="inputWrapper">
                <div>City: </div><input type="text" name="city" value="<?=$this->contactsInfo->city?>" />
            </div>
            <div class="inputWrapper">
                <div>State: </div><input type="text" name="state" value="<?=$this->contactsInfo->state?>" />
            </div>
            <div class="inputWrapper">
                <div>Zip: </div><input type="text" name="zip" value="<?=$this->contactsInfo->zip?>" />
            </div>
        </div>
        <div class="norm" style="float:left; width:51%; ">
            <div class="inputWrapper">
                <div class="contactFormLabel">Phone: </div><input style="width:265px;" type="text" name="phone" value="<?=$this->contactsInfo->phone?>" />
            </div>
            <div class="inputWrapper">
                <div class="contactFormLabel">Fax: </div><input style="width:265px;" type="text" name="fax" value="<?=$this->contactsInfo->fax?>" />
            </div>
            <div class="inputWrapper">
                <div class="contactFormLabel">Email: </div><input style="width:265px;" type="text" name="email" value="<?=$this->contactsInfo->email?>" />
            </div>
            <div class="inputWrapper">
                <div style="width:35%; ">Use Contact Form: </div><input style="width:auto; float:left; " type="checkbox" name="useContactForm" value="1" <?=($this->contactsInfo->useContactForm?"checked=\"checked\"":"")?> />
            </div>
            <div class="inputWrapper">
                <div style="width:35%; ">Use Warranty Form: </div><input style="width:auto; float:left; " type="checkbox" name="useWarrantyForm" value="1" <?=($this->contactsInfo->useWarrantyForm?"checked=\"checked\"":"")?> />
            </div>
            <div class="inputWrapper">
                <div style="width:35%; ">Use Staff Page: </div><input style="width:auto; float:left; " type="checkbox" name="useContactsList" value="1" <?=($this->contactsInfo->useContactsList?"checked=\"checked\"":"")?> />
            </div>
            <div style="float:right; text-align:right; margin:10px 25px; clear:both; ">
                <input type="submit" name="contactOptsSubmit" value="Save" style="width:80px; " />
            </div>
        </div>
    </form>
    <div style="width:100%; clear:both; "></div>
    </div>


    <div style="border:solid 1px; margin-top:75px; ">
    <div class="norm" style="text-align:center; width:100%; font-size:17px; font-weight:900; ">Manage Contact Information</div>
    <div style="width:80%; margin:auto; margin-bottom:25px; text-align:center; ">
        If you checked the "Use Staff Page" above, you will need to add the staff you want listed here.
        To Edit an existing staff, click any of their information listed below.
        This will put their information in the fields below which you can edit and click "Save".
        To Add a new staff person, enter information into the fields below and click "Save".
    </div>
<?php
    foreach( $this->contactsInfo as $contact )
    { ?>
    <div style="border:solid 1px; ">
        <a style="text-decoration:underline; " href="<?= $this->curPage ?>?module=contacts&contactid=<?=$contact->id?>">
            <div class="norm" style="font-size:15px; font-weight:900; clear:both; text-decoration:underline; "><?=$contact->name?></div>
            <div class="norm" style="float:left; width:250px; text-decoration:underline; ">
                <div class="norm">Title: <?=$contact->title?></div>
                <div class="norm">Dept: <?=$contact->department?></div>
                <div class="norm">Desc: <?=$contact->description?></div>
            </div>
            <div class="norm" style="float:left; width:250px; margin-left:20px; text-decoration:underline; ">
                <div class="norm">Phone: <?=$contact->phone?></div>
                <div class="norm">Cell: <?=$contact->cell?></div>
                <div class="norm">Email: <?=$contact->email ?></div>
            </div>
            <div class="norm" style="float:right; width:150px; position:relative; top:-10px;">
                <?=$contact->getPictureCode(-1, 150)?>
            </div>
            <div style="width:100%; clear:both; "></div>
        </a>
    </div>
<?php
    }  // End foreach

    $contact = null;
    if( isset($_GET['contactid']) )
    {
        $contact =& $this->getModule("bseContact");
        $contact->setContactId( $_GET['contactid'] );
        echo "
<script type=\"text/javascript\">
    function setFocus()
    {
        document.getElementById('newNameBox').focus();
        window.scrollBy(0, document.height);
    }
    window.onload = setFocus;
</script>
";
    }
    else
    {
        $contact = new bseContact($this->rootDir);
        $contact->id = -1;
        $contact->name = "";
        $contact->title = "";
        $contact->department = "";
        $contact->description = "";
        $contact->phone = "";
        $contact->cell = "";
        $contact->email = "";
        $contact->image_file = "";
    }
?>
    <div class="norm" style="margin-bottom:10px; clear:both; width:100%; text-align:center; font-size:16px; font-weight:900; ">Add or Edit a Contact</div>
    <form method="post" action="<?=$this->contactsInfo->getSaveFormSubmitHref()?>" enctype="multipart/form-data">
        <input type="hidden" name="conId" value="<?=$contact->id?>" />
        <div class="norm" style="float:left; width:49%; ">
            <div class="inputWrapper">
                <div>Name: </div><input id="newNameBox" type="text" name="name" value="<?=$contact->name?>" />
            </div>
            <div class="inputWrapper">
                <div>Title: </div><input type="text" name="title" value="<?=$contact->title?>" />
            </div>
            <div class="inputWrapper">
                <div>Dept: </div><input type="text" name="department" value="<?=$contact->department?>" />
            </div>
            <div class="inputWrapper" style="height:auto; float:right; width:90%; ">
                <div style="text-align:left; ">Description:</div><textarea name="description" style="width:100%; "><?=$contact->description?></textarea>
            </div>
        </div>
        <div class="norm" style="float:left; width:49%; margin-left:10px; ">
            <div class="inputWrapper">
                <div>Phone: </div><input type="text" name="phone" value="<?=$contact->phone?>" />
            </div>
            <div class="inputWrapper">
                <div>Cell: </div><input type="text" name="cell" value="<?=$contact->cell?>" />
            </div>
            <div class="inputWrapper">
                <div>Email: </div><input type="text" name="email" value="<?=$contact->email?>" />
            </div>
            <div class="inputWrapper tb_input">
                <div>Photo: </div><input style="margin-left:15px; " id="contactPic" type="text" name="image" value="<?= $contact->image_file ?>" /><img src="<?= $this->rootDir ?>iface/browse_btn.png" alt="Browse for file" title="Browse for File" onmouseup="tinyBrowserPopUp('image','contactPic', '<?= urlencode($contact->getMediaDirHref(false)) ?>');" />
            </div>
            <div style="margin-top:4px; ">
                <div style="width:100%; float:right; margin-right:7px; text-align:right; "><input type="button" value="Cancel" onmouseup="document.location.href='<?= $this->curPage ?>?module=contacts';" style="width:80px; " /> <?= ( $contact->id == -1 ? "" : "<input style=\"width:80px; \" type=\"button\" value=\"Delete\" onmouseup=\"document.location.href='".$this->contactsInfo->getSaveFormSubmitHref()."?delid={$contact->id}';\" />") ?> <input type="submit" name="contactSubmit" value="Save" style="width:80px; " /></div>
            </div>
        </div>
    </form>
   <div style="width:100%; clear:both; "></div>
   </div>
</div>