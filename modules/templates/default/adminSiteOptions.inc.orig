<?php

    $query = $db->getQueryResult("SELECT * FROM `bseSiteOptions` LIMIT 1");
    $data = mysql_fetch_array($query);

    $name = $data['compName'];
    $ad1 = $data['address1'];
    $ad2 = $data['address2'];
    $city = $data['city'];
    $state = $data['state'];
    $zip = $data['zip'];
    $phone1 = $data['phone1'];
    $phone2 = $data['phone2'];
    $email = $data['email'];

?>
<form method="post" action="siteAdmin.php" style="margin-bottom:20px; ">
    <div style="width:100%; text-align:center; font-size:16px; font-weight:900; margin-top:20px; ">Manage Site Information</div>
    <div class="arial11" style="color:#FFFFFF; font-size:13px; font-weight:900; ">Company Name</div>
    <input type="text" name="cName" value="<?=$name?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">Address 1</div>
    <input type="text" name="address1" value="<?=$ad1?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">Address 2</div>
    <input type="text" name="address2" value="<?=$ad2?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">City</div>
    <input type="text" name="city" value="<?=$city?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">State</div>
    <input type="text" name="state" value="<?=$state?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">Zip Code</div>
    <input type="text" name="zip" value="<?=$zip?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">Phone 1</div>
    <input type="text" name="phone1" value="<?=$phone1?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">Phone 2</div>
    <input type="text" name="phone2" value="<?=$phone2?>" style="width:350px; " />
    <div class="arial11" style="color:#FFFFFF; margin-top:10px; font-size:13px; font-weight:900; ">Email</div>
    <input type="text" name="email" value="<?=$email?>" style="width:350px; " />

    <div style="margin-top:20px; "><input type="submit" name="siteOptsSubmit" value="Save" /></div>
</form>    