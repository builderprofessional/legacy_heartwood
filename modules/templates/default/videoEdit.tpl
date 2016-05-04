<?php

// Header Info
    $this->display('header.tpl');



// Get Page Content
    $this->display('content.tpl');


// Get BSE Video Tube Edit Form
    $this->display("contentWrapStart.tpl");
    $this->display("videoEditForm.tpl");
    $this->display("contentWrapEnd.tpl");


// Footer Info
    $this->display("footer.tpl");
?>