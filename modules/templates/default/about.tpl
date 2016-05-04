<?php

// Header Info
    $this->header = $this->fetch('header.tpl');
    echo $this->header;



// Page Heading
    if( !isset( $this->pageTitle ) )
        echo "<h1>About Us</h1>";
    else
        echo "<h1>{$this->pageTitle}</h1>";




// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');

    
    
// Output Content
    echo $this->pageContent;

    
    
// Footer Info
    $this->footer = $this->fetch('footer.tpl');
    echo $this->footer;
?>