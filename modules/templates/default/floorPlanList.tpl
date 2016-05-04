<!-- Begin Floor Plan List Content -->

<div class='centered' style="width:100%; ">
<?php

    $plans = &$this->curComm->floorPlans;
    $plans->resetRoot($this->rootDir);
    foreach($plans as $plan)
    {
        echo "
    <div style=\"width:45%; text-align:center; float:left; \">
        ";

        $imgTag = "%s";
        $height = 30;
        if( $plan->hasPDF() )
            $imgTag = "<a href=\"{$plan->getDocHref()}\" target=\"_blank\">%s</a>";
        if( $plan->hasImage() )
        {
            $imgSrc = $plan->getResizedImageHref(-1, 180);
            $height = $plan->resizeH;
            $imgTag = sprintf( $imgTag, "<img class=\"floorplan_image\" style=\"height:{$height}px; \" src=\"{$imgSrc}\" ".($imgTag == "%s" ? "rel=\"shadowbox\"" : "")." />");
        }
        else if( $imgTag == "%s" )
            $imgTag = "Image Comming Soon";
        else
            $imgTag = sprintf($imgTag, "<div style=\"padding10px; \">View a PDF of the Floor Plan</div>");

        echo "$imgTag
    </div>
    ";

        $formCode = "";
        $nameCode = $priceCode = $sizeCode = $compCode = $descCode = "%s";
        
        $extraFormCode = "";

        if( $this->user->inBackDoor() )
        {
            $formCode = "<form method=\"post\" action=\"{$this->curComm->getDetailsSubmitHref()}\"><input type=\"hidden\" name=\"commid\" value=\"{$this->curComm->id}\" /><input type=\"hidden\" name=\"planid\" value=\"{$plan->id}\" />";
            $nameCode = "<div class=\"inputWrapper\"><div>Plan Name</div><input type=\"text\" name=\"planName\" value=\"%s\" /></div>";
            $descCode = "<div class=\"inputWrapper\" style=\"height:auto; \"><div>Description</div><textarea name=\"planDesc\" style=\"width:198px; height:70px;\">%s</textarea></div>";
            $priceCode = "<div class=\"inputWrapper\"><div>Plan Price</div><input type=\"text\" name=\"planPrice\" value=\"%s\" /></div>";
            $sizeCode = "<div class=\"inputWrapper\"><div>Plan Size</div><input type=\"text\" name=\"planSize\" value=\"%s\" /></div>";
            $compCode = "<div class=\"inputWrapper\"><div>Plan Completion</div><input type=\"text\" name=\"planComp\" value=\"%s\" /></div>";
            $extraFormCode = "
        <div class=\"inputWrapper tb_input\"><div>Plan Image</div><input id=\"imageNameInput_{$plan->id}\" type=\"text\" name=\"fpImage\" value=\"{$plan->photo}\" style=\"width:160px;\" maxlength=\"45\" /> <img alt=\"Browse\" style=\"width:20px; height:20px; position:relative; top:4px; \" src=\"{$this->rootDir}iface/browse_btn.png\" onmouseup=\"tinyBrowserPopUp('image','imageNameInput_{$plan->id}', '" . urlencode($this->curComm->getMediaDirHref(false)) . "');\" ></div>
        <div class=\"inputWrapper tb_input\"><div>PDF Doc</div><input id=\"fileNameInput_{$plan->id}\" type=\"text\" name=\"fpDoc\" value=\"{$plan->pdf}\" style=\"width:160px;\" maxlength=\"45\" /> <img alt=\"Browse\" style=\"width:20px; height:20px; position:relative; top:4px; \" src=\"{$this->rootDir}iface/browse_btn.png\" onmouseup=\"tinyBrowserPopUp('file','fileNameInput_{$plan->id}', '" . urlencode($this->curComm->getMediaDirHref(false)) . "');\" ></div>
        <div style=\"width:100%; clear:both; height:4px; \"></div>
        ";
        }
        $nameCode = sprintf($nameCode, $plan->name);
        $descCode = sprintf($descCode, $plan->shortDesc);
        $priceCode = sprintf($priceCode, ( $plan->price == "0" ? "" : $plan->price) );
        $sizeCode = sprintf($sizeCode, $plan->size);
        $compCode = sprintf($compCode, $plan->completion);

    echo "<div style=\"width:45%; height:{$height}px; min-height:100px; float:right; text-align:center; display:table; \"><div style=\"height:100%; display:table-cell; vertical-align:middle; \">$formCode
        <div" . ($this->user->inBackDoor() ? "" : " style=\"width:100%; font-size:larger; font-weight:900; \"" ) . ">$nameCode</div>
        <span class=\"FloorPlanDetailLink\"><a href=\"{$this->rootDir}{$this->curPage}?panel=3&commid={$this->curComm->id}&planid={$plan->id}\">" . ($this->user->inBackDoor() ? "Edit" : "View" ) . " Details</a></span>
        <div>$priceCode</div>
        <div>$sizeCode</div>
        <div>$compCode</div>
        <div style=\"width:100%; clear:both; height:3px; \"></div>
        <div style=\"margin-top:4px; \">$descCode</div>
        $extraFormCode
        ".($this->user->loggedIn && $this->user->backdoor ? "<input style=\"width:80px; float:right; \" type=\"submit\" class=\"submit\" value=\"Save\" name=\"fpUpdateSubmit\" /><input type=\"reset\" class=\"submit\" value=\"Reset\" style=\"width:80px; float:right; margin-right:4px;\" /></form><form onsubmit=\"return confirm('Are you sure you want to delete this floorplan?');\" method=\"post\" action=\"{$this->curComm->getDetailsSubmitHref()}\"><input type=\"hidden\" name=\"planid\" value=\"{$plan->id}\" /><input type=\"hidden\" name=\"commid\" value=\"{$this->curComm->id}\" /><input type=\"submit\" name=\"delFloorPlanSubmit\" value=\"Delete\" class=\"submit\" style=\"width:80px; float:right; margin-right:4px; \"</form>" : "")."
    </div></div>
    ";
    }
echo "
<div style=\"width:100%; clear:both; \"></div>
</div>
";


if( $this->user->loggedIn && $this->user->backdoor )
{
    echo "<script type=\"text/javascript\" src=\"" . $this->getFileHref("tb_standalone.js.php") . "\" ></script>\n";
    echo "<div style=\"clear:both; width:100%; text-align:center; font-size:15px; font-weight:900; margin-top:25px; \">New Floor Plan Form</div>\n<form method=\"post\" action=\"{$this->curComm->getDetailsSubmitHref()}\" style=\"width:95%; \">
    <input type=\"hidden\" name=\"commid\" value=\"{$this->curComm->id}\" />
    <div style=\"width:54%; float:left; margin-right:10px; \">
        <div class=\"inputWrapper\"><div>Plan Name</div><input type=\"text\" name=\"fpName\" maxlength=\"50\" /></div>
        <div class=\"inputWrapper\"><div>Price</div><input type=\"text\" name=\"fpPrice\" maxlength=\"10\" /></div>
        <div class=\"inputWrapper\"><div>Size</div><input type=\"text\" name=\"fpSize\" maxlength=\"30\" /></div>
        <div class=\"inputWrapper\"><div>Completion</div><input type=\"text\" name=\"fpComp\" maxlength=\"100\" /></div>
        <div class=\"inputWrapper tb_input\"><div>Plan Image</div><input style=\"margin-left:8px; \" id=\"imageNameInput\" type=\"text\" name=\"fpImage\"maxlength=\"45\" /> <img alt=\"Browse\" src=\"{$this->rootDir}iface/browse_btn.png\" onmouseup=\"tinyBrowserPopUp('image','imageNameInput', '" . urlencode($this->curComm->getMediaDirHref(false)) . "');\" /></div>
        <div class=\"inputWrapper tb_input\"><div>PDF Document</div><input style=\"margin-left:8px; \" id=\"fileNameInput\" type=\"text\" name=\"fpDoc\" maxlength=\"45\" /> <img alt=\"Browse\" src=\"{$this->rootDir}iface/browse_btn.png\" onmouseup=\"tinyBrowserPopUp('file','fileNameInput', '" . urlencode($this->curComm->getMediaDirHref(false)) . "');\" /></div>
    </div>
    <div style=\"width:40%; float:left; margin-top:3px; \">
        <div class=\"inputWrapper\" style=\"height:auto; \"><div style=\"width:100px; float:none; text-align:left; margin:0px; \">Description</div><textarea name=\"shortDesc\" style=\"width:100%; height:70px; \"></textarea></div>
        <div style=\"float:right; padding:0; margin-right:-5px; \"><input style=\"width:80px; \" type=\"submit\" name=\"newFloorplanSubmit\" value=\"Add\" /></div>
    </div>
</form>
";
}
?>
<!-- End Floor Plan List Content -->