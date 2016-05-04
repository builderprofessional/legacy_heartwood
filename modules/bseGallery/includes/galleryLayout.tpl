<script type="text/javascript">

    function objectDropped(container)
    {
        var index = 0;
        for( i=0; i < container.childNodes.length; i++)
        {
            if( typeof(container.childNodes[i].getAttribute) != "undefined" )
            {
                if( container.childNodes[i].getAttribute('dragable') == "dragable" )
                {
                    document.getElementById('sorder' + index++).value = container.childNodes[i].getAttribute('imgID');
                }
           }
        }
    }

</script>
<?php

    echo getGalleryStyleLink($this->rootDir);

    $curPage = 1;
    if( isset($_GET['page']) )
        $curPage = $_GET['page'];
        
    $gallery = createGalleryObject($this->rootDir, $this->curCat->id);

    if( $this->user->loggedIn && $this->user->backdoor )
    {
        echo "<script type=\"text/javascript\" src=\"".$this->rootDir."modules/includes/dragdrop.js\"></script>";
        $pics = $gallery->getAllImagesArray();
        echo "<div style=\"width:95%; margin:auto; clear:both; font-weight:900; \">Click an Image Below to edit it, or <a href=\"".getImgManagerHref($this->rootDir)."\">Click Here to Manage the Gallery</a></div>";
    }
    else
        $pics = $gallery->getImagesArray($curPage);


    if( $gallery->numPics() > 0 || ($this->user->loggedIn && $this->user->backdoor) )
    {
        echo "<div class=\"pageNumDetail\">";
        if( !$this->user->loggedIn && !$this->user->backdoor )
        {
            echo "<div style=\"float:left; margin-right:13px; font-weight:900; padding-top:2px; \">Go To Page:</div>";
            $maxPage = $gallery->numPages();
            for( $i=1; $i <= $maxPage; $i++ )
            {
                if( $gallery->currentPage() == $i )
                    echo "<div class=\"selectedPageNum\">$i</div>";
                else
                    echo "<a href=\"./?catID={$this->curCat->id}&gal=y&page=$i\"><div class=\"normPageNum\">$i</div></a>";
    
                if( $i != $gallery->numPages() )
                    echo "<div style=\"float:left; width:10px; text-align:center; \">|</div>";
            }
        }

        $catsAry = $this->catsCol->getCatsArray();
        echo "<div style=\"float:right; \"><select id=\"categorySelect\" onchange=\"document.location.href=document.getElementById('categorySelect').options[document.getElementById('categorySelect').selectedIndex].value; \">";
        foreach($catsAry as $cat)
        {
            $selected = "";
            if( $this->curCat->id == $cat->id )
               $selected = 'selected="selected"';

            echo "<option title=\"$cat->description\" value=\"./?catID={$cat->id}\" $selected>{$cat->name}</option>\n";
        }
        echo "</select></div>
          </div>
          <form method=\"post\" action=\"".$gallery->getFormSubmitHref()."\">
          <input type=\"hidden\" name=\"catid\" value=\"{$this->curCat->id}\" />
          <div class='DragContainer' id='DragContainer1' style=\"margin-top:5px; clear:both; position:relative; \">";
        $counter = 0;
        if( !isset($page) ) { $page = 1; }
        foreach( $pics as $galImage )
        {
            $picNumber = ( $counter + (($page - 1) * $gallery->picsPerPage()) );
            $imgSrc = $galImage->getPreviewImage(100, -1);
            $leftPos = (150 - $galImage->resizeW) / 2;
            $sortCode = "";
            $adminHeight = "";
            if( $this->user->loggedIn && $this->user->backdoor )
            {
                if( $galImage->sorder >= 100 || $galImage->sorder == "" )
                    $galImage->setValue("sorder", $picNumber);
                $href = "%s";
                $prevPos = $picNumber - 1;
                $nextPos = $picNumber + 1;
                $sortCode = "<span class='GalleryText'><a href=\"".getImgManagerHref($this->rootDir)."?id={$galImage->id}"."\">Edit</a> | <a href=\"" .getImgManagerHref($this->rootDir). "?dlink={$galImage->id}&page=portfolio/?catID={$this->curCat->id}\">Del</a></span>";
                $adminHeight = ' style="height:120px;"';
                $galImage->setValue("sorder", $counter++);
            }
            else
            {
                $href="<a href=\"".$galImage->getPreviewImage(750, 900)."\" rel=\"lightbox\">%s</a>";
            }
            $hidHref = $galImage->getImageHref();
            $imgDisplayCode = sprintf($href, "<img alt=\"{$galImage->caption}\" title=\"{$galImage->caption}\" src=\"{$imgSrc}\" style=\"border:0; position:relative; left:{$leftPos}px; \" />");
//            if( $counter % $gallery->picsPerPage() == 1 )
//                echo "<div style=\"width:100%; clear:both; margin-bottom:25px; \"><div style=\"float:left; margin-right:5px;\">Page " . (floor($counter / $gallery->picsPerPage())+1) . "</div><hr style=\"width:90%; position:relative; top:7px; \" /></div>";
            echo "<div imgID=\"{$galImage->id}\" dragable=\"dragable\" class=\"detailGalleryImage\" id=\"Image{$galImage->id}\"  overClass=\"OverDragBox\" dragClass=\"DragDragBox\"$adminHeight>$imgDisplayCode<div style=\"width:100%; text-align:center; \">$sortCode</div></div>\n";
            echo "<input id=\"sorder{$picNumber}\" type=\"hidden\" name=\"sorder[$picNumber]\" value=\"{$galImage->id}\" />\n";
        }
        echo "</div><div style=\"width:100%; clear:both; margin-bottom:10px;\"></div>\n";
        if( $this->user->loggedIn && $this->user->backdoor )
            echo "<div style=\"width:100%; text-align:right; \"><input type=\"submit\" name=\"gallerySorderSubmit\" value=\"Save\" style=\"width:80px; \" /></div>";

        echo "</form>
";
    }
    else
    {
        $catsAry = $this->catsCol->getCatsArray();
        echo "<div style=\"float:right; \"><select id=\"categorySelect\" onchange=\"document.location.href=document.getElementById('categorySelect').options[document.getElementById('categorySelect').selectedIndex].value; \">";
        foreach($catsAry as $cat)
        {
            $selected = "";
            if( $this->curCat->id == $cat->id )
               $selected = 'selected="selected"';

            echo "<option value=\"./?catID={$cat->id}\" $selected>{$cat->name}</option>\n";
        }
        echo "</select></div>\n";
        echo "<div style=\"width:100%; text-align:center; font-size:14px; font-weight:900; \">Gallery is Empty</div>";
    }
?>