<?php

// Header Info
    $this->display('header.tpl');



// Get Page Content
    $this->display('content.tpl');


// Get BSE Video Tube Content
    $this->display("contentWrapStart.tpl");
    echo '<div style="width:100%; text-align:center; ">
';
    $this->display("videoTube.tpl");
    echo '</div>';
    $this->display("contentWrapEnd.tpl");


// Footer Info
    $this->display("footer.tpl");
?>