<h2 class='DetailPanelCommunityName'>Welcome to <?= $this->curComm->name ?></h2>

<div class='centered' style="width:620px; border-spacing:0; padding:0; ">
<?php
    foreach($this->curCom->floorPlans as $plan)
    {
        echo "    <div style=\"width:300px; text-align:center; float:left; \">
        ";

        $imgTag = "%s";
        if( $plan->hasPDF() )
            $imgTag = "<a href=\"{$plan->getDocHref()}\" target=\"_blank\">%s</a>";
        if( $plan->hasImage() )
            $imgTag = sprintf($imgTag, "<img src=\"{$plan->getResizedImageHref(-1, 300)}\" ".($imgTag == "%s" ? "rel=\"lightbox\" : "")." />");
        else if( $imgTag == "%s" )
            $imgTag = "Image Comming Soon";
        else
            $imgTag = sprintf($imgTag, "View a PDF of the Floor Plan");

        echo "$imgTag
    </div>
    <div style=\"width:310px; float:left; text-align:center; \">
        <div style=\"width:100%; font-size:larger; font-weight:900; \">{$plan->name}</div>
        <span class=\"FloorPlanDetailLink\"><a href=\"community_details.php?DetailPanel=3&CommunityID={$this->curCom->id}&PlanID={$plan->id}\">View Details</a></span>
        <div style=\"margin-top:4px; \">{$plan->shortDesc}</div>
    </div>
</div>
";
    }
?>

<div class='DetailPanelCommunityDescription' style='padding:12px; '>
    <?php $this->display('content.tpl'); ?>
</div>
