<?php

// Header Info
    $this->display('header.tpl');


// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');
    $this->productsContent = $this->fetch( $this->products->getProductsListTemplateHref() );

// Output Content
?>
<!-- Begin products.tpl -->

        <h1><?= ( @trim( $this->pageTitle ) != "" ? $this->pageTitle : "Products" ) ?></h1>

        <?= $this->pageContent ?>
        <?= $this->productsContent ?>

<!-- End products.tpl -->

<?php

// Footer Info
    $this->display("footer.tpl");
?>