<?php
    $this->adminMenu = "";
    if( isset($_GET['module']) )
       $this->adminModule = $_GET['module'];


    $this->display('header.tpl');



    echo "<div style=\"width:100%; margin:auto; text-align:center; margin-top:20px; font-size:22px; font-weight:900; \">Website Admin</div>\n";



    if( !$this->user->loggedIn )
        $this->siteAdminCode = $this->fetch("login.tpl");

    else if( isset($this->adminModule) )
        $this->siteAdminCode = $this->fetch("adminModule.tpl");

    else
        echo "<div style=\"margin-left:25px; margin-top:25px; width:100%; text-align:center; \">You are successfully logged in.</div>";




    echo $this->siteAdminCode;



    $this->display('footer.tpl');
?>