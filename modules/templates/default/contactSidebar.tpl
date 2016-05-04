

<!-- Begin contactSidebar.tpl -->

            <div style="font-weight:900;"><?=$this->contactPage->company?></div>
            <div class="contactAddress">
                                
<?php

    $csz = ($this->contactPage->city==""?"":$this->contactPage->city.", ").$this->contactPage->state."  ".$this->contactPage->zip;

    if( trim($this->contactPage->address1) !== "" )
        echo "<div>{$this->contactPage->address1}</div>
                                ";

    if( trim($this->contactPage->address2) !== "" )
        echo "<div>{$this->contactPage->address2}</div>
                                ";

    if( trim($csz) !== "" )
        echo "<div>{$csz}</div>
                                ";

    if( trim($this->contactPage->phone) !== "" )
        echo "<div>Phone: {$this->contactPage->phone}</div>
                                ";

    if( trim($this->contactPage->fax) !== "" )
        echo "<div>Fax: {$this->contactPage->fax}</div>
                                ";

    if( trim($this->contactPage->email) !== "" )
        echo "<div>Email: <a href=\"mailto:{$this->contactPage->email}\">{$this->contactPage->email}</a></div>
                                ";

// Contact Type:
    $this->pageType = ($this->contactPage->useContactForm != 0 ? "contact" : ( $this->contactPage->useWarrantyForm!=0?"warranty":"" ) ) ;
    $thelink = "index.php";
    $linkText = "Warranty Request";

    if( isset($_REQUEST['type']) )
    {
        if( substr($_REQUEST['type'], 0, 8) == "warranty" )
        {
           $this->pageType = "warranty";
           $thelink .= "?type=contact";
           $linkText = "Contact Form";
        }
        else
           $thelink .= "?type=warranty";
    }
    else
        $thelink .= "?type=warranty";

    if (isset($_REQUEST['comid'])) 
    {
        $comid = $_REQUEST['comid'];
        $thelink .= "&comid={$comid}";
    }
?>

           </div>
<?php


    // *********    Side bar links    ********** //

    if( $this->contactPage->useContactsList ) 
    {
        echo <<< STAFF
           <div style="margin-top:25px; "><a href="staff.php" style="font-family:Arial, Verdana, Tahoma; font-size:14px; font-weight:bolder;text-decoration:underline; ">See Our Staff</a></div>

STAFF;
    }



    if( ($this->pageType=="contact" && $this->contactPage->useWarrantyForm != 0) || ($this->pageType=="warranty" && $this->contactPage->useContactForm != 0) )
    {
        echo <<< LINK
           <div style="margin-top:25px; ">Or Switch to</div>
           <a href="{$thelink}" style="font-family:Arial, Verdana, Tahoma; font-size:14px; font-weight:bolder;text-decoration:underline; ">{$linkText}</a>

LINK;
    } 


?>

<!-- End contactSidebar.tpl  -->

