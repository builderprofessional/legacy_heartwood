<script type="text/javascript" src="<?= $this->getFileHref("dragdrop.js") ?>"></script>
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
                    document.getElementById('sorder' + index++).value = container.childNodes[i].getAttribute('itemId');
                    out += "img[" + container.childNodes[i].getAttribute('itemId') + "].sorder = " + index + "\n";
                }
           }
        }
//        alert(out);
    }

</script>

    <h2>Sitemap Admin</h2>

<?php

    echo '
    <div style="width:100%; text-align:center; font-weight:900; font-size:16px; ">Pages on This Site</div>
    <div id="content">
        <div style="float:left; width:30%; font-weight:900; ">URL</div><div style="float:left; width:20%; font-weight:900; margin-left:5px; ">Title</div><div style="float:left; font-weight:900; margin-left:5px; ">Description</div><div class="clear"></div>
';



// Site map object output

/*    echo "
    <form method=\"post\" action=\"".$this->sitemap->getAdminSubmitHref()."\">
    <div class='DragContainer' id='DragContainer1' style=\"margin-top:5px; clear:both; position:relative; \">";
*/
        $counter = 0;
        foreach( $this->sitemap as $sitemapItem )
        {
            $sortCode = "";
            if( $sitemapItem->sorder >= 99 || $sitemapItem->sorder == "" )
            {
                $sitemapItem->sorder = $counter;
                $sitemapItem->commit();
            }

        echo "
      <div itemID=\"{$sitemapItem->id}\" dragable=\"dragable\" class=\"detailGalleryImage\" id=\"Image{$sitemapItem->id}\"  overClass=\"OverDragBox\" dragClass=\"DragDragBox\">
        <input id=\"sorder{$counter}\" type=\"hidden\" name=\"sorder[$counter]\" value=\"{$sitemapItem->id}\" />
        <form id=\"sitemapSave_{$sitemapItem->id}\" method=\"post\" action=\"{$this->sitemap->getAdminSubmitHref()}\">
            <input type='hidden' name='sitemapSave' value='yes' />
            <input type='hidden' name='sm_id' value='{$sitemapItem->id}' />
            <input type='input' onclick='if( !this.hasFocus ) {this.focus(); this.select(); this.hasFocus = true; } ' name='sm_url' value=\"{$sitemapItem->url}\" style='float:left; width:30%; ' />
            <input type='input' onclick='if( !this.hasFocus ) {this.focus(); this.select(); this.hasFocus = true; } ' name='sm_title' value=\"{$sitemapItem->title}\" style='float:left; width:20%; ' />
            <input type='input' onclick='if( !this.hasFocus ) {this.focus(); this.select(); this.hasFocus = true; } ' name='sm_desc' value=\"{$sitemapItem->description}\" style='float:left; width:42%; ' />
            <a href='{$this->sitemap->getAdminSubmitHref()}?delid={$sitemapItem->id}'><img src='{$this->rootDir}iface/delete.png' style='border:0; width:20px; float:left; ' title='Delete Page' /></a>
            <img src='{$this->rootDir}iface/submit.png' style='float:left; width:20px; cursor:pointer; ' onmouseup=\"document.getElementById('sitemapSave_{$sitemapItem->id}').submit();\" title='Save Changes' />
        </form>
        <div class='clear'></div>
      </div>
";

      $counter++;
    }

/*    echo "
      <div class='clear'></div>
    </div id='DragContainer'>
    <div style=\"width:99.5%; text-align:right; margin-top:15px; \"><input type=\"submit\" title=\"Drag and Drop the pages listed above to arrange their order on the sitemap page, then click here\" name=\"sitemapSorderSubmit\" value=\"Save Order\" style=\"padding:1px; \" /></div>
    </form>
";
*/
echo "
        <div class=\"clear\"></div>
        <div style=\"width:100%; text-align:center; font-weight:900; font-size:16px; margin-top:20px; \">Add New Page to Sitemap</div>
        <form id=\"sitemapAdd\" method=\"post\" action=\"{$this->sitemap->getAdminSubmitHref()}\">
            <input type='hidden' name='sitemapAdd' value='yes' />
            <input type='hidden' name='sm_id' value='new' />
            <input type='input' name='sm_url' style='float:left; width:30%; ' />
            <input type='input' name='sm_title' style='float:left; width:20%; ' />
            <input type='input' name='sm_desc' style='float:left; width:42%; ' />
            <img src='{$this->rootDir}iface/submit.png' style='float:left; width:20px; cursor:pointer; ' onmouseup=\"document.getElementById('sitemapAdd').submit();\" title='Save Changes' />
        </form>
    </div>
";

?>