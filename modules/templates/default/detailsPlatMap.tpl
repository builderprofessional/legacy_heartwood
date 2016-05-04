<h1 class='DetailPanelCommunityName'><?= $this->curComm->name ?>: Community Plat Map</h1>
<!-- <a style="margin-bottom:2em; " href='printcommunitydetail.php?commid=".$this->curComm->id."&panel=".$this->panel."' target='_blank'><img border=0 src='images/print_off.gif' /></a> -->

<div class='DetailPanelCommunityDescription' style='padding:12px; '>
    <?php $this->display('content.tpl'); ?>
</div>
