<?php

// Header Info
    $this->display('header.tpl');

// Get Page Content
    $this->homeDetailLink = "description";
    $this->homeDetail = $this->fetch("homeInfo.tpl");
    $this->pageContent = $this->fetch('content.tpl');
    

// Output Content
?>
<!-- Begin homeDetail.tpl -->

        <div id="content_wrapper" style="width:98.5%; ">
            <?= $this->homeDetail ?>

                <div class="homeDescriptionDetail"><?= nl2br($this->home->description) ?></div>
            </div id="home_wrapper">
        </div id="content_wrapper">

<!-- End homeDetail.tpl -->

<?php

// Footer Info
    $this->display("footer.tpl");

?>