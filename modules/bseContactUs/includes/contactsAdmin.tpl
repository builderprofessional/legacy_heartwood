<div style="margin-top:15px; clear:both; margin-bottom:25px; font-size:14px; ">

    <div style="clear:both; width:100%; text-align:center; margin-top:35px; margin-bottom:10px; font-size:16px; font-weight:900; ">Contact Page Options</div>
    <div style="width:90%; margin:auto; margin-bottom:25px; text-align:center; ">
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
        <div class="norm" style="float:left; width:350px; ">
            <div class="norm" style="float:left; width:75px; ">Company: </div><input style="width:265px;" type="text" name="company" value="<?=$this->contactsInfo->company?>" />
            <div class="norm" style="float:left; width:75px; ">Address 1: </div><input style="width:265px;" type="text" name="address1" value="<?=$this->contactsInfo->address1?>" />
            <div class="norm" style="float:left; width:75px; ">Address 2: </div><input style="width:265px;" type="text" name="address2" value="<?=$this->contactsInfo->address2?>" />
            <div class="norm" style="float:left; width:75px; ">City: </div><input style="width:265px;" type="text" name="city" value="<?=$this->contactsInfo->city?>" />
            <div class="norm" style="float:left; width:75px; ">State: </div><input style="width:265px;" type="text" name="state" value="<?=$this->contactsInfo->state?>" />
            <div class="norm" style="float:left; width:75px; ">Zip: </div><input style="width:265px;" type="text" name="zip" value="<?=$this->contactsInfo->zip?>" />
        </div>
        <div class="norm" style="float:left; width:320px; ">
            <div class="norm" style="float:left; width:45px; ">Phone: </div><input style="width:265px;" type="text" name="phone" value="<?=$this->contactsInfo->phone?>" />
            <div class="norm" style="float:left; width:45px; ">Fax: </div><input style="width:265px;" type="text" name="fax" value="<?=$this->contactsInfo->fax?>" />
            <div class="norm" style="float:left; width:45px; ">Email: </div><input style="width:265px;" type="text" name="email" value="<?=$this->contactsInfo->email?>" />
            <div style="width:50%; float:left; ">
                <div class="norm" style="float:left; width:130px; ">Use Contact Form</div> <input type="checkbox" name="useContactForm" value="1" <?=($this->contactsInfo->useContactForm?"checked=\"checked\"":"")?> />
                <div class="norm" style="float:left; width:130px; ">Use Warranty Form</div> <input type="checkbox" name="useWarrantyForm" value="1" <?=($this->contactsInfo->useWarrantyForm?"checked=\"checked\"":"")?> />
                <div class="norm" style="float:left; width:130px; ">Use Staff Page</div> <input type="checkbox" name="useContactsList" value="1" <?=($this->contactsInfo->useContactsList?"checked=\"checked\"":"")?> />
            </div>
            <div style="width:45%; float:right; text-align:right; margin-top:30px; ">
                <input type="submit" name="contactOptsSubmit" value="Save" style="width:80px; " />
            </div>
        </div>
    </form>
    <div style="width:100%; clear:both; "></div>



    <div class="norm" style="margin-top:75px; text-align:center; width:100%; font-size:17px; font-weight:900; ">Manage Contact Information</div>
    If you checked the "Use Staff Page" above, you will need to add the staff you want listed here.
    To Edit an existing staff, click any of their information listed below.
    This will put their information in the fields below which you can edit and click "Save".
    To Add a new staff person, enter information into the fields below and click "Save".
<?php
    foreach( $this->contactsInfo as $contact )
    { ?>
        <a style="text-decoration:underline; color:#4444EE; " href="siteAdmin.php?module=contacts&contactid=<?=$contact->id?>">
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
            <div class="norm" style="float:right; width:150px; position:relative; top:-25px;">
                <?=$contact->getPictureCode(-1, 150)?>
            </div>
        </a>
<?php
    }  // End foreach

    $contact = null;
    if( isset($_GET['contactid']) )
    {
        $contact = createContactObject($this->rootDir, $_GET['contactid']);
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
?>
    <div class="norm" style="margin-bottom:10px; clear:both; width:100%; text-align:center; font-size:16px; font-weight:900; ">Add or Edit a Contact</div>
    <form method="post" action="<?=$this->contactsInfo->getSaveFormSubmitHref()?>" enctype="multipart/form-data">
        <input type="hidden" name="conId" value="<?=$contact->id?>" />
        <div class="norm" style="float:left; width:350px; ">
            <div class="norm" style="float:left; width:45px; ">Name: </div><input id="newNameBox" style="width:295px;" type="text" name="name" value="<?=$contact->name?>" />
            <div class="norm" style="float:left; width:45px; ">Title: </div><input style="width:295px;" type="text" name="title" value="<?=$contact->title?>" />
            <div class="norm" style="float:left; width:45px; ">Dept: </div><input style="width:295px;" type="text" name="department" value="<?=$contact->department?>" />
            <div class="norm">Description:</div><textarea name="description" style="width:97%; "><?=$contact->description?></textarea>
        </div>
        <div class="norm" style="float:left; width:350px; margin-left:20px; ">
            <div class="norm" style="float:left; width:45px; ">Phone: </div><input style="width:295px;" type="text" name="phone" value="<?=$contact->phone?>" />
            <div class="norm" style="float:left; width:45px; ">Cell: </div><input style="width:295px;" type="text" name="cell" value="<?=$contact->cell?>" />
            <div class="norm" style="float:left; width:45px; ">Email: </div><input style="width:295px;" type="text" name="email" value="<?=$contact->email?>" />
            <div class="norm" style="float:left; width:45px; ">Photo: </div><input size="21" style="width:300px;" type="file" name="image" />
            <div style="margin-top:14px; ">
                <div style="width:100%; float:right; margin-right:7px; text-align:right; "><input type="button" value="Cancel" onmouseup="document.location.href='siteAdmin.php?module=contacts';" style="width:80px; " /> <?= ( !isset($contact) ? "" : "<input style=\"width:80px; \" type=\"button\" value=\"Delete\" onmouseup=\"document.location.href='".$this->contactsInfo->getSaveFormSubmitHref()."?delid={$contact->id}';\" />") ?> <input type="submit" name="contactSubmit" value="Save" style="width:80px; " /></div>
            </div>
        </div>
    </form>
   <div style="width:100%; clear:both; "></div>
</div>