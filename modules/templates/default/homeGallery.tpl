<?php

// Header Info
    $this->display('header.tpl');



// Get Page Content
    $this->homeDetailLink = "gallery";
    $this->homeDetail = $this->fetch("homeInfo.tpl");
    $this->pageContent = $this->fetch('content.tpl');
    
    

// Output Content
?>

<!-- Begin homeGallery.tpl -->

        <div id="content_wrapper" style="width:98.5%; ">
            <?= $this->homeDetail ?>
                <div style="margin-top:10px; margin-left:4px; padding:10px; padding-top:16px; font-size:14px; clear:both; ">
                    <?php $this->display("galleryLayout.tpl"); ?>
                    <div class="clear"></div>
                </div>
            </div id="home_wrapper">
        </div id="content_wrapper">

<!-- End homeGallery.tpl -->

<?php

// Footer Info
    $this->display("footer.tpl");

?>