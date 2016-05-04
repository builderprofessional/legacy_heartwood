<?php

// Header Info
    $this->header = $this->fetch('header.tpl');
    echo $this->header;





// Get Page Content
    $this->display('content.tpl');
    $this->display('mortgageCalc.tpl');




// Footer Info
    $this->footer = $this->fetch('footer.tpl');
    echo $this->footer;
?>