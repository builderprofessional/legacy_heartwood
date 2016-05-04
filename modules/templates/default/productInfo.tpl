


<!-- Begin productInfo.tpl -->


<?php
    echo $this->products->getStyleLinkCode();
?>

    <?= $this->pageContent ?>
    <h1><?= ( @trim( $this->pageTitle ) == "" ? "Product Details: " : $this->pageTitle ) . $this->product->name ?></h1>
    


<!--  //////////////////////////////////         product Navigation          /////////////////////////////   -->

        <a href="./">
            <div class="productDetailTabLink productDetailTabLinkHover" style="margin-left:0px; ">
                <span style="position:relative; top:3px; ">Listings</span>
            </div>
        </a>
        <a href="./product.php?productid=<?= $this->product->id ?>"<?= ($this->productDetailLink == "description" ? " style=\"position:relative; z-index:2; \" onclick='return false;'" : "" ) ?>>
            <div class="productDetailTabLink<?= ($this->productDetailLink == "description" ? "\" style=\"background-image:url('{$this->rootDir}iface/tab_down.png'); color:#444; \"" : " productDetailTabLinkHover\"" ) ?>>
                <span style="position:relative; top:3px; ">Description</span>
            </div>
        </a>
<?php if( $this->product->hasGallery() )
      {   ?>
<!--
        <a href="./gallery.php?productid=<?= $this->product->id ?>"<?= ($this->productDetailLink == "gallery" ? " style=\"position:relative; z-index:2; \" onclick='return false;'" : "" ) ?>>
            <div class="productDetailTabLink<?= ($this->productDetailLink == "gallery" ? "\" style=\"background-image:url('{$this->rootDir}iface/tab_down.png'); color:#444; \"" : " productDetailTabLinkHover\"" ) ?>>
                <span style="position:relative; top:3px; ">Gallery</span>
            </div>
        </a>
-->
<?php  }
/*      if( $this->product->hasFloorplan() )
      {   ?>
        <a href="<?= $this->product->getFloorplanHref() ?>"<?= ($this->productDetailLink == "floorplan" ? " style=\"position:relative; z-index:2; \" onclick='return false;'" : "" ) ?>>
            <div class="productDetailTabLink<?= ($this->productDetailLink == "floorplan" ? "\" style=\"background-image:url('{$this->rootDir}iface/tab_down.png'); color:#444; \"" : " productDetailTabLinkHover\"" ) ?>>
                <span style="position:relative; top:3px; ">Floorplan</span>
            </div>
        </a>
<?php  }  ?>
*/
?>
        <div class="clear"></div>





        <div id="product_wrapper" style="clear:both; border:solid 2px #884406; position:relative; top:-2px; background-image:url('<?= $this->rootDir ?>iface/folder-bg.png'); z-index:1; overflow:hidden; ">
            <div style="position:absolute; left:0px; top:0px; right:0px; height:600px; background-image:url('<?= $this->product->getDetailGradientHref() ?>'); background-repeat:repeat-x; z-index:-1;"></div>
            <div style="width:100%; margin-top:10px; margin-left:4px; ">
                <div class="productDetailCell" style="width:20%; margin-right:10px; text-align:right; padding:0; ">
<?php
                    if( @trim( $this->product->price ) != "" && $this->products->usePricing )
                        echo "
                    <div class=\"price\" style=\"margin:0; \">$". $this->product->getPrice(true) . "</div>";

                    if( $this->products->useStock )
                    {
                        $img = $this->rootDir . $this->product->storeDir . "iface/instock.png";
                        $stock = $this->product->stock . " In Stock";
    
                        if( $this->product->stock == 0 )
                        {
                            $img = $this->rootDir . $this->product->storeDir . "iface/nostock.png";
                            $stock = "Out of Stock";
                        }
                        
                        echo "
                        <div style=\"margin-bottom:17px; \"><img style=\"width:25px; \" src=\"$img\" /><span style=\"position:relative; top:-3px; \">$stock</span></div>";
                    }
                    echo "
                    <a href=\"mailto:{$this->prodContact->email}\"><span class=\"price\" style=\"font-size:13px; font-weight:400; text-decoration:underline; \">Email Us</span></a><br />";
                    if( $this->product->pdf_file != "" )
                    {
                        if( file_exists( $this->product->getMediaDirHref() . "/" . $this->product->pdf_file ) )
                        {
                            $pdf = $this->product->getMediaDirHref() . "/" . $this->product->pdf_file;
                            echo "
                    <a href=\"$pdf\" target=\"_blank\"><span class=\"price\" style=\"font-size:13px; font-weight:400; text-decoration:underline; \">Product Info</span></a><br />";
                        }
                    }
                    echo $this->product->getFormatedValue("status", "Status");
                                
                                
                    $img = $this->product->getResizedImage(-1, 430);
                    $imgCode = "<img src=\"{$img}\" style=\"width:100%; height:auto; border:solid 2px #FFF; \" />";
                    
                    if( $img == "" || !file_exists($img) )
                    {
                        $imgCode = '<div style="width:100%; height:200px; text-align:center; font-size:26px; font-weight:900; border:solid 2px #FFF; "><span style="position:relative; top:45px; ">Image<br />Coming<br />Soon</span></div>';
                    }

?>
                </div>

                <div style="float:left; margin:0px 16px 10px 5px; width:40%; ">
                    <a href="<?=$this->product->getImageHref()?>" rel="shadowbox"><?= $imgCode ?></a>
                    <div class="clear"></div>
                </div>
                
                <div style="float:left; clear:left; margin:0px 10px 10px 5px; width:40%; ">
<?php 
                if( $this->moduleInstalled("bseProductFeatures") )
                {
                    if( $this->product->features->count() > 0 )
                    {
                        echo '
                    <div class="productFeatures" style="width:105%; margin-left:-10px; ">
                        <ul>';
                        
                        foreach( $this->product->features as $feature )
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
?>

                </div>

                <p style="width:78%; margin:0px 10px; font-size:17px; "><?= nl2br($this->product->description) ?></p>

            </div>
            <div class="clear"></div>

            <div style="margin-top:10px; margin-left:4px; padding:10px; padding-top:16px; font-size:14px; clear:both; ">
                <?php $this->display("galleryLayout.tpl"); ?>
                <div class="clear"></div>
            </div>

        </div id="product_wrapper">


<!-- End productInfo.tpl -->

