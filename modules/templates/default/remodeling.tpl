<?php

//  Header
    $this->display("header.tpl");

?>

<!-- Begin remodeling.tpl  -->

<script type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>

<?php


// Page Heading
    if( !isset( $this->pageTitle ) )
        echo "<h1>Remodeling</h1><hr style=\"width:90%; \" />";
    else
        echo "<h1>{$this->pageTitle}</h1>";






// Output Content
    $this->display("content.tpl");
    $this->display("remGalleryLayout.tpl");





// Footer Info
    $this->display("footer.tpl");

?>


<!-- End remodeling.tpl  -->