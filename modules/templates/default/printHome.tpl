<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
        <title>Print Home Information: <?= $this->home->addr ?></title>
        <link rel="stylesheet" type="text/css" href="<?= $this->rootDir ?>css/site_style.css.php">
        <style type="text/css">
            body 
            {
                background: #ffffff;
            }
            .bold
            {
                font-weight:900;
            }
         </style>
    
    </head>
    <body background-color="#ffffff">
        <table align="center" border="0" style="border:solid; border-width:thin;" cellpadding="4" cellspacing="5"><tr>
            <td align="left" valign="top" width="640">
                <table border="0" cellpadding="0" cellspacing="0"><tr>
                    <td align="center" valign="middle" width="120"><img src="<?= $this->rootDir ?>iface/logo-print.png" border="0" width="120" /></td>
                    <td align="left" valign="top" width="520">
                        <table border="0" cellpadding="0" cellspacing="0"><tr>
                            <td align="center" valign="middle" width="520"><div style="font-size:56px; font-weight:900; font-family:Arial, Verdana, Sans; margin-top:10px; "><?= $this->busContact->company ?></div><div style="font-size:30px; font-weight:900; ">Available Homes</div></td>
                        </tr></table>
                    </td>
                </tr></table>
                <table border="0" cellpadding="4" cellspacing="5"><tr>
                    <td style="border:solid; border-width:thin;" align="center" valign="middle" width="380"><img src="<?= $this->home->getResizedImage(300, 380) ?>"></td>
                    <td style="border:solid; border-width:thin;" align="left" valign="top" width="260" >
                        <table align="center" border="0" cellpadding="0" cellspacing="0"><tr>
                            <td width="10"><br></td>
                            <td align="left" valign="top" width="240">
                                <span class="bold">Address</span>:<br><span ><span class="bold"><?=$this->home->addr?></span></span><br><?=$this->home->city . ", " . $this->home->state . " " . $this->home->zip ?><br><br>
<?php if( $this->home->community_id > 0 )  {     ?>
                                <span class="bold">Neighborhood</span>:<br><?= $this->community->name ?><br><br>
<?php   }   ?>
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <?= formatHomeValue($this->home->getPrice(), "Price", "$") ?>
                                    <?= formatHomeValue($this->home->sqft, "Sq.Ft.") ?>
                                    <?= formatHomeValue($this->home->floors, "Floors") ?>
                                    <?= formatHomeValue($this->home->beds, "Bedrooms") ?>
                                    <?= formatHomeValue($this->home->baths, "Bathrooms") ?>
                                    <?= formatHomeValue($this->home->partbaths, "Partial Baths") ?>
                                    <?= formatHomeValue($this->home->garage, "Garage") ?>
                                    <?= formatHomeValue($this->home->yr_built, "Year Built") ?>
                                    <?= formatHomeValue($this->home->lotsize, "Lot Size") ?>
                                    <?= formatHomeValue($this->home->acres, "Acres") ?>
                                    <?= formatHomeValue($this->home->mls, "MLS") ?>
                                </table>
                            </td>
                            <td width="10"><br></td>
                        </tr></table>
                    </td>
                </tr></table>
    
                <br>
    
                <table border="0" cellpadding="4" cellspacing="5"><tr>
                    <td style="border:solid; border-width:thin;" align="left" valign="top" width="200">
                        <table align="center" border="0" cellpadding="0" cellspacing="0"><tr>
                            <td align="left" valign="top" width="180" ><span class="bold">Sales Contact:</span><br>
                                <span class="bold"><?= $this->homeContact->name ?></span><br>
                                <?=  $this->homeContact->phone ?><br>
                                <?= $this->homeContact->email ?><br><br>
                                <hr><br>
                                <span class="bold">Corporate:</span><br>
                                <span class="bold"><?= $this->busContact->company ?></span><br>
                                <?=$this->busContact->address1?><br>
                                <?=$this->busContact->city . ", " . $this->busContact->state . " " . $this->busContat->zip ?><br>
                                <?=$this->busContact->phone ?><br><br>
                                <span class="bold">E-mail:</span><br><?=$this->busContact->email ?><br><br>
                                <span class="bold">Website:</span><br><?= $_SERVER['SERVER_NAME'] ?><br>
                            </td>
                        </tr></table>
                    </td>
                    <td style="border:solid; border-width:thin;" align="left" valign="top" width="440"><?=$this->home->description ?></td>
                </tr></table>
            
                <br>

                <table border="0" cellpadding="4" cellspacing="5"><tr>
                    <td style="border:solid; border-width:thin;" align="center" valign="top" width="660"><br>Copyright <?= date("Y") . " " . $this->busContact->company ?><br><br></td>
                </tr></table>
            </td>
        </tr></table>
    </body>
</html>
<?php

    function formatHomeValue($value, $label, $preValue = "", $postValue = "")
    {
        if( trim($value) != "" )
            return "
                                    <tr>
                                        <td align=\"left\" valign=\"top\" width=\"120\" ><span class=\"bold\">$label</span>:</td>
                                        <td align=\"right\" valign=\"top\" width=\"120\">{$preValue}$value{$postValue}<br></td>
                                    </tr>
";
        else
            return "";
    }
?>