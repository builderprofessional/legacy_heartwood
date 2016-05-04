<div style="width:100%; text-align:center; font-size:16px; font-weight:900; margin-top:35px; margin-bottom:15px; ">Manage Site Admins</div>

<?php

    $query = $this->db->getQueryResult("SELECT * FROM `bseUsers`");
    while( $data = mysql_fetch_array($query) )
    {
        $id = $data['id'];
        $fname = $data['firstName'];
        $lname = $data['lastName'];
        $uname = $data['uName'];
        $pword = $data['pWord'];
?>
<div style="width:48%; float:left; margin-right:15px;">
    <form method="post" action="<?= $this->user->getFormSubmitHref() ?>" style="margin-bottom:20px; ">
        <input type="hidden" name="userid" value="<?=$id?>" />
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">First Name</div>
            <input type="text" name="fname" value="<?=$fname?>" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Last Name</div>
            <input type="text" name="lname" value="<?=$lname?>" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Username</div>
            <input type="text" name="uname" value="<?=$uname?>" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Change Password</div>
            <input type="password" name="pword1" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Retype Password</div>
            <input type="password" name="pword2" />
        </div>
    
        <div style="margin-top:0px; float:right; "><div style="float:left; "><input type="submit" name="siteUsersSubmit" value="Save" style="width:80px; " /></div></form><div style="margin-left:5px; float:left; "><form method="post" action="<?= $this->user->getFormSubmitHref() ?>" onsubmit="return confirm('Are you sure you want to delete this user?'); "><input type="hidden" name="delid" value="<?=$id?>" /><input type="submit" value="Delete" style="width:80px; " /></form></div></div>
    </form>
</div>
<?php
    }
?>
<div style="width:100%; text-align:center; font-size:16px; font-weight:900; margin-top:35px; margin-bottom:15px; clear:both; ">Add New User</div>
<div style="width:50%; margin-right:auto; margin-left:auto; ">
    <form method="post" action="<?= $this->user->getFormSubmitHref() ?>" style="margin-bottom:20px; ">
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">First Name</div>
            <input type="text" name="fname" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Last Name</div>
            <input type="text" name="lname" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Username</div>
            <input type="text" name="uname" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Password</div>
            <input type="password" name="pword1" />
        </div>
        <div class="inputWrapper">
            <div style="margin:0px; font-size:13px; font-weight:900; ">Retype Password</div>
            <input type="password" name="pword2" />
        </div>
        <div style="width:100%; clear:both; "></div>
        <div style="margin-top:3px; float:right; "><input type="submit" name="siteUsersSubmit" value="Save" style="width:80px; " /></div>
        <input type="hidden" name="userid" value="new" />
    </form>
    <div style="width:100%; clear:both; "></div>
</div>
<div style="width:100%; clear:both; "></div>
