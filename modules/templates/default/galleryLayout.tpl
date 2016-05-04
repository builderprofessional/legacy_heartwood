<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>
<script type="text/javascript">

    function objectDropped(container)
    {
        var index = 0;
        var out = "";
        for( i=0; i < container.childNodes.length; i++)
        {
            if( typeof(container.childNodes[i].getAttribute) != "undefined" )
            {
                if( container.childNodes[i].getAttribute('dragable') == "dragable" )
                {
                    document.getElementById('sorder' + index++).value = container.childNodes[i].getAttribute('imgId');
                    out += "img[" + container.childNodes[i].getAttribute('imgId') + "].sorder = " + index + "\n";
                }
           }
        }
//        alert(out);
    }
    
    var imgUrls = [];
    function tb_valueSet(url)
    {
        var addUrl = true;
        var frm = document.getElementById('imgs_add');

        for( i = 0; i < imgUrls.length; i++ )
        {
            if( imgUrls[i] == url )
            {
                var delEl = document.getElementById(url);
                frm.removeChild(delEl);
                imgUrls.splice(i, 1);
                addUrl = false;
                break;
            }
        }
        
        if( addUrl )
        {
            imgUrls.push(url);
            var copyEl = document.getElementById('input_proto').cloneNode(false);
            copyEl.id = url;
            copyEl.value = url;
            frm.appendChild(copyEl);
        }
    }
    
    
    
    function tb_submit()
    {
        document.getElementById("imgs_add").submit();
    }
    
    function tb_cancel()
    {
        var frm = document.getElementById('imgs_add');
        
        for( i=0; i < imgUrls.length; i++ )
        {
            var el = document.getElementById(imgUrls[i]);
            frm.removeChild(el);
        }
        
        imgUrls = [];
        Shadowbox.close();
    }
    
    
    
    function saveDescriptions()
    {
        var inputs = document.getElementsByTagName("input");
        var postData = "";
        for( i=0; i<inputs.length; i++ )
        {
            if( inputs[i].getAttribute("descField") != null )
            {
                postData += inputs[i].name + "=" + inputs[i].value + "&";
            }
        }
        postData += 'catid=<?= $this->gallery->getActiveCategoryId() ?>&descsSubmit=true';
        
        http = ajaxConnection();
        
        http.open("POST", '<?= $this->gallery->getFormSubmitHref() ?>', true);

        //Send the proper header information along with the request
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", postData.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() 
        {//Call a function when the state changes.
            if(http.readyState == 4 )
            {
                if( http.status != 200) 
                    alert("Error Saving Data: Please Click the Save Button Again.");
                else
                    alert("Descriptions Saved");
            }
        }
        http.send(postData);

    }
    


//Browser Support Code
function ajaxConnection()
{
    var ajaxRequest;  // The variable that makes Ajax possible!
    
    try
    {
        // Opera 8.0+, Firefox, Safari
        ajaxRequest = new XMLHttpRequest();
    } 
    catch (e)
    {
        // Internet Explorer Browsers
        try
        {
            ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
        } 
        catch (e) 
        {
            try
            {
                ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
            } 
            catch (e)
            {
                // Something went wrong
                alert("Your browser broke!");
                return false;
            }
        }
    }
    return ajaxRequest;
}

</script>
<?php

    $doBackdoor = false;
    if( $this->user->inBackDoor() && $this->access >= 2 )
        $doBackdoor = true;
    
    $displayCat = null;

    echo '<link rel=StyleSheet type="text/css" href="' . $this->getFileHref('bsePhotoGallery.css') . '" media="screen" />
    ';
    if( $this->gallery->getActiveCategoryId() > 0 )
        $displayCat =& $this->gallery->categories->getItemById( $this->gallery->getActiveCategoryId() );
    



    $curPage = 1;
    if( isset($_GET['page']) )
    {
        $curPage = $_GET['page'];
    }
    $this->gallery->setCurrentPage($curPage);


    echo "
<div" . ( $doBackdoor ? ' style="border:solid 1px #000; "' : "" ) . ">
";
        
    if( $doBackdoor )
    {
        echo "<script type=\"text/javascript\" src=\"".$this->getFileHref('dragdrop.js')."\"></script>\n";
        $pics =& $displayCat->images;
    }
    else
    {
        $pics = 0;
        if( isset($displayCat) )
            $pics =& $displayCat->getImagesArray($curPage, $this->gallery->picsPerPage() );
    }



    $catEditCode = "";
    if( count($displayCat->images) > 0 || ($doBackdoor ) )
    {
        echo "<div class=\"pageNumDetail\">
        ";
        if( !$doBackdoor )
        {
            echo "
            <div style=\"float:left; margin-right:13px; font-weight:900; padding-top:2px; \">Go To Page:</div>";
            $maxPage = $this->gallery->numPages();
            for( $i=1; $i <= $maxPage; $i++ )
            {
                if( $this->gallery->currentPage() == $i )
                    echo "
                    <div class=\"selectedPageNum\">$i</div>";
                else
                {
                    $url = $this->removeArgFromURL("page", $this->retPage);
                    echo "
                    <a href=\"{$this->rootDir}$url" . ( strpos($url, '?') === false ? "?" : "&" ) ."page=$i\"><div class=\"normPageNum\">$i</div></a>";
                }
    
                if( $i != $this->gallery->numPages() )
                    echo "
                    <div style=\"float:left; width:10px; text-align:center; \">|</div>";
            }
        }
        else
        {
            $curCatId = $this->gallery->getActiveCategoryId();
            $catEditCode = <<< CATFRM
            <div style=" float:left; margin-right:10px; ">
                <form method="post" action="{$this->gallery->getFormSubmitHref()}">
                    <input type="hidden" name="catid" value="$curCatId" />
                    <input type="hidden" name="catAction" value="new" id="catActionInput" />
                    <label for="catName">Category Name</label> <input type="text" name="catName" value="" style="width:100px; " />
                    <input style="font-size:12px; " type="button" value="Delete" onmouseup="document.location.href='{$this->gallery->getFormSubmitHref()}?catid=$curCatId&delcat=true';" />
                    <input style="font-size:12px; " type="button" value="Rename" onmouseup="document.getElementById('catActionInput').value='rename';this.form.submit();" />
                    <input style="font-size:12px; " type="submit" value="Add" />
                </form>
            </div>
CATFRM;
        }

        echo "
        <div style=\"float:right; width:100%; \">{$catEditCode}<div style=\"float:right; \"><label for=\"catSelect\">Select a Category: </label><select id=\"categorySelect\" style=\"width:140px; \" name=\"catSelect\" onchange=\"document.location.href='./?catid=' + this.options[this.selectedIndex].value; \"><option value=\"-1\">Select Gallery Category</option>";
        foreach($this->gallery->categories as $cat)
        {
            if( @trim($cat->id) != "" )
            {
                $selected = "";
                if( $this->gallery->getActiveCategoryId() == $cat->id )
                   $selected = 'selected="selected"';

                $url = $this->removeArgFromUrl("catid", $this->retPage);
                echo "
                <option title=\"$cat->description\" value=\"{$cat->id}\"$selected>{$cat->name}</option>\n";
            }
        }
        echo "
        </select></div></div>
          </div>
          <form method=\"post\" action=\"".$this->gallery->getFormSubmitHref()."\">
          <input type=\"hidden\" name=\"catid\" value=\"{$displayCat->id}\" />
          <div class='DragContainer' id='DragContainer1' style=\"margin-top:5px; clear:both; position:relative; \">";
        $counter = 0;
        if( !isset($page) ) { $page = 1; }
        foreach( $pics as $galImage )
        {
            $picNumber = ( $counter + (($page - 1) * $this->gallery->picsPerPage()) );
            $imgSrc = $galImage->getPreviewImage($this->gallery->thumb_h, -1);
            $leftPos = round( ($this->gallery->thumb_w - $galImage->resizeW) / 2 );
            $sortCode = "";
            $picHeight = "height:{$this->gallery->thumb_h}px;";
            if( $doBackdoor )
            {
                if( $galImage->sorder >= 99 || $galImage->sorder == "" )
                {
                    $galImage->sorder = $picNumber;
                    $galImage->commit();
                }
                $href = "%s";
                $prevPos = $picNumber - 1;
                $nextPos = $picNumber + 1;
                $sortCode = "<span class='GalleryText'><input descField'true' id='imgDescriptions[{$galImage->id}]' onclick='this.focus(); this.select();' type='text' style='width:60%; height:15px; font-size:12px; ' name='imgDescriptions[{$galImage->id}]' value='{$galImage->caption}' /> <a href=\"" .$this->gallery->getImgManagerHref(false). "?dlink={$galImage->id}\">Del</a></span>";
                $picHeight = "height:". ($this->gallery->thumb_h + 35) . "px;";
                $galImage->sorder = $counter++;
                $galImage->commit();
            }
            else
            {
                $href="<a href=\"".$galImage->getPreviewImage(750, 900)."\" rel=\"shadowbox[gallery]\" title=\"{$galImage->caption}\">%s</a>";
            }
            $hidHref = $galImage->getImageHref();
            $imgDisplayCode = sprintf($href, "<img alt=\"{$galImage->caption}\" src=\"{$imgSrc}\" style=\"border:0; position:relative; left:{$leftPos}px; \" />");
//            if( $counter % $this->gallery->picsPerPage() == 1 )
//                echo "<div style=\"width:100%; clear:both; margin-bottom:25px; \"><div style=\"float:left; margin-right:5px;\">Page " . (floor($counter / $this->gallery->picsPerPage())+1) . "</div><hr style=\"width:90%; position:relative; top:7px; \" /></div>";
            echo "
            <div imgID=\"{$galImage->id}\" dragable=\"dragable\" class=\"detailGalleryImage\" style=\"width:{$this->gallery->thumb_w}px; $picHeight \" id=\"Image{$galImage->id}\"  overClass=\"OverDragBox\" dragClass=\"DragDragBox\">$imgDisplayCode<div style=\"width:100%; text-align:center; \">$sortCode</div></div>\n";
            echo "
            <input id=\"sorder{$picNumber}\" type=\"hidden\" name=\"sorder[$picNumber]\" value=\"{$galImage->id}\" />\n";
        }
        echo "
        <div class='clear'></div></div><div style=\"width:100%; clear:both; margin-bottom:10px;\"></div>\n";
        if( $doBackdoor )
            echo "
            <div style=\"width:99.5%; text-align:right; margin-bottom:5px; \"><input type=\"button\"" . ( isset($pics) ? ( $pics->count() == 0 ? ' disabled="disabled" title="You Must Select a Category First"' : "" ) : "" ) . " onmouseup='saveDescriptions();' style='padding:1px; ' value='Save Descriptions' /> <input type=\"button\"" . ( $this->gallery->getActiveCategoryId() <= 0 ? ' disabled="disabled" title="You Must Select a Category First"' : "" ) . " style=\"padding:1px; \" value=\"Add Images\" onmouseup=\"tinyBrowserPopUp('image','blank', '". urlencode($this->gallery->getMediaDirHref(false)) ."', true);\" /> <input type=\"submit\"" . ( isset($pics) ? ( $pics->count() == 0 ? ' disabled="disabled"' : "" ) : ' disabled="disabled"' ) . " name=\"gallerySorderSubmit\" value=\"Save Order\" style=\"padding:1px; \" /></div>";

        echo "
        </form>
";
    }
    else
    {
        echo "<div style=\"float:right; \">Select a Category: <select id=\"categorySelect\" onchange=\"document.location.href='./?catid=' + this.options[this.selectedIndex].value; \">";
        foreach($this->gallery->categories as $cat)
        {
            $selected = "";
            if( $this->gallery->getActiveCategoryId() == $cat->id )
               $selected = 'selected="selected"';

            echo "<option value=\"{$cat->id}\" $selected>{$cat->name}</option>\n";
        }
        echo "</select></div>\n";
        echo "<div style=\"width:100%; text-align:center; font-size:14px; font-weight:900; \">Gallery is Empty</div>\n";
    }
?>
    <input id="input_proto" type="hidden" name="imgUrls[]" value="" />
    <form id="imgs_add" method="post" action="<?= $this->gallery->getFormSubmitHref() ?>" onsubmit="return checkImages(); ">
        <input type="hidden" name="addImagesSubmit" value="true" />
        <input type="hidden" name="catid" value="<?= $displayCat->id ?>" />
    </form>
</div>