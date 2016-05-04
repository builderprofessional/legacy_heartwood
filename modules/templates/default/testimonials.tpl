<?php

// Header Info
    $this->display('header.tpl');



// Page Heading
    if( !isset( $this->pageTitle ) )
        echo "<h1>Testimonials</h1><hr style=\"width:90%; \" />";
    else
        echo "<h1>{$this->pageTitle}</h1>";

    if( @trim($this->pageTitle) != "" )
        echo '<hr />';



// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');

    
    
// Output Content
    echo $this->pageContent;

    $this->display("testimonial_data.tpl");

    
    
// Footer Info
    $this->display('footer.tpl');
?>