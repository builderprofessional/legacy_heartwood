<h1 class='DetailPanelCommunityName'><?= $this->curComm->name ?>: Floorplans</h1>

<?php
    $this->admin->editHeight = 400;
    $this->display('content.tpl');
?>
<div class='centered' style="float:left; border-spacing:0; padding:0; width:70%; ">
<?php


if( isset($_GET['planid']) ){ if( trim($_GET['planid']) != "" && trim($_GET['planid']) > 0 )
    $this->display('floorPlanDetail.tpl');
}
else
    $this->display('floorPlanList.tpl');


    echo "</div>
";
?>