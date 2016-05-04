<?php

    

?>
<script type="text/javascript">

    function objectDropped(container)
    {
        var index = 0;
        str = '';
        for( i=0; i < container.childNodes.length; i++)
        {
            if( typeof(container.childNodes[i].getAttribute) != "undefined" )
            {
                if( container.childNodes[i].getAttribute('dragable') == "dragable" )
                {
                    str += '\nimg:'+container.childNodes[i].getAttribute('imgID')+'='+index;
                    document.getElementById('sorder' + index++).value = container.childNodes[i].getAttribute('imgID');
                }
           }
        }
// alert(str);  // For testing purposes to ensure sorting data is received
    }

</script>
<script type="text/javascript" src="<?= $this->getFileHref("dragdrop.js") ?>"></script>
    <div style="font-size:19px; width:100%; text-align:center; ">Slide Show Admin</div>
    <div style="margin-top:20px; text-align:center; ">
        <div style="width:70%; margin:auto; font-size:14px; font-family:arial, Sans; ">
            Select the number of seconds for each image to show in the slideshow from the "Slide Duration" dropdown box, and/or upload another image by clicking the "Browse" button, then click "Update" button.<br /><br />
        </div>
        <form method="post" action="<?= $this->dynFlash->getProcessScriptHref() ?>" enctype="multipart/form-data">
            Slide Duration: <select name="duration">
                <option value="3" <?= ($this->dynFlash->duration == 3 ? 'selected="selected"' : "" ) ?>>3</option>
                <option value="5" <?= ($this->dynFlash->duration == 5 ? 'selected="selected"' : "" ) ?>>5</option>
                <option value="10" <?= ($this->dynFlash->duration == 10 ? 'selected="selected"' : "" ) ?>>10</option>
                <option value="15" <?= ($this->dynFlash->duration == 15 ? 'selected="selected"' : "" ) ?>>15</option>
            </select>
            <input type="file" name="image" />
            <input type="submit" value="Update" name="updateShow" />
        </form>
        <div style="width:100%; text-align:center; font-size:17px; font-weight:900; color:#CC3344; ">
            Photos must be sized to <?= $this->dynFlash->width ?> pixels wide by <?= $this->dynFlash->height ?> pixels high!
        </div>
    </div>
    <div style="width:75%; margin:auto; margin-top:55px; ">
    <div style="width:100%; text-align:center; font-size:larger;">Order the pictures by clicking and dragging them to the order you want then click the "Save" button below, or click the "Delete" link under a picture to remove it from the slideshow.</div>
    <div style="margin-top:15px;">
            <form method="post" action="<?= $this->dynFlash->getProcessScriptHref() ?>">
                <div class='DragContainer' id='DragContainer1' style="margin-top:5px; clear:both; position:relative; margin-bottom:10px; ">

<?php

    $picNumber = 0;

    foreach( $this->dynFlash->images as $flash )
    {
        $img = $flash->getResizedImage(100);
        echo "<div style=\"float:left; margin:6px; text-align:center;\" imgID=\"{$flash->id}\" dragable=\"dragable\" class=\"detailGalleryImage\" id=\"Image{$flash->id}\"  overClass=\"OverDragBox\" dragClass=\"DragDragBox\"><img border=\"0\" src=\"$img\" /><br /><a href=\"{$this->rootDir}modules/bseDynamicFlash/processFlash.php?delid={$flash->id}\">Delete</a></div>\n";
        echo "<input id=\"sorder{$picNumber}\" type=\"hidden\" name=\"sorder[$picNumber]\" value=\"{$flash->id}\" />\n";
        $picNumber++;
    }
    echo "<div style=\"width:100%; clear:both; \"></div></div>\n";
    echo "<div style=\"width:100%; text-align:right; clear:both; \"><input type=\"submit\" name=\"updateOrder\" value=\"Save\" style=\"width:80px; \" /></div>";

    echo "</form>
</div>
";
?>
    </div>
</body>
</html>