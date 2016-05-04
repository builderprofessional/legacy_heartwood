<?php

// Header Info
    $this->display('header.tpl');


    echo $this->contactPage->getStyleLink();
    echo $this->contactPage->getFormCheckJs();


// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');

// Output Content
?>

<!-- Begin contact.tpl -->


    <?= $this->pageContent ?>
    <div style="width:100%; ">
        <h1>Contact Us</h1>

<?php
    if( isset($_GET['err']) && $_GET['err'] == "captcha" )
        echo "<div class=\"norm msg errMsg\">The Security Answer is Incorrect<br />Please Enter the Answer to the Question Below</div>";
    else if( isset($_GET['sent']) && $_GET['sent'] == "true" )
        echo "<div class=\"norm msg\">Your message has been sent.<br />Thank you for your interest.</div>";
?>   

        <div style="width:20%; height:100%; float:left; margin-left:15px; margin-top:10px; padding-left:1px; padding-bottom:5px; ">
            <?= $this->fetch("contactSidebar.tpl") ?>
        </div>

        <div style="float:left; width:74%; ">
<?php
    if( $this->pageType == "warranty" && $this->contactPage->useWarrantyForm != 0 )
        $this->display($this->contactPage->getWarrantyTemplate() );
    else if( $this->contactPage->useContactForm != 0 )
        $this->display($this->contactPage->getContactTemplate() );
?>
        </div>
    </div>

<!-- End contact.tpl -->

<?php


// Footer Info
    $this->display("footer.tpl");
?>