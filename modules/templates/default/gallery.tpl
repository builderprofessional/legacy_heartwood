<?php

// Header Info
    $this->display('header.tpl');




// Page Heading
    if( !isset( $this->pageTitle ) )
        echo "<h1>Photo Gallery</h1>";
    else
        echo "<h1>{$this->pageTitle}</h1>";





// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');
    $this->galleryContent = $this->fetch('galleryLayout.tpl');



// Output Content
?>
    <?= $this->pageContent ?>
    <?= $this->galleryContent ?>
<?php



// Footer Info
    $this->display("footer.tpl");
?>