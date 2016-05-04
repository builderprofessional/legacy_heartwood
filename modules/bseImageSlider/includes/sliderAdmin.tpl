<?php
    $this->editSlider = true;
    $curSpeed = $this->slider->sliderSpeed;
    $this->colorpickerInitColor = $this->slider->backgroundColor;

    include($this->rootDir."modules/includes/config.inc");
    $db = new bseConnection($dbHost, $dbSchema, $dbUser, $dbPass);
?>
<script type="text/javascript">
    function colorChangeEvent()
    {
        document.getElementById('bgColorInput').value = cp1.color.hex;
    }

    function setFormInfo(img)
    {
        var id = img.getAttribute("imgID");
        var desc = img.getAttribute("imgDesc");
        var frm = document.getElementById("imgForm");

        frm.img_id.value = id;
        frm.desc.value = desc;
    }
</script>





<div class="norm" style="width:700px; margin:auto; ">
    <div style="margin-bottom:15px; ">
        <div style="font-size:18px; font-weight:900; width:100%; text-align:center; margin-top:30px; ">Scroller Options</div>
        Select the Scroller you want to edit in the drop-down menu below, or choose to create a new Scroller.
        When you are happy with the options for the Scroller, you can set it to display on your website by checking the "Use Scroller on Site" checkbox.
        Click the "Save" button below this section, then you can scroll down the page and see a preview of your Scroller.
    </div>
    <form method="post" action="<?=$this->slider->getFormSubmitHref()?>">
        <div style="width:250px; float:left; ">
            <div style="margin-top:8px; ">Choose a Scroller to Edit</div>
            <select name="slider_select" onchange="document.location.href='siteAdmin.php?module=slider&sid='+this.options[this.selectedIndex].value;" style="width:200px;">
                <option value="new">New Scroller</option>
<?php
    $res = $db->getQueryResult("SELECT * FROM `bseImageSlider`");
    while( $data = mysql_fetch_array($res) )
    {
        $selected = "";
        if( $data['id'] == $this->slider->id )
           $selected = ' selected="selected"';
        echo "<option value=\"{$data['id']}\"{$selected}>{$data['name']}</option>\n";
    }
?>
            </select>
            <input type="hidden" name="slider_id" value="<?= ( isset($_GET['sid'])? htmlentities($_GET['sid']):$this->slider->id) ?>" />
            <div><div style="width:100px; margin-top:8px; ">Name</div><input style="width:200px;" type="text" name="name" value="<?= $this->slider->name ?>" /></div>
            <div><div style="width:100px; margin-top:8px; ">Width</div><input style="width:200px;" type="text" name="width" value="<?= $this->slider->scrollWidth ?>" /></div>
            <div><div style="width:100px; margin-top:8px; ">Height</div><input style="width:200px;" type="text" name="height" value="<?= $this->slider->imageHeight ?>" /></div>
            <div style="margin-top:8px;"><div style="width:70px; float:left; ">Speed</div><div style="width:150px; float:left;">Space Btwn (Even #)</div>
                <select name="sliderSpeed" style="width:60px; float:left; clear:left;">
                    
<?php
    for( $i = 1; $i <= 10; $i++ )
    {
        echo "<option value=\"$i\" ".($i==$curSpeed?'selected="selected"':"").">$i</option>
                    ";
    }
?>

                </select>
                <input style="width:50px; float:left; margin-left:10px;" type="text" name="spacing" value="<?=$this->slider->spacing?>" />
                <div style="width:100%; clear:both; "></div>
            </div>
            <div style="margin-top:10px; "><input type="checkbox" name="active" value="1" <?= ($this->slider->active == 1? 'checked="checked"':"")?> onchange="if( !this.checked && document.getElementById('isActive').value=='1' ){ if( !confirm('If you deactivate this Scroller your site will not have any scrolling images showing.\nIt is better to select the Scroller you want, and activate it.\n\nAre you sure you want to deactivate this Scroller?') ){ this.checked = true; } }" /> Use Scroller on Site</div>
        </div>

        <div style="width:430px; float:right; ">
            <div>Background Color</div>
            <?php echo $this->fetch($this->rootDir."modules/includes/colorPicker.tpl"); ?>
        </div>
        <div style="width:100%; clear:both; "></div>
        <input id="bgColorInput" type="hidden" name="bgColor" value="<?= $this->slider->backgroundColor ?>" />
        <input id="isActive" type="hidden" value="<?= $this->slider->active ?>" />
        <div style="float:left; "><input type="submit" name="sliderSubmit" value="Save" style="width:80px; " /></div></form><div style="float:left; margin-left:10px; "><form onsubmit="return confirm('Are You Sure You Want To Delete This?');" method="post" action="<?= $this->slider->getFormSubmitHref()?>"><input type="hidden" name="scroller_id" value="<?=$this->slider->id?>" /><input name="delSliderSubmit" type="submit" value="Delete" /></form></div>
</div>




<div class="norm" style="width:700px; margin:auto; margin-top:110px; clear:both; ">
    <div style="font-size:18px; font-weight:900; width:100%; text-align:center; ">Scroller Images</div>
    Upload new pictures for the Scroller, or click an image below to edit it. You may change a picture's description and/or upload a different picture for the one you are editing.
    If you click a picture to edit it and change your mind and want to upload a new picture, click the "Cancel" button to set the form to upload a new picture.<br /><br />
    <form id="imgForm" enctype="multipart/form-data" method="post" action="<?=$this->slider->getFormSubmitHref()?>">
        <input type="hidden" name="slider_id" value="<?= $this->slider->id ?>" />
        <input type="hidden" name="img_id" value="new" />
        <div style="float:left;"><div style="width:100px; margin-top:8px; ">Description</div><textarea name="desc" style="width:340px; "></textarea></div>
        <div style="float:right; "><div style="width:100px; margin-top:8px; ">Picture</div><input size="25" style="width:340px;" type="file" name="slider_file" /></div>
        <div style="float:right; text-align:right; margin-top:5px; margin-right:5px; "><input style="width:80px;" type="button" value="Cancel" onmouseup="this.form.desc.value=''; this.form.img_id.value='new';" /> <input style="width:80px; " type="submit" name="sliderImageSubmit" value="Save" /></div>
    </form>
    <div style="width:100%; clear:both;"></div>
</div>




<div class="norm" style="width:700px; margin:auto; margin-top:22px; clear:both; ">
    <div style="font-size:13px; font-weight:900; width:400px; margin:auto; text-align:center; ">Click an image to edit its options. Click the "Delete" button to remove the image from the Scroller.</div> <!-- Click and drag an image to change its order in the Scroller.</div> -->
<?php
    $counter = 0;
    foreach( $this->slider as $img )
    {
        if( $img->sorder == 255 || $img->sorder == "" )
            $img->setValue("sorder", $counter++);

        echo "<div style=\"height:160px; float:left; margin-right:10px; \"><img style=\"cursor:pointer; \" onmouseup=\"setFormInfo(this);\" imgID=\"{$img->id}\" imgDesc=\"" . addslashes($img->description) . "\" border=0 src=\"".$img->getResizedImage(130, -1)."\" /><div style=\"width:100%; text-align:center; \"><form onsubmit=\"return confirm('Are You Sure You Want To Delete This?');\" method=\"post\" action=\"".$img->getDeleteHref()."\"><input type=\"hidden\" name=\"slider_id\" value=\"".$this->slider->id."\" /><input type=\"hidden\" name=\"img_id\" value=\"{$img->id}\" /><input type=\"submit\" name=\"delid\" value=\"Delete\" style=\"height:20px; width:80px; \" /></form></div></div>";
    }
?>
    <div style="width:100%; clear:both; "></div>
</div>





<div id="preview" class="norm" style="width:100%; margin:auto; margin-top:75px; clear:both; ">
    <div style="width:400px; margin:auto; text-align:center; font-size:18px; font-weight:900; ">Scroller Preview</div>
    <?= $this->display("slider.tpl") ?>
</div>

<?php
    $this->editSlider = false;
?>