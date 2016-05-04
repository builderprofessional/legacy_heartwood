    <div style="width:355px; margin-left:auto; margin-right:auto; margin-top:30px; ">
        <div>Login</div>
        <form method="post" action="<?=$this->admin->getLoginFormActionPage()?>" style="width:355px; ">
            <input type="hidden" name="page" value="<?= $this->curPage ?>" />
            <div style="margin-top:15px; "><div style="width:120px; float:left; ">Username: </div><input id="loginInput" style="width:230px; " type="text" name="uname" /></div>
            <div style="clear:both; margin-top:15px; "><div style="width:120px; float:left; ">Password: </div><input style="width:230px; " type="password" name="pword" /></div>
            <div style="width:100%; text-align:right; margin-top:15px; "><input type="submit" value="Login" /></div>
        </form>
    </div>

<script>window.onload = document.getElementById('loginInput').focus();</script>