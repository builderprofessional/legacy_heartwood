<!-- Begin Floor Plan Detail Content -->

<div class='centered' style="width:100%; ">
<?php

    $switch = false;
    $direction = "left";
    $plans =& $this->curComm->floorPlans;
    $plans->resetRoot($this->rootDir);
    $curPlan =& $plans->getItemById($_GET['planid']);
    $images = $curPlan->getDetailImagesArray();
    if( $images != null )
    {
        foreach( $images as $img )
        {
            $formCode = "";

            // Prepare variable to receive image tag if there is no pdf associated with the image
            $imgCode = "%s";

            if( trim($img->pdfFile) != "" )                                    // Pdf file exists, let's make a link to it
                $imgCode = "<a href=\"{$this->curComm->getResourcePath()}{$img->pdfFile}\" target=\"_blank\">%s</a>";
            else if( trim($img->imageFile) != "" )                              // No Pdf, if there is an image in the database, get a link to it
                $imgCode = "<a href=\"{$curPlan->getResizedImageHref(-1, 875, $img->imageFile)}\" rel=\"shadowbox\">%s</a>";


                 // Coming out of this block, $imgCode will equal one of three possibilities (%s, <link to pdf>%s</a>, or <link to image>%s</a>).
                 // Below, we will replace the %s with the image tag if there is an image, an invite to see the pdf if there is one, or a message that there is an image coming soon.



            if( trim($img->imageFile) != "" )                                  // Image file exists, put image tag in variable for %s
                $imgCode = sprintf($imgCode, "<img border=\"0\" src=\"{$curPlan->getResizedImageHref(-1, 300, $img->imageFile)}\" />");

            else if( $imgCode == "%s" )                                        // If no image and no pdf...
                $imgCode = "Image Coming Soon";

            else                                                               // No Image but a pdf... Strange, but we'll deal with it
                $imgCode = sprintf($imgCode, "View a PDF About the Floor Plan.");

            if( $this->user->loggedIn && $this->user->backdoor )
            {
                $formCode = "
    <div>
        <form method=\"post\" action=\"{$this->curComm->getPlanDetailSubmitHref()}\">
            <input type=\"hidden\" name=\"commid\" value=\"{$this->curComm->id}\" />
            <input type=\"hidden\" name=\"planid\" value=\"{$curPlan->id}\" />
            <input type=\"hidden\" name=\"imgid\" value=\"{$img->id}\" />
            <div class=\"inputWrapper tb_input\"><div>Plan Image</div><input id=\"imageNameInput_{$img->id}\" type=\"text\" name=\"fpImage\" value=\"{$img->imageFile}\" maxlength=\"75\" /> <img alt=\"Browse\" src=\"{$this->rootDir}iface/browse_btn.png\" onmouseup=\"tinyBrowserPopUp('image','imageNameInput_{$img->id}', '" . urlencode($this->curComm->getMediaDirHref(false)) . "');\" ></div>
            <div class=\"inputWrapper tb_input\"><div>PDF Doc</div><input id=\"fileNameInput_{$img->id}\" type=\"text\" name=\"fpDoc\" value=\"{$img->pdfFile}\" maxlength=\"75\" /> <img alt=\"Browse\" src=\"{$this->rootDir}iface/browse_btn.png\" onmouseup=\"tinyBrowserPopUp('file','fileNameInput_{$img->id}', '" . urlencode($this->curComm->getMediaDirHref(false)) . "');\" ></div>
            <input style=\"width:80px; height:23px; padding:1px; float:right; \" type=\"submit\" name=\"planImageUpdate\" value=\"Save\" /></form><form method=\"post\" action=\"{$this->curComm->getPlanDetailSubmitHref()}\"><input type=\"hidden\" name=\"commid\" value=\"{$this->curComm->id}\" /><input type=\"hidden\" name=\"planid\" value=\"{$curPlan->id}\" /><input type=\"hidden\" name=\"imgid\" value=\"{$img->id}\" /><input style=\"width:80px; height:23px; padding:1px; float:right; margin-right:4px; \" type=\"submit\" name=\"planImageDelete\" value=\"Delete\" />
        </form>
    </div>
";
           }

            echo "<div style=\"width:49%; float:$direction; text-align:center; margin-top:15px; \">
    $imgCode
    $formCode
    <div style=\"width:100%; clear:both; \"></div>
</div>
";
            if( $switch )
                echo "<div style=\"width:100%; height:8px; clear:both; \"></div>
";
            $direction = ($switch ? "left" : "right");
            $switch = !$switch;

        }
    }



    $words = $curPlan->getDetailTextArray();
    $formFooter = $formCode = "";

    if( count($words) > 0 )
    {
        echo "<div style=\"width:49%; float:$direction; text-align:center; margin-top:15px; \">
    ";
        foreach( $words as $item )
        {
            $labelCode = "<div style=\"font-size:larger; font-weight:900; margin-top:15px; \">{$item->label}</div>";
            $textCode = $item->text;

            if( $this->user->loggedIn && $this->user->backdoor )
            {
                $formCode = "<div style=\"width:270px; clear:both; margin-top:8px; \"><form method=\"post\" action=\"{$this->curComm->getPlanDetailSubmitHref()}\"><input type=\"hidden\" name=\"planid\" value=\"{$curPlan->id}\" /><input type=\"hidden\" name=\"commid\" value=\"{$this->curComm->id}\" /><input type=\"hidden\" name=\"textid\" value=\"{$item->id}\" />";
                $labelCode = "<div class=\"inputWrapper\"><div style=\"width:15%; \">Label</div><input style=\"width:80%; \" type=\"text\" name=\"fpTextLabel\" value=\"{$item->label}\" maxlength=\"25\" /></div>";
                $textCode = "<div class=\"inputWrapper\"><div style=\"width:15%; \">Text</div><input style=\"width:80%; \" type=\"text\" name=\"fpText\" value=\"{$item->text}\" maxlength=\"300\" /></div>";
                $formFooter = "<input type=\"submit\" name=\"planTextUpdate\" value=\"Save\" style=\"width:80px; height:23px; padding:1px; float:right; margin-right:3px; \"></form><form method=\"post\" action=\"{$this->curComm->getPlanDetailSubmitHref()}\"><input type=\"hidden\" name=\"commid\" value=\"{$this->curComm->id}\" /><input type=\"hidden\" name=\"planid\" value=\"{$curPlan->id}\" /><input type=\"hidden\" name=\"textid\" value=\"{$item->id}\" /><input type=\"submit\" name=\"planTextDelete\" value=\"Delete\" style=\"width:80px; height:23px; padding:1px; float:right; margin-right:4px; \" /></form><div style=\"width:100%; clear:both; \"></div></div>";
            }

            echo "$formCode
    $labelCode
    <div>$textCode</div>
    $formFooter
    ";
        }
    echo "
</div>
";
    }


    if( $this->user->inBackDoor() )
    {
    
?>
    <script type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>" ></script>
    <div style="width:100%; height:40px; clear:both; "></div>
    <div style="width:49%; float:left; ">
        <div style="width:100%; text-align:center; font-size:13px; font-weight:900; margin-bottom:4px; ">Add a Picture/PDF of this Floorplan</div>
        <form method="post" action="<?= $this->curComm->getPlanDetailSubmitHref() ?>">
            <input type="hidden" name="commid" value="<?= $this->curComm->id ?>" />
            <input type="hidden" name="planid" value="<?= $curPlan->id ?>" />
            <div class="inputWrapper tb_input"><div>Plan Image</div><input id="imageNameInput" type="text" name="fpImage" maxlength="45" /> <img alt="Browse" src="<?= $this->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('image','imageNameInput', '<?= urlencode($this->curComm->getMediaDirHref(false)) ?>');" /></div>
            <div class="inputWrapper tb_input"><div>PDF Doc</div><input id="fileNameInput" type="text" name="fpDoc" maxlength="45" /> <img alt="Browse" src="<?= $this->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('file','fileNameInput', '<?= urlencode($this->curComm->getMediaDirHref(false)) ?>');" /></div>
            <input style="width:80px; height:23px; padding:1px; float:right; " type="submit" name="planImageAdd" value="Save" /><input style="width:80px; float:right; margin-right:4px; " type="reset" value="Reset" />
        </form>
    </div>
    <div style="width:49%; float:left; ">
        <div style="width:100%; text-align:center; font-size:13px; font-weight:900; margin-bottom:4px; ">Add a Text Description to this Floorplan</div>
        <form method="post" action="<?= $this->curComm->getPlanDetailSubmitHref() ?>">
            <input type="hidden" name="commid" value="<?= $this->curComm->id ?>" />
            <input type="hidden" name="planid" value="<?= $curPlan->id ?>" />
            <div class="inputWrapper"><div>Label</div><input type="text" name="fpTextLabel" maxlength="25" /></div>
            <div class="inputWrapper"><div>Text</div><input type="text" name="fpText" maxlength="300" /></div>
            <div style="width:100%; text-align:right; margin:2px; ">
                <input style="width:80px; margin-right:1px; position:relative; top:-1px; " type="reset" value="Reset" />
                <input style="width:80px; height:23px; padding:1px; margin-top:0px; margin-right:3px; " type="submit" name="planTextAdd" value="Save" />
            </div>
        </form>
    </div>
<?php
    }
?>

</div>

<!-- End Floor Plan Detail Content -->