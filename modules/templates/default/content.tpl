
<!-- Begin content.tpl -->

<?php

    if( $this->user->inBackDoor() && $this->access >= 2 )
    {
        $this->assign("adminCode", $this->fetch('admin.tpl') );
        echo $this->adminCode;
    }
    else
        echo ( $this->content->code );

?>

<!-- End content.tpl -->

