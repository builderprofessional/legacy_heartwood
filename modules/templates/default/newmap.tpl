<?php

// Header Info
    $this->display('header.tpl');
    
    $this->display( $this->googleMap->getGoogleMapJsTemplateHref() );
    $this->displayMap = $this->fetch($this->googleMap->getGoogleMapTemplateHref());

// Output Content
?>
<link rel="stylesheet" type="text/css" media="screen" href="<?= $this->getFileHref("bseCommunities.css") ?>" />

        <div class="bgwrapper">
            <div id="mainbody">
                <div id="content">
                    <div class="inside">
                        <h1>Add New Community Map</h1>
                        <div style="width:99%; float:left; margin-top:20px; margin-left:15px; margin-bottom:25px; ">
                            <div style="width:90%; margin:auto; text-align:center; "><div style="font-size:23px; font-weight:900; margin-bottom:20px;">Create New Map</div>
                                Move the map to the place where the community is, set the zoom you desire, enter a name for the map, then click the "Save" button.
                                Or you may cancel this operation by clicking the "Cancel" button.<br /><br />
                                <span style="font-weight:900; ">Note:</span> You can double-click on the map to move it to a certain location and zoom in at the same time for greater location selection detail.<br /><br />
                            </div>
                            <div style="width:<?= $this->googleMap->width ?>px; margin:auto; "><?= $this->displayMap ?></div>
                            <div style="width:550px; margin:auto; ">
                                <form method="post" action="<?=$this->googleMap->getNewMapSubmitHref()?>" onsubmit="this.mapPoint.value=map.getCenter(); this.mapZoom.value=map.getZoom();">
                                    <input type="hidden" name="mapPoint" value="" />
                                    <input type="hidden" name="mapZoom" value="" />
                                    <div>Map Name</div>
                                    <input type="text" name="mapName" style="width:70%;" />
                                    <div style="float:right; "><input style="width:70px;" type="button" value="Cancel" onmouseup="document.location.href='./';" /> <input type="submit" name="mapCreateSubmit" value="Save" style="width:80px;" /></div>
                                </form>
                            </div>
                        </div>
                    </div>
<?php

// Footer Info
    $this->footer = $this->fetch("footer.tpl");
    echo $this->footer;
?>