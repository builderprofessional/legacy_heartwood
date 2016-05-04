<!-- Begin admin_header_login_form.tpl -->

    <form method="post" action="<?=$this->admin->getLoginFormActionPage()?>" style="display:inline; ">
        <span style="margin-right:5px; ">Username:</span><input id="loginInput" style="width:100px; " type="text" name="uname" />
        <span style="margin-right:5px; margin-left:15px; ">Password:</span><input style="width:100px; " type="password" name="pword" />
        <input type="submit" value="Login" />
    </form>

<!-- End admin_header_login_form.tpl -->