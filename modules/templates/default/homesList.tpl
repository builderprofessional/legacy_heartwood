<h1><?= ( @trim( $this->pageTitle ) != "" ? $this->pageTitle : "Home Listings" ) ?></h1>
<?php
    echo $this->homes->getStyleLinkCode();

    if( $this->moduleInstalled("bseCommunitiesCollection") )
    {
        $coms = $this->getModule("bseCommunitiesCollection");
        $coms->setAllCommunitiesList();
        
        echo '<div style="width:100%; text-align:right; ">Select a Community to view homes only in that community: ';
        $this->retPage = $this->removeArgFromURL("commid", $this->retPage);
        echo "<select onchange=\"document.location.href='{$this->rootDir}{$this->retPage}" . ( strpos($this->retPage, "?") === false ? "?" : "&" ) . "commid=' + this.options[this.selectedIndex].value;\"><option value=\"\">Filter by Community</option><option value=\"-1\">All Communities</option>";
        foreach( $coms as $com )
        {
            $sel = "";
            if( @$_GET['commid'] == $com->id )
                $sel = ' selected="selected"';
            echo "
            <option value=\"{$com->id}\"$sel>{$com->name}</option>";
        }
        echo "<option value=\"0\">Unspecified Community</option></select></div>";
    }

    foreach($this->homes as $home)
    {
        if( $home->active <= 0 ) continue;
        $img = $home->getResizedImage(-1, 300);
        $com = null;
        
        if( $home->community_id > 0 )
        {
            $com =& $this->getModule("bseCommunity");
            if( trim($com->id) == "" ||  $com->id != $home->community_id )
            {
                $com->setCommunityId($home->community_id);
            }
        }
        
        
        if( !$this->moduleInstalled("bseCommunitiesCollection") && $home->communityName != "" )
        {
            $com = new stdClass();
            $com->name = $home->communityName;
        }
        
        $priceCode = "%s";
        
        if( $home->isSold() )
            $priceCode = "<del>%s</del>";

?>
    <div class="homeContainer">
        <div style="float:left; width:320px; font-weight:900; ">
            <a href="house.php?homeid=<?= $home->id ?>"><?php if( $img != "" ): ?><img src="<?= $img ?>" style="float:right; width:<?= $home->resizeW ?>px; height:<?= $home->resizeH ?>px; border:0; " /><?php endif; ?></a>
            <div class="clear"></div>
        </div>
        <div style="float:left; width:25%; margin-left:10px; ">
            <div><a class="detailsLink" href="house.php?homeid=<?= $home->id ?>"><?= ( @trim($com->name) != "" ? $com->name . ": " : "" ) . ( trim( $home->addr ) == "" ? (trim($home->lot) == "" ? "" : "Lot " . $home->lot ) : $home->addr ) ?></a></div>
            <ul style="margin-top:20px; ">
<?php
    if( $com->name != "" )
        echo "
                <li>{$com->name}</li>
";
?>
                <li><?= ( trim($home->addr) != "" ?  $home->addr : ( @trim( $com->name ) != "" ? $com->name . ":" : "" ) . ( trim($home->lot) == "" ? "" : " Lot " . $home->lot ) ) ?></li>
<?php
    if( @trim( $home->city ) != "" || @trim( $home->state ) != "" )
    {
        echo "
                <li>";
        if( @trim( $home->city ) != "" )
        {
            echo $home->city;
        }
        
        if( @trim( $home->state ) != "" )
        {
            echo ", " . $home->state;
        }
        
        echo "</li>
             ";
    }


    if( @trim( $home->beds ) != "" || @trim( $home->baths ) != "" )
    {
        echo "<li>";
        if( @trim( $home->beds ) != "" )
            echo $home->beds . " Beds ";
            
        if( @trim( $home->baths ) != "" )
            echo $home->baths . " Baths";
            
        echo "</li>\n";
    }
    
    if( @trim( $home->price ) != "" && @trim( $home->price ) != "0" )
    {
        echo "<li>";
        echo sprintf($priceCode, "$" . $home->getPrice() ) . "<div>" . $home->getStatus() . "</div>";
        echo "</li>\n";
    }
?>

            </ul>
        </div>
        <div style="float:left; width:32%; margin-left:10px; ">
            <?= $home->description ?>
        </div>
        <div class="clear"></div>
        <hr style="width:90%; margin:10px auto 25px; "/>
    </div>
<?php
    }
?>