<h2 class="DetailPanelCommunityName"><?=$this->curComm->name?> Community Plat Map</h2>

<div class="DetailPanelImage">
<?php
    $imgTag = "%s";
    if( !is_null($this->curComm->details['plat']) )
    {
        if( $this->curComm->details['plat']->hasPDF() )
            $imgTag = "<a href=\"{$this->curComm->details['plat']->getDocHref()}\" target=\"_blank\">%s</a>";

        if( $this->curComm->details['plat']->hasPic() )               // If there is an image
            $imgTag = sprintf($imgTag, "<img class=\"DetailPanelImage\" src=\"{$this->curComm->details['plat']->getImgHref()}\" /");
        else if( $imgTag == "%s" )                  //  No Image and No PDF
            $imgTag = "Image Coming Soon";
        else                                        // No Image but PDF
            $imgTag = sprintf($imgTag, "View a PDF of the Plat Map");
    }
    else
        $imgTag = "";

    echo $imgTag;
?>

</div>

<div class="DetailPanelCommunityDescription" style="padding:12px; ">
    <?php $this->display("content.tpl"); ?>
</div>
