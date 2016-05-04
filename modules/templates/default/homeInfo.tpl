
<!-- Begin homeInfo.tpl -->

<?php
    echo $this->homes->getStyleLinkCode();
?>

    <?= $this->pageContent ?>
    <h1><?= ( @trim( $this->pageTitle ) == "" ? "Home Details: " : $this->pageTitle ) . $this->home->addr ?></h1>
    


<!--  //////////////////////////////////         Home Navigation          /////////////////////////////   -->
        <a href="./">
            <div class="homeDetailTabLink homeDetailTabLinkHover" style="margin-left:0px; ">
                <span style="position:relative; top:3px; ">Listings</span>
            </div>
        </a>
        <a href="./house.php?homeid=<?= $this->home->id ?>"<?= ($this->homeDetailLink == "description" ? " style=\"position:relative; z-index:2; \" onclick='return false;'" : "" ) ?>>
            <div class="homeDetailTabLink<?= ($this->homeDetailLink == "description" ? "\" style=\"background-image:url('{$this->rootDir}iface/tab_down.png'); color:#444; \"" : " homeDetailTabLinkHover\"" ) ?>>
                <span style="position:relative; top:3px; ">Description</span>
            </div>
        </a>
<?php if( $this->home->hasGallery() )
      {   ?>
        <a href="./gallery.php?homeid=<?= $this->home->id ?>"<?= ($this->homeDetailLink == "gallery" ? " style=\"position:relative; z-index:2; \" onclick='return false;'" : "" ) ?>>
            <div class="homeDetailTabLink<?= ($this->homeDetailLink == "gallery" ? "\" style=\"background-image:url('{$this->rootDir}iface/tab_down.png'); color:#444; \"" : " homeDetailTabLinkHover\"" ) ?>>
                <span style="position:relative; top:3px; ">Gallery</span>
            </div>
        </a>
<?php  }

      if( $this->home->hasFloorplan() )
      {   ?>
        <a href="<?= $this->home->getFloorplanHref() ?>"<?= ($this->homeDetailLink == "floorplan" ? " style=\"position:relative; z-index:2; \" onclick='return false;'" : "" ) ?>>
            <div class="homeDetailTabLink<?= ($this->homeDetailLink == "floorplan" ? "\" style=\"background-image:url('{$this->rootDir}iface/tab_down.png'); color:#444; \"" : " homeDetailTabLinkHover\"" ) ?>>
                <span style="position:relative; top:3px; ">Floorplan</span>
            </div>
        </a>
<?php  }  ?>
        <div class="clear"></div>





        <div id="home_wrapper" style="clear:both; border:solid 2px #884406; position:relative; top:-2px; background-image:url('<?= $this->rootDir ?>iface/folder-bg.png'); z-index:1; overflow:hidden; ">
            <div style="position:absolute; left:0px; top:0px; right:0px; height:600px; background-image:url('<?= $this->home->getDetailGradientHref() ?>'); background-repeat:repeat-x; z-index:-1;"></div>
            <div id="homeToolBox">
<?php  if( $this->moduleInstalled("bseContact") )   
       {   
            $conEmail = str_replace("mailto:", "", strtolower($this->homeContact->email));
?>
                <div class="contactButtonDetails"><span style="position:relative; top:4px; left:10px; ">Contact Info</span></div>
                <ul>
                    <?= ( @trim($this->homeContact->name) != ""  ? "<li><div class=\"contactPersonDetails\">{$this->homeContact->name}</div></li>\n" : "" ) ?>
                    <?= ( @trim($this->homeContact->phone) != "" ? "<li><div class=\"contactPhoneDetails\">{$this->homeContact->phone}</div></li>\n" : "" ) ?>
                    <?= ( @trim($conEmail) != ""                 ? "<li><div class=\"contactEmailDetails\"><a href=\"mailto:{$conEmail}\">$conEmail</a></div></li>\n" : "" ) ?>
                </ul>
<?php   }


    if( $this->homes->useToolBox )   
    {
        echo '
                <div class="contactButtonDetails" style="margin-top:15px; "><span style="position:relative; top:4px; left:10px; ">Tools</span></div>
                <ul>
';

        if( $this->homes->usePrintPage )   
        {
            echo <<< PRNT
                    <li><div class="toolsTextDetails"><a target="_blank" href="printhome.php?homeid={$this->home->id}">Print This Page</a></div></li>

PRNT;
        }



        if( $this->moduleInstalled("bseCommunity") )    
        {
            echo <<< COM
                    <li><div class="toolsTextDetails"><a href="{$this->rootDir}communities/details.php?commid={$this->home->community_id}">View Neighborhood</a></div></li>

COM;
        }  



        if( $this->homes->useMortgageCalc && $this->moduleInstalled("bseMortgageCalculator") && !( @trim( $this->home->price ) == "" && @trim( $this->home->price ) == 0 ) )  
        {
            echo <<< CALC
                    <li><div class="toolsTextDetails"><a target="_blank" href="mortgage.php?price={$this->home->price}">Mortgage Calculator</a></div></li>

CALC;
        } 
      
      
      
        if( $this->homes->useMailFriend == 1 )   
        {
            echo <<< MAIL
                    <li><div class="toolsTextDetails"><a href="mailafriend.php?homeid={$this->home->id}" rel="shadowbox;height=450;width=600">Email This Page</a></div></li>

MAIL;
        }

        echo "
                </ul>
";
    } // End if( useToolBox ) 


?>
            </div>
            <div style="width:100%; margin-top:10px; margin-left:4px; ">
				<?php $img = $this->home->getResizedImage(-1, 430);
				if( $img != "" ): ?>

                <div style="float:left; margin:8px 20px 2px 10px; width:40%; ">
                    <a href="<?=$this->home->getImageHref()?>" rel="shadowbox"><img src="<?= $img ?>" style="width:100%; border:0; " /></a>
                    <div class="clear"></div>
                </div>
                <?php endif; ?>



                <div class="homeDetailCell">
<?php
    $nl = "\n";
                    echo $this->home->getFormatedValue("community_id", "Community", "<a href=\"../communities/details.php?commid=%s\">{$this->community->name}</a>") . $nl;
                    echo $this->home->getFormatedValue("addr", "Address") . $nl;
                    echo $this->home->getFormatedValue("city", "City") . $nl;
                    echo $this->home->getFormatedValue("state", "State") . $nl;
                    echo $this->home->getFormatedValue("zip", "Zip") . $nl;
                    if( @trim( $this->home->price ) != "" )
                        echo "<div class=\"modValueLine\"><div class=\"modValueLabel\">Price:</div><div class=\"modValueData\">$". $this->home->getPrice() . "</div></div>" . $nl;
                    echo $this->home->getFormatedValue("sqft", "Square Foot") . $nl;
                    echo $this->home->getFormatedValue("floors", "Floors") . $nl;
                    echo $this->home->getFormatedValue("beds", "Beds") . $nl;
                    echo $this->home->getFormatedValue("baths", "Baths") . $nl;
                    echo $this->home->getFormatedValue("partbaths", "Partial Baths") . $nl;
                    echo $this->home->getFormatedValue("garage", "Garage") . $nl;
                    echo $this->home->getFormatedValue("yr_built", "Year Built") . $nl;
                    echo $this->home->getFormatedValue("lotsize", "Lot Size") . $nl;
                    echo $this->home->getFormatedValue("acres", "Acres") . $nl;
                    echo $this->home->getFormatedValue("mls", "MLS") . $nl;
                    echo $this->home->getFormatedValue("status", "Status") . $nl;
?>
                </div>


            </div>
            <div class="clear"></div>

<!-- End homeInfo.tpl -->

