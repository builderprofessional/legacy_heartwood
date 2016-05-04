<?php

// Header Info
    $this->display("header.tpl");



    echo "<link type='text/css' rel='stylesheet' media='screen' href='{$this->rootDir}css/bseCommunities.css' />";

// Get Page Content
    $this->commPath = $this->curComm->getResourcePath();

// Output Content
?>

                        <div style="width:95%; float:left; margin-top:20px; margin-left:15px; margin-bottom:25px; position:relative; z-index:2; ">
                            <?= $this->fetch("commDetail_Menu.tpl") ?>
                            <?= $this->fetch($this->curComm->getDetailsTemplateHref($this->detailPanel)) ?>
                        </div>
<?php

// Footer Info
    $this->display("footer.tpl");
?>