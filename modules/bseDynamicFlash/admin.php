<?php
// This is crudly put together for demo purposes. Normally one would incorporate whatever db connection scheme their site uses.
    include("../modules/bseVideo/video.php");
    $dbCon = getBseConnection("../");



// Check to see if the slide show editing form below has been posted. If so, update the database & upload the picture.
    if( isset($_POST['updateShow']) )
    {
        $dur = $_POST['duration'];
        $file = $_FILES['image']['name'];
        if( move_uploaded_file($_FILES['image']['tmp_name'], "images/$file") )
        {
            $dbCon->getQueryResult("INSERT INTO `flash_slideshow_images` SET `show_id`='1',`file`='$file'");
        }
        $dbCon->getQueryResult("UPDATE `flash_slideshows` SET `duration`='$dur' WHERE `id`='1'");
        header("Location: admin.php");
    }


// Check to see if the picture sort order form below has been posted. If so, update the database with the correct order.
    if( isset($_POST['updateOrder']) )
    {
        $catid = $_POST['catid'];
        $sql = "UPDATE `flash_slideshow_images` SET `sorder` = CASE `id` ";

        for( $i = 0; $i < count($_POST['sorder']); $i++ )
        {
            $id = $_POST['sorder'][$i];
            $sorder = $i;
            $sql .= "WHEN '$id' THEN '$sorder' ";
        }
        $sql .= "END";

        $dbCon->getQueryResult($sql) OR die(mysql_error());
        header("Location: admin.php" );
    }


// Check if we are deleting an image
    if( isset($_REQUEST['delid']) )
    {
        $delid = $_REQUEST['delid'];
        $sql = "DELETE FROM `flash_slideshow_images` WHERE `id` = '$delid'";
        $dbCon->getQueryResult($sql) OR die(mysql_error() );
        header("Location: ./");
    }
    
    $data = $dbCon->getQueryData("SELECT * FROM `flash_slideshows` WHERE `id`='1'");
    $dur = $data['duration'];
?>
<!doctype html public "-//w3c//dtd xhtml 1.0 strict//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-strict.dtd">
<html>
<head>
<script type="text/javascript" src="dragdrop.js"></script>
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
//alert(str);
    }

</script>
</head>
<body>
	<div style="font-size:larger; width:100%; text-align:center; ">Slide Show Admin</div>
	<div style="margin-top:20px; text-align:center; ">
		<form method="post" action="" enctype="multipart/form-data">
			Slide Duration: <select name="duration">
				<option value="3" <?= ($dur == 3 ? 'selected="selected"' : "" ) ?>>3</option>
				<option value="5" <?= ($dur == 5 ? 'selected="selected"' : "" ) ?>>5</option>
				<option value="10" <?= ($dur == 10 ? 'selected="selected"' : "" ) ?>>10</option>
				<option value="15" <?= ($dur == 15 ? 'selected="selected"' : "" ) ?>>15</option>
			</select>
			<input type="file" name="image" />
			<input type="submit" value="GO" name="updateShow" />
		</form>
	</div>
	<div style="width:75%; margin:auto; margin-top:35px; ">
	<div style="width:100%; text-align:center; font-size:larger;">Order the pictures by dragging and dropping them in the order you want</div>
	<div style="margin-top:15px;">
            <form method="post" action="">
                <div class='DragContainer' id='DragContainer1' style="margin-top:5px; clear:both; position:relative; margin-bottom:10px; ">

<?php

    $sql = "SELECT * FROM `flash_slideshow_images` WHERE `show_id`='1' ORDER BY `sorder` ASC";
    $rsTemp = $dbCon->getQueryResult( $sql );
    $picNumber = 0;

    while( $data = mysql_fetch_object($rsTemp) )
    {
        echo "<div style=\"float:left; margin:6px; text-align:center;\" imgID=\"{$data->id}\" dragable=\"dragable\" class=\"detailGalleryImage\" id=\"Image{$data->id}\"  overClass=\"OverDragBox\" dragClass=\"DragDragBox\"><img border=\"0\" src=\"resize_image.php?image=images/{$data->file}\" /><br /><a href=\"admin.php?delid={$data->id}\">Delete</a></div>\n";
        echo "<input id=\"sorder{$picNumber}\" type=\"hidden\" name=\"sorder[$picNumber]\" value=\"{$data->id}\" />\n";
        $picNumber++;
    }
    echo "<div style=\"width:100%; clear:both; \"></div></div>\n";
    echo "<div style=\"width:100%; text-align:right; \"><input type=\"submit\" name=\"updateOrder\" value=\"Save\" style=\"width:80px; \" /></div>";

    echo "</form>
</div>
";
?>
	</div>
	<div style="margin-top:35px; font-size:larger;"><a href="./">Back</a></div>
</body>
</html>