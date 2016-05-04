<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>
    <div style="float:left; width:80%; ">
        <div style="width:100%; text-align:right; margin-bottom:15px; ">
            <select onchange="document.location.href='<?= $this->curPage . "?module=homes&homeid=" ?>' + this.options[this.selectedIndex].value;">
                <option value="-1">Select an Edit Option</option>
                <option value="new"<?= ( @trim( $_REQUEST['homeid'] ) == "new" ? ' selected="selected"' : "" ) ?>>Add New</option>
<?php
    foreach( $this->homesInfo as $home )
    {
        echo "
                <option value=\"{$home->id}\"" . ( $home->id == @$_REQUEST['homeid'] ? ' selected="selected"' : "" ) . ">{$home->addr}</option>";
    }
?>
            </select>
        </div>
        <form method="post" action="<?= $this->homesInfo->getAdminFormSubmitHref() ?>">
            <input type="hidden" name="pageid" value="1" />
            <input type="hidden" name="homeid" value="<?= ( isset($this->selHome) ? $this->selHome->id : "new" ) ?>" />
            <div style="float:left; width:52%; margin-right:5px; ">
                <div style="width:100%; ">
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Address: </div><input type="text" name="addr" value="<?= ( isset($this->selHome) ? $this->selHome->addr : "" ) ?>" /> </div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">City: </div><input type="text" name="city" value="<?= ( isset($this->selHome) ? $this->selHome->city : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">State: </div><input type="text" name="state" value="<?= ( isset($this->selHome) ? $this->selHome->state : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Zip: </div><input type="text" name="zip" value="<?= ( isset($this->selHome) ? $this->selHome->zip : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Price: </div><input type="text" name="price" value="<?= ( isset($this->selHome) ? $this->selHome->price : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Community Lot: </div><input type="text" name="lot" value="<?= ( isset($this->selHome) ? $this->selHome->lot : "" ) ?>" /> </div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Community: </div>
<?php

    if( $this->moduleInstalled("bseCommunitiesCollection") )
    {
        echo '
                        <select name="community_id">
';
        foreach($this->communities as $comm)
        {
            echo "
                            <option value=\"{$comm->id}\"" . ($this->selHome->community_id == $comm->id && $comm->id != 0 ? ' selected="selected"' : "" ) . ">{$comm->name}</option>";
        }
?>
                            <option value="0">No Community</option>
                        </select>
<?php
    }  // End if moduleInstalled
    
    else
        echo "<input type='text' name='communityName' value='{$this->selHome->communityName}' />
";
?>
                    </div>
                </div>
                <div style="width:100%; margin-top:15px; ">
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Lot Size: </div><input type="text" name="lotsize" value="<?= ( isset($this->selHome) ? $this->selHome->lotsize : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Acres: </div><input type="text" name="acres" value="<?= ( isset($this->selHome) ? $this->selHome->acres : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">MLS: </div><input type="text" name="mls" value="<?= ( isset($this->selHome) ? $this->selHome->mls : "" ) ?>" /></div>
                    <div class="inputWrapper tb_input"> <div class="homeAdminFormLabel">Preview Photo: </div><input  id="previewImage"type="text" name="image_file" value="<?= ( isset($this->selHome) ? $this->selHome->image_file : "" ) ?>" /><img style="margin-left:2px; cursor:pointer; " alt="Browse for file" title="Browse for File" src="<?= $this->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('image','previewImage', '<?= urlencode($this->selHome->getMediaDirHref(false)) ?>');" /></div>
                    <div class="inputWrapper tb_input"> <div class="homeAdminFormLabel">Floor Plan PDF: </div><input id="fp_pdf" type="text" name="fp_pdf" value="<?= ( isset($this->selHome) ? $this->selHome->fp_pdf : "" ) ?>" /><img style="margin-left:2px; cursor:pointer; " alt="Browse for file" title="Browse for File" src="<?= $this->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('file','fp_pdf', '<?= urlencode($this->selHome->getMediaDirHref(false)) ?>');" /></div>
                    <div class="inputWrapper tb_input"> <div class="homeAdminFormLabel">Floor Plan JPG: </div><input id="fp_jpg" type="text" name="fp_jpg" value="<?= ( isset($this->selHome) ? $this->selHome->fp_jpg : "" ) ?>" /><img style="margin-left:2px; cursor:pointer; " alt="Browse for file" title="Browse for File" src="<?= $this->rootDir ?>iface/browse_btn.png" onmouseup="tinyBrowserPopUp('image','fp_jpg', '<?= urlencode($this->selHome->getMediaDirHref(false)) ?>');" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Status: </div><input type="text" name="status" value="<?= ( isset($this->selHome) ? $this->selHome->status : "" ) ?>" /></div>
<!--                    <div class="inputWrapper" style="float:left; "> <div class="homeAdminFormLabel">Featured Home: </div><input type="checkbox" style="margin-top:12px; " name="featured" value="1"<?= ( isset($this->selHome) ? ( $this->selHome->featured != 0 ? ' checked="checked"' : "" ) : "" ) ?> /></div>  -->
                    <div class="inputWrapper" style="clear:none; float:left; "> <div class="homeAdminFormLabel">Displayed: </div><input type="checkbox" style="margin-top:5px; " name="active" value="1"<?= ( isset($this->selHome) ? ( $this->selHome->active != 0 ? ' checked="checked"' : "" ) : "" ) ?> /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Contact:</div>
                        <select name="contact_id">
                            <option value="0">No Contact Person</option>
<?php
    foreach($this->contacts as $contact)
    {
        echo "
                            <option value=\"{$contact->id}\"" . ($this->selHome->contact_id == $contact->id && $contact->id != 0 ? ' selected="selected"' : "" ) . ">{$contact->name}</option>";
    }
?>
                        </select>
                    </div>
                </div>
            </div>
            <div style="float:right; width:45%; ">
                <div style="width:100%; ">
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Beds: </div><input type="text" name="beds" value="<?= ( isset($this->selHome) ? $this->selHome->beds : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Baths: </div><input type="text" name="baths" value="<?= ( isset($this->selHome) ? $this->selHome->baths : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Partial Baths: </div><input type="text" name="partbaths" value="<?= ( isset($this->selHome) ? $this->selHome->partbaths : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Floors: </div><input type="text" name="floors" value="<?= ( isset($this->selHome) ? $this->selHome->floors : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Garage: </div><input type="text" name="garage" value="<?= ( isset($this->selHome) ? $this->selHome->garage : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Sq. Ft.: </div><input type="text" name="sqft" value="<?= ( isset($this->selHome) ? $this->selHome->sqft : "" ) ?>" /></div>
                    <div class="inputWrapper"> <div class="homeAdminFormLabel">Year Built: </div><input type="text" name="yr_built" value="<?= ( isset($this->selHome) ? $this->selHome->yr_built : "" ) ?>" /></div>
                </div>
                <div style="width:100%; ">
                    <div class="inputWrapper" style="height:auto; "> <div class="homeAdminFormLabel" style="float:none; width:100%; text-align:left; ">Home Description: </div><textarea name="description" style="width:100%; height:220px; "><?= ( isset($this->selHome) ? $this->selHome->description : "" ) ?></textarea></div>
                </div>
            </div>
            <div style="float:right; clear:both; ">
                <input type="button" value="New" onmouseup="document.location.href='<?= str_replace("&homeid=".$this->selHome->id, "", $this->retPage) ?>';" /> <?php if( isset($this->selHome) ) { ?> <input type="button" value="Delete" onmouseup="document.location.href='<?= $this->homesInfo->getAdminFormSubmitHref() ?>?delid=<?= $this->selHome->id ?>';" /> <?php } ?> <input type="button" value="Cancel" onmouseup="document.location.href='<?= str_replace("&homeid=".$this->selHome->id, "", $this->retPage) ?>';" /> <input type="submit" name="homeEditSubmit" value="Save" />
            </div>
        </form>
        <div style="width:100%; clear;both; "></div>
    </div>


<!--  sorder  -->        
<!--
    <div style="float:right; width:235px; border-left:solid 1px; ">
        <div style="font-size:larger; width:100%; text-align:center; ">Arrange Display Order</div>
        <div style="float:left; margin-top:5px; ">Select a Community</div>
        <div>
            <select name="community_id" style="width:210px; " onchange="">
<?php
    foreach($this->communities as $comm)
    {
        echo "
                <option value=\"{$comm->id}\"" . ($this->selHome->community_id == $comm->id && $comm->id != 0 ? ' selected="selected"' : "" ) . ">{$comm->name}</option>";
    }
?>
                <option value="0">No Community</option>
            </select>
        </div>
    </div>
-->

<?php






    ///////////////   Photo Gallery Management Code    ////////////////////////


    if( isset($this->selHome) && !$this->fakeHome && $this->moduleInstalled("bsePhotoGallery") )  
    {
    
        echo <<< GAL
            <div class="clear"></div>
            <div style="margin-top:65px; ">
                <div class="adminSubHeading">Home Photo Gallery</div>
GAL;

        if( !$this->selHome->hasGallery() )
        {
            echo <<< GAL
                <div style="width:100%; text-align:center; margin-bottom:20px; ">
                    <form method="post" action="{$this->homesInfo->getAdminFormSubmitHref()}">
                        <input type="hidden" name="homeid" value="{$this->selHome->id}" />
                        <input type="hidden" name="homeAddGallery" value="1" />
                        <input type="submit" value="Add Photo Gallery to This Home" />
                    </form>
                </div>
GAL;
        }
        else
        {
            $this->access = 2;
            $this->gallery = $this->getModule("bsePhotoGallery");
            $this->gallery->setGalleryId($this->selHome->gallery_id);
            
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