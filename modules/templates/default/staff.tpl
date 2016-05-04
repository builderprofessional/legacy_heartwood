<?php

// Header Info
    $this->display('header.tpl');
    echo $this->contactPage->getStyleLink();



// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');
    $this->staffList = $this->fetch($this->contactPage->getStaffTemplateHref());

// Output Content
?>

<!-- Begin staff.tpl -->

    <?= $this->pageContent ?>

    <div style="width:100%; ">
        <h1><?= $this->contactPage->company ?> - Staff</h1>
        <div style="width:20%; height:100%; float:left; margin-left:15px; margin-top:10px; padding-left:1px; padding-bottom:5px; ">
            <?= $this->fetch("contactSidebar.tpl") ?>
        </div>

        <div style="float:left; width:78%; ">
            <?= $this->staffList ?>
        </div>
    </div>

<!-- End staff.tpl   -->

<?php
// Footer Info
    $this->display('footer.tpl');

?>