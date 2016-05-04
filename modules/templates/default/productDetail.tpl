<?php

// Header Info
    $this->display('header.tpl');

// Get Page Content
    $this->productDetailLink = "description";
    $this->productDetail = $this->fetch("productInfo.tpl");
    $this->pageContent = $this->fetch('content.tpl');
    

// Output Content
?>
<!-- Begin productDetail.tpl -->

        <div id="content_wrapper" style="width:98.5%; ">

            <?= $this->productDetail ?>
            
        </div id="content_wrapper">

<!-- End productDetail.tpl -->

<?php

// Footer Info
    $this->display("footer.tpl");

?>