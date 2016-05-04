<?php

// Header Info
    $this->display('header.tpl');




// Page Heading
    if( !isset( $this->pageTitle ) )
        echo "<h1>Communities</h1>";
    else
        echo "<h1>{$this->pageTitle}</h1>";




// Output Page Content
    $this->display('content.tpl');
    $this->display($this->googleMap->getMapDisplayTemplateHref());



// Footer Info
    $this->display("footer.tpl");
?>