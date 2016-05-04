<?php

    echo "<a class=\"footerLinks\" href=\"{$this->rootDir}siteAdmin.php\"><span class=\"footerLinks\">Admin</span></a> {$this->spacer} ";
    if( $this->user->loggedIn )
    {
        echo "<a class=\"footerLinks\" href=\"{$this->admin->getLogoutHref()}\"><span class=\"footerLinks\">Logout</span> {$this->spacer} ";
        echo "<a class=\"footerLinks\" href=\"{$this->admin->getToggleFrontBackHref()}\"><span class=\"footerLinks\">Toggle Front/Back</span></a> {$this->spacer} ";
    }

    $this->display('bse_footer.tpl');
?>