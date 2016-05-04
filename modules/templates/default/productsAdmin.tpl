<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>
<script language="javascript" type="text/javascript">
    function limitText(limitField, limitCount, limitNum)
    {
	    if (limitField.value.length > limitNum)
		{
		    limitField.value = limitField.value.substring(0, limitNum);
	    }
	    else
		{
			limitCount.innerHTML = limitNum - limitField.value.length;
		}
	}
</script>
    <div style="float:left; width:95%; margin-bottom:40px; ">
        <h2>Product Management</h2>
        <div style="width:100%; text-align:right; margin-bottom:15px; ">
            <select onchange="document.location.href='<?= $this->curPage . "?module=products&prodid=" ?>' + this.options[this.selectedIndex].value;">
                <option value="-1">Select an Edit Option</option>
                <option value="new"<?= ( @trim( $_REQUEST['prodid'] ) == "new" ? ' selected="selected"' : "" ) ?>>Add New</option>
<?php
    foreach( $this->products as $product )
    {
        echo "
                <option value=\"{$product->id}\"" . ( $product->id == @$_REQUEST['prodid'] ? ' selected="selected"' : "" ) . ">{$product->name}</option>";
    }
?>
            </select>
        </div>
        <form method="post" action="<?= $this->products->getAdminFormSubmitHref() ?>">
            <input type="hidden" name="pageid" value="1" />
            <input type="hidden" name="prodid" value="<?= ( isset($this->tmpProduct) ? $this->tmpProduct->id : "new" ) ?>" />
            <div style="float:left; width:52%; margin-right:5px; ">
                <div style="width:100%; ">
                    <div class="inputWrapper"> <div class="productAdminFormLabel">Name: </div><input type="text" name="name" value="<?= ( isset($this->tmpProduct) ? $this->tmpProduct->name : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="productAdminFormLabel">Price: </div><input type="text" name="price" value="<?= ( isset($this->tmpProduct) ? $this->tmpProduct->price : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="productAdminFormLabel">Category: </div>
<?php

    if( $this->moduleInstalled("bseProductCategories") )
    {
        echo '
                        <select name="category_id">
';
        foreach( $this->productCategories as $cat )
        {
            echo "
                            <option value=\"{$cat->id}\"" . ($this->tmpProduct->community_id == $cat->id && $cat->id != 0 ? ' selected="selected"' : "" ) . ">{$cat->name}</option>";
        }
?>
                            <option value="0">No Category</option>
                        </select>
<?php
    }  // End if moduleInstalled
    
    else
        echo "<input type='text' name='categoryName' value='{$this->tmpProduct->categoryName}' />
";
?>
                    </div>
                </div>
                <div style="width:100%; margin-top:15px; ">
                    <div class="inputWrapper tb_input"> <div class="productAdminFormLabel">Photo: </div><input  id="previewImage"type="text" name="image_file" value="<?= ( isset($this->tmpProduct) ? $this->tmpProduct->image_file : "" ) ?>" /><img style="margin-left:2px; cursor:pointer; " alt="Browse for file" title="Browse for File" src="<?= $this->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('image','previewImage', '<?= urlencode($this->tmpProduct->getMediaDirHref(false)) ?>');" /></div>
                    <div class="inputWrapper tb_input"> <div class="productAdminFormLabel">PDF: </div><input id="pdf_file" type="text" name="pdf_file" value="<?= ( isset($this->tmpProduct) ? $this->tmpProduct->pdf_file : "" ) ?>" /><img style="margin-left:2px; cursor:pointer; " alt="Browse for file" title="Browse for File" src="<?= $this->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('file','pdf_file', '<?= urlencode($this->tmpProduct->getMediaDirHref(false)) ?>');" /></div>
<!--                    <div class="inputWrapper"> <div class="productAdminFormLabel">Status: </div><input type="text" name="status" value="<?= ( isset($this->tmpProduct) ? $this->tmpProduct->status : "" ) ?>" /></div> -->
<!--                    <div class="inputWrapper" style="float:left; "> <div class="productAdminFormLabel">Featured Product: </div><input type="checkbox" style="margin-top:12px; " name="featured" value="1"<?= ( isset($this->tmpProduct) ? ( $this->tmpProduct->featured != 0 ? ' checked="checked"' : "" ) : "" ) ?> /></div>  -->
                    <div class="inputWrapper" style="clear:none; float:left; "> <div class="productAdminFormLabel">Displayed: </div><input type="checkbox" style="margin-top:5px; width:auto; " name="active" value="1"<?= ( isset($this->tmpProduct) ? ( $this->tmpProduct->active != 0 ? ' checked="checked"' : "" ) : "" ) ?> /></div>
<?php 
    if( $this->moduleInstalled("bseContact") ) {  ?>
                    <div class="inputWrapper"> <div class="productAdminFormLabel">Contact:</div>
                        <select name="contact_id">
                            <option value="0">No Contact Person</option>
<?php
    foreach($this->contacts as $contact)
    {
        echo "
                            <option value=\"{$contact->id}\"" . ($this->tmpProduct->contact_id == $contact->id && $contact->id != 0 ? ' selected="selected"' : "" ) . ">{$contact->name}</option>";
    }
?>
                        </select>
                    </div>
<?php } ?>
                </div>
                <div class="inputWrapper" style="height:auto; "> <div class="productAdminFormLabel" style="float:none; clear:both; width:100%; text-align:left; ">Short Description: (<span id="blurbLimitLbl">120</span> of 120 characters allowed remaining)</div><textarea name="blurb" style="width:98%; height:65px; " onKeyDown="limitText(this,document.getElementById('blurbLimitLbl'),120);" onKeyUp="limitText(this,document.getElementById('blurbLimitLbl'),120);"><?= ( isset($this->tmpProduct) ? $this->tmpProduct->pitch_blurb : "" ) ?></textarea></div>
            </div>
            <div style="float:right; width:45%; ">
                <div style="width:100%; ">
                    <div class="inputWrapper" style="height:auto; "> <div class="productAdminFormLabel" style="float:none; width:100%; text-align:left; ">Product Description: </div><textarea name="description" style="width:95%; height:220px; "><?= ( isset($this->tmpProduct) ? $this->tmpProduct->description : "" ) ?></textarea></div>
                	<div class="inputWrapper"> <div class="productAdminFormLabel">Number in Stock: </div><input type="text" name="stock" value="<?= ( isset($this->tmpProduct) ? $this->tmpProduct->stock : "" ) ?>" /></div>
                </div>
            </div>
            <div style="float:right; clear:both; ">
                <input type="button" value="New" onmouseup="document.location.href='<?= str_replace("&prodid=".$this->tmpProduct->id, "", $this->retPage) ?>';" /> <?php if( isset($this->tmpProduct) ) { ?> <input type="button" value="Delete" onmouseup="document.location.href='<?= $this->products->getAdminFormSubmitHref() ?>?delid=<?= $this->tmpProduct->id ?>';" /> <?php } ?> <input type="button" value="Cancel" onmouseup="document.location.href='<?= str_replace("&prodid=".$this->tmpProduct->id, "", $this->retPage) ?>';" /> <input type="submit" name="productEditSubmit" value="Save" />
            </div>
        </form>
        <div style="width:100%; clear;both; "></div>
    </div>
    
    <div style="float:left; width:95%; margin-bottom:40px; ">
    	<h3>Product Features</h3>
<?php 

	foreach( $this->tmpProduct->features as $feature )
	{
		$checked = "";
		if( $feature->isFeatured() )
		{
			$checked = ' checked="checked"';
		}
		
		echo <<< FEATURE
		<form method="post" action="{$this->products->getAdminFormSubmitHref()}">
			<input type="hidden" name="featureid" value="{$feature->id}" />
            <input type="hidden" name="prodid" value="{$this->tmpProduct->id}" />
		    <div style="float:left; width:400px;">
		    	<div class="inputWrapper">
			    	<div class="productAdminFormLabel">Feature:</div>
			    	<input type="text" name="text" value="{$feature->text}" maxlength="75" />
			    </div>
			</div>
			<div style="float:left; width:160px; margin-right:35px; ">
			    <div class="inputWrapper" style="clear:none; float:left; ">
			    	<div class="productAdminFormLabel" style="width:80%; ">In Product List:</div>
			    	<input type="checkbox" style="margin-top:5px; width:auto; " name="featured" value="1"$checked />
			    </div>
			</div>
			<div style="float:left; width:180px; ">
				<input type="submit" name="featureUpdateSubmit" value="Save" style="width:80px; " />
				<input type="button" value="Delete" style="width:80px; " onmouseup="document.location.href='{$this->products->getAdminFormSubmitHref()}?featureDelId={$feature->id}&prodid={$this->tmpProduct->id}';" />
			</div>
		</form>
FEATURE;
	}

	echo <<< NEWF
		<form method="post" action="{$this->products->getAdminFormSubmitHref()}">
			<input type="hidden" name="featureid" value="new" />
            <input type="hidden" name="prodid" value="{$this->tmpProduct->id}" />
		    <div style="float:left; width:400px;">
		    	<div class="inputWrapper">
			    	<div class="productAdminFormLabel">Feature:</div>
			    	<input type="text" name="text" value="" maxlength="75" />
			    </div>
			</div>
			<div style="float:left; width:160px; margin-right:35px; ">
			    <div class="inputWrapper" style="clear:none; float:left; ">
			    	<div class="productAdminFormLabel" style="width:80%; ">In Product List:</div>
			    	<input type="checkbox" style="margin-top:5px; width:auto; " name="featured" value="1" />
			    </div>
			</div>
			<div style="float:left; width:180px; ">
				<input type="submit" name="featureUpdateSubmit" value="Add" style="width:80px; " />
				<input type="reset" value="Reset" style="width:80px; " />
			</div>
		</form>
NEWF;
?>
    </div>

<!--  sorder  -->        
<!--
    <div style="float:right; width:28%; border-left:solid 1px; ">
        <div style="font-size:larger; width:100%; text-align:center; ">Arrange Display Order</div>
        <div style="float:left; margin-top:5px; ">Select a Community</div>
        <div>
            <select name="community_id" style="width:210px; " onchange="">
<?php
    foreach( $this->productCategories as $cat )
    {
        echo "
                <option value=\"{$cat->id}\"" . ($this->tmpProduct->community_id == $cat->id && $cat->id != 0 ? ' selected="selected"' : "" ) . ">{$cat->name}</option>";
    }
?>
                <option value="0">No Community</option>
            </select>
        </div>
    </div>
-->

<?php






    ///////////////   Photo Gallery Management Code    ////////////////////////


    if( $this->moduleInstalled("bsePhotoGallery") )  
    {
    
        echo <<< GAL
            <div class="clear"></div>
            <div style="margin-top:65px; ">
                <div class="adminSubHeading">Product Photo Gallery</div>
GAL;

        if( !$this->tmpProduct->hasGallery() )
        {
            echo <<< GAL
                <div style="width:100%; text-align:center; margin-bottom:20px; ">
                    <form method="post" action="{$this->products->getAdminFormSubmitHref()}">
                        <input type="hidden" name="prodid" value="{$this->tmpProduct->id}" />
                        <input type="hidden" name="productAddGallery" value="1" />
                        <input type="submit" value="Add Photo Gallery to This Product" />
                    </form>
                </div>
GAL;
        }
        else
        {
            $this->access = 2;
            $this->gallery = $this->getModule("bsePhotoGallery");
            $this->gallery->setGalleryId($this->tmpProduct->gallery_id);
            
            if( isset($_GET['catid']) )
            {
                if( trim($_GET['catid']) != "" )
                     $catid = $_GET['catid'];
            }
    
            if( !isset($catid) )
            {
                $query = $this->db->getQueryResult("SELECT * FROM `{$this->gallery->categories->getTable()}` WHERE `galid` = '{$this->gallery->id}' ORDER BY `sorder` ASC");
                if( mysql_num_rows($query) > 0 )
                {
                    $data = mysql_fetch_array($query);
                    $catid = $data['id'];
                }
                else
                    $catid = -1;
            }

            $this->gallery->setCurrentCategory($catid);

            $this->display("galleryLayout.tpl");
        }
    echo "
            </div>";

    }    /* End if( moduleInstalled("bsePhotoGallery") ) */     

?>