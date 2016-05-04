<?php

// Header Info
    $this->display('header.tpl');


// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');
    $this->homesContent = $this->fetch( $this->homes->getHomesListTemplateHref() );

// Output Content
?>
<!-- Begin availableHomes.tpl -->

        <?= $this->pageContent ?>
        <?= $this->homesContent ?>

<!-- End availableHomes.tpl -->

<?php

// Footer Info
    $this->display("footer.tpl");
?>