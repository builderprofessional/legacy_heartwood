<?php
    echo $this->products->getStyleLinkCode();

/*
    if( $this->moduleInstalled("bseCommunitiesCollection") )
    {
        $cats = $this->getModule("bseCommunitiesCollection");
        $cats->setAllCommunitiesList();
        
        echo '<div style="width:100%; text-align:right; ">Select a Community to view homes only in that community: ';
        $this->retPage = $this->removeArgFromURL("commid", $this->retPage);
        echo "<select onchange=\"document.location.href='{$this->rootDir}{$this->retPage}" . ( strpos($this->retPage, "?") === false ? "?" : "&" ) . "commid=' + this.options[this.selectedIndex].value;\"><option value=\"\">Filter by Community</option><option value=\"-1\">All Communities</option>";
        foreach( $cats as $cat )
        {
            $sel = "";
            if( @$_GET['commid'] == $cat->id )
                $sel = ' selected="selected"';
            echo "
            <option value=\"{$cat->id}\"$sel>{$cat->name}</option>";
        }
        echo "<option value=\"0\">Unspecified Community</option></select></div>";
    }

*/


    foreach($this->products as $product)
    {
        if( $product->active <= 0 ) continue;
        $img = $product->getResizedImage(114, -1);
        $cat = null;
        
        if( $product->category_id > 0 )
        {
            $cat =& $this->getModule("bseProductCategory");
            if( trim($cat->id) == "" ||  $cat->id != $product->category_id )
            {
                $cat->setId($product->category_id);
            }
        }
        
        
        if( !$this->moduleInstalled("bseProductCategories") && $product->categoryName != "" )
        {
            $cat = new stdClass();
            $cat->name = $product->categoryName;
        }
        
        $priceCode = "%s";
        $leftPos = (110 - $product->resizeW) / 2;
        $imgCode = "<img src=\"{$img}\" style=\"width:{$product->resizeW}px; height:{$product->resizeH}px; position:relative; left:={$leftPos}px; border:0; \" />";
        
        if( $img == "" )
        {
            $imgCode = '<div style="width:100%; height:100%; text-align:center; font-size:18px; font-weight:900; "><span style="position:relative; top:30px; ">Coming<br />Soon</span></div>';
        }
        
?>
    <div class="productContainer">
        <div class="productImage">
            <a href="view_product.php?prodid=<?= $product->id ?>"><?= $imgCode ?></a>
            <div class="clear"></div>
        </div>
        <div class="productInfo">
            <div class="detailsLink"><a class="detailsLink" href="view_product.php?prodid=<?= $product->id ?>"><?= $product->name ?></a></div>
<?php 
		if( $this->moduleInstalled("bseProductFeatures") )
		{
			$features = $product->features->getFeaturedItemsCol();
			if( $features->count() > 0 )
			{
				echo '
			<div class="productFeatures">
	            <ul>';
				
				foreach( $features as $feature )
				{
					echo "
					<li>{$feature->text}</li>";
				}
				
				echo '
				</ul>
			</div>
';
			}
		}	

		echo "<span style=\"position:relative; top:12px; left:6px; \">" . ( @trim( $product->pitch_blurb ) == "" ? substr($product->description, 0, 127) . "..." : $product->pitch_blurb ) . "</span>";
		echo "</div>
";
		

		
		echo '<div style="float:right; width:20%; text-align:right; ">
';

		if( $this->products->usePricing )
		{
    	    if( @trim( $product->price ) != "" && @trim( $product->price ) != "0" )
    	    {
    	        echo "<div class=\"price\">$" . $product->getPrice(true) . "</div>";
    	    }
    	    else
    	    {
    	    	echo "Pricing Not Available";
    	    }
		}	    
        
        if( @trim( $product->stock ) != "" && $this->products->useStock )
        {
	        $img = $this->rootDir . $product->storeDir . "iface/instock.png";
            $stock = $product->stock . " In Stock";

            if( $product->stock == 0 )
            {
                $img = $this->rootDir . $product->storeDir . "iface/nostock.png";
                $stock = "Out of Stock";
            }
		    
	        echo "<div><img style=\"width:25px; position:relative; top:5px; \" src=\"$img\" /> $stock</div>";

        }
	    echo '
		</div>
        <div class="clear"></div>
    </div>
    
';

	}
?>