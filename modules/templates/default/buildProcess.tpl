<?php

// Header Info
    $this->display('header.tpl');




// Page Heading
    if( !isset( $this->pageTitle ) )
        echo "<h1>Build Process</h1>";
    else
        echo "<h1>{$this->pageTitle}</h1>";




// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');
    $this->buildProcess = $this->fetch('buildProcess_data.tpl');




// Output Content
?>
    <?= $this->pageContent ?>
    <?= $this->buildProcess ?>
<?php




// Footer Info
    $this->display("footer.tpl");
?>