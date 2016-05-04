<?php

// Header Info
    $this->header = $this->fetch('header.tpl');
    echo $this->header;


// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');

// Output Content
?>
                        <div style="width:45%; float:left; margin-top:20px; margin-left:15px; margin-bottom:25px; ">
                            <?= $this->pageContent ?>

                        </div>
<?php

// Footer Info
    $this->footer = $this->fetch("footer.tpl");
    echo $this->footer;
?>