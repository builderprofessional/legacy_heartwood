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
<div style="width:320px; float:left; margin-right:15px;">
    <form method="post" action="<?= $this->user->getFormSubmitHref() ?>" style="margin-bottom:20px; ">
        <input type="hidden" name="id" value="<?=$id?>" />
        <div class="arial11" style="color:#FFFFFF; font-size:13px; font-weight:900; ">First Name</div>
        <input type="text" name="fname" value="<?=$fname?>" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Last Name</div>
        <input type="text" name="lname" value="<?=$lname?>" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Username</div>
        <input type="text" name="uname" value="<?=$uname?>" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Change Password</div>
        <input type="password" name="pword1" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Retype Password</div>
        <input type="password" name="pword2" style="width:300px; " />
    
        <div style="margin-top:5px; float:left; "><input type="submit" name="siteUsersSubmit" value="Save" style="width:80px; " /></div></form><div style="margin-left:5px; float:left; "><form method="post" action="<?= $this->user->getFormSubmitHref() ?>"><input type="hidden" name="delid" value="<?=$id?>" /><input type="submit" value="Delete" style="width:80px; position:relative; top:-15px;" /></form></div>
    </form>
</div>
<?php
    }
?>
<div style="width:100%; text-align:center; font-size:16px; font-weight:900; margin-top:35px; margin-bottom:15px; clear:both; ">Add New User</div>
<div style="width:320px; margin-right:auto; margin-left:auto; ">
    <form method="post" action="<?= $this->user->getFormSubmitHref() ?>" style="margin-bottom:20px; ">
        <div class="arial11" style="color:#FFFFFF; font-size:13px; font-weight:900; ">First Name</div>
        <input type="text" name="fname" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Last Name</div>
        <input type="text" name="lname" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Username</div>
        <input type="text" name="uname" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Change Password</div>
        <input type="password" name="pword1" style="width:300px; " />
        <div class="arial11" style="color:#FFFFFF; margin-top:1px; font-size:13px; font-weight:900; ">Retype Password</div>
        <input type="password" name="pword2" style="width:300px; " />
    
        <div style="margin-top:5px; "><input type="submit" name="siteUsersSubmit" value="Save" style="width:80px; " /></div>
        <input type="hidden" name="id" value="new" />
    </form>
</div>
