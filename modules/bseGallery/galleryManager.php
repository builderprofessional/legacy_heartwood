<?php

    ob_start();

    $rootPath = "../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    include("includes/config.inc");
    $imgloc = $imageDir . ( substr($imageDir, -1) == "/" ? "" : "/" );
    $edPic = null;

    if( isset($_REQUEST['catid']) )
        $catid=$_REQUEST['catid'];



    if( $bse->user->inBackDoor() )
    {
        $curGal =& $bse->getModule("bsePhotoGallery");
        if( isset($_REQUEST['galid']) && @trim( $_REQUEST['galid'] ) != "" )
        {
            $galid = $_REQUEST['galid'];
            $hideCatEdit = true;
            if( $_REQUEST['galid'] == 0 )
            {
                if( isset( $_REQUEST['ownerGalId'] ) && @trim( $_REQUEST['ownerGalId']) != "" && $_REQUEST['ownerGalId'] > 0 )
                {
                    $galid = $curGal->insertNew();
                    $newCat = $curGal->categories->insertNew();
                    $tmpCat = new bsePhotoGalleryCategory($bse->rootDir);
                    $tmpCat->setCategoryId($newCat);
                    $tmpCat->name = "During";
                    $tmpCat->galid = $galid;
                    $tmpCat->commit();
                    $curGal->categories->add($tmpCat);
                    
                    $ownerGal = $bse->db->getEscapedString($_REQUEST['ownerGalId']);
                    $bse->db->getQueryResult("UPDATE `st_remodelerGalleryImages` SET `during_galid` = '$galid' WHERE `img_id` = '$ownerGal'");
                }
            }
            $curGal->setGalleryId($galid);
        }
        
        
        $catsCol =& $curGal->categories;

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Manage Photo Gallery</title>

<script type="text/javascript">

    function switchForm(formid)
    {
        if( formid == 1 )
        {
            document.getElementById('catform').style.display="none";
            document.getElementById('imgform').style.display="block";
            document.getElementById('navImg').style.border="solid #aaa 1px";
            document.getElementById('navCat').style.border="0";
        }
        else
        {
            document.getElementById('catform').style.display="block";
            document.getElementById('imgform').style.display="none";
            document.getElementById('navImg').style.border="0";
            document.getElementById('navCat').style.border="solid #aaa 1px";
        }
    }

</script>
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
                    document.getElementById('sorder' + index++).value = container.childNodes[i].getAttribute('catID');
                    out += "img[" + container.childNodes[i].getAttribute('catID') + "].sorder = " + index + "\n";
                }
           }
        }
//        alert(out);
    }

</script>
<script type="text/javascript" src="<?= $bse->getFileHref("dragdrop.js") ?>"></script>
</head>
<body>
<?php

// Process category sort order
if( isset($_POST['catSorder']) )
{
    for( $i = 0; $i < count($_POST['sorder']); $i++ )
    {
        $cat =& $catsCol->getItemById( $_POST['sorder'][$i] );
        if( $cat != null )
        {
            $cat->undirty();
            $cat->sorder = $i;
            $cat->commit();
        }
    }
    $catsCol->arrangeBySortorder();
    header("Location: galleryManager.php");
    exit();
}



// process category addition to / removal from gallery
if (isset($_POST['submitaction'])) 
{
    if( $_POST['submitaction'] == "catSubmit" )
    {
        if( trim($_POST['newcat']) != "" )
        {
            $newCatId = $catsCol->insertNew();
            $newCat =& $catsCol->getItemById($newCatId);
            $newCat->undirty();
            $newCat->description = $_POST['description'];
            $newCat->galid = $curGal->id;
            $newCat->name = $_POST['newcat'];
            $newCat->commit();
        }
        else
        {
            $cat =& $catsCol->getItemById($_POST['imgcat']);
            $cat->description = $_POST['description'];
            if( trim($_POST['newname']) != "" )
                $cat->name = $_POST['newname'];
                
            $cat->commit();
        }
    }
    else if( $_POST['submitaction'] == "delPhotoCategory" )
    {
        $delid = $_POST['imgcat'];
        $catsCol->deleteItem($delid);
    }
    header("Location: galleryManager.php");
    exit();
}


// process image removal
if( isset($_REQUEST['dlink']) )
{
    $delid = $_REQUEST['dlink'];
    $curCat =& $catsCol->getItemById($curGal->getActiveCategoryId() );
    $curCat->images->deleteItem($delid);

//    $db->getQueryResult("DELETE FROM `bsePhotoGallery` WHERE `id`='$delid' LIMIT 1");

    header("Location: {$rootPath}$page" . ( strpos($page, "?") === false ? "?" : "&" ) . "catid={$curCat->id}");
    exit();
}

// process image submission for gallery
if (isset($_POST['submitpic'])) 
{
    $id   = $_POST['id'];
    $imgcat  = $_POST['imgcat'];
    $caption = $_POST['caption'];

    include( $bse->getFileHref("upload_class2.php") );
    $mypic = "";

    $handle = new upload($_FILES['image_field']);
    if ($handle->uploaded) 
    {
        $handle->file_safe_name    = true;
        $handle->file_auto_rename  = true;
        $handle->image_resize      = false;
        $handle->image_convert     = "jpg";
        $handle->jpeg_quality      = 100;
        $handle->process($imgloc);
        if ($handle->processed) 
        {
//            echo 'image resized';
            $mypic = $handle->file_dst_name;
            $handle->clean();
        }
        else 
        {
            echo 'error:<br>' . $handle->log;
            break;
        }
    }


// $MyObject returns $mypic - the name of the uploaded image used below to update MySQL
// need imgcat, imgname, caption

    if( trim( $id ) == "new" )
    {
        $cat =& $catsCol->getItemById($imgcat);
        $imgId = $cat->images->insertNew();
    }
    else
    {
        $imgId = trim($id);
        $cat =& $catsCol->getItemById($_POST['curcat']);
    }

    $newImg =& $cat->images->getItemById($imgId);
    $newImg->catid = $imgcat;
    $newImg->caption = $caption;
    if( trim($mypic) != "" )
        $newImg->image_file = $mypic;
    $newImg->commit();
    
    if( $imgcat != $_POST['curcat'] )
    {
        $cat->images->remove($imgId);
        $cat =& $catsCol->getItemById($imgcat);
        $cat->images->add($newImg);
    }
    unset ($_POST);

    header("Location: $rootPath{$page}" . ( strpos($page, "?") === false ? "?" : "&" ) . "catid={$imgcat}");
    exit();
}

// requested image?
if (isset($_REQUEST['id']))
{
    $id = $_REQUEST['id'];  //mysql_real_escape_string($_REQUEST['id']);
}
else 
{
    $id="new";
}
if (trim($id) == "new")
{
    $thispicname = "";
    $thisnum = "new";
    $piccat = "";
    $newcat = "";
    $leadin = "";
    $sorder = "";
}
else
{
    $curCat =& $catsCol->getItemById($curGal->getActiveCategoryId() );
    $edPic  =& $curCat->images->getItemById($id);

    $thisnum = $edPic->id;
    $thispicname = $edPic->image_file;
//    $piccat = $curCat->name;
    $catid = $curCat->id;
    $newcat = "";
    $leadin = $edPic->caption;
    $sorder = $edPic->sorder;
}

if ($thisnum == "new")
{
    $msg1 = "Add Image";
    $msg2 = "Select a Category (or add one), add a caption,<br>select the image using the 'Browse' tool and then click 'Update'.";
}
else
{
    $msg1 = "Edit Image";
    $msg2 = "Make changes as needed then click 'Update'<br>or click the Remove button below the picture to delete this picture.";
}

?>

    <div style="width:100%; margin-top:25px; margin-bottom:15px; text-align:center; font-size:21px; font-weight:900; font-family:Arial, Verdana, Sans; ">Photo Gallery Manager</div>

<?php

echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
echo "<td id='navImg' align='center' valign='middle' width='100px' height='35px' class='norm' style=\"border:solid #aaa 1px; cursor:pointer; \" onmouseup=\"switchForm(1);\">Image</td>";
if( !isset($_GET['id']) && $hideCatEdit != true )
{
    echo "<td id='navCat' align='center' valign='middle' width='100px' height='35px' class='norm' style=\"cursor:pointer; \" onmouseup=\"switchForm(2);\">Categories</td>";
}
echo "<td align='right' valign='middle' width='390' class='norm'>";

$page = $bse->removeArgFromURL("catid");
echo "<a href=\"../../{$page}" . ( strpos($page, "?") === false ? "?" : "&" ) . "catid=$catid\">";
echo "<b>Back to Gallery</b></a>";
echo "</td>";
echo "</tr></table>";

echo '    <div id="imgform">';
echo "<table align='center' style='border:solid #aaa; border-width:thin;' cellpadding='0' cellspacing='0'><tr>";
echo "<td align='left' valign='top' width='590' bgcolor='#ffffff'>";
    echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
    echo "<td align='left' valign='top' width='20'><br></td>";
    echo "<td align='left' valign='top' width='500' class='norm'>";

    echo "<br /><span class='subhead' style='font-weight:900; '>{$msg1}</span><br><br><div style='font-size:14px; font-family:arial; '>$msg2</div>";
    echo "</td>";
    echo "<td align='left' valign='top' width='20'><br></td>";
    echo "</tr></table>";

    echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
    echo "<td align='center' valign='top' width='540' height='300' background='iface/editbg3.png'>";
        echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
        echo "<td align='left' valign='top' class='norm' width='25'><br></td>";
// image side
        echo "<td align='center' valign='top' class='norm' width='155'><br><br>";
        if ($thisnum !== "new")
        {
            echo "<img class='imgthumb' src=\"".$edPic->getPreviewImage(180, 150)."\">";
        }
        echo "<br>";
// remove image?
        if ($thisnum !== "new")
        {
            echo "<form name='removit' method='post' action='galleryManager.php?dlink={$thisnum}' onSubmit=\"return confirm('Are you sure you want to delete?');\">";
            echo "<input name='del_btn' type='submit' value='Remove'>";
            echo "</form>";
        }
        echo "</a><br></td>";
// spacer
        echo "<td align='left' valign='top' class='norm' width='50'><br></td>";
// form side
        echo "<td align='left' valign='top' class='norm' width='225'><br><br>";
        echo "<form action='galleryManager.php' method='post' name='editpic' ENCTYPE='multipart/form-data'>";
        echo "<input type='hidden' name='submitpic' value='1'>";
        echo "<input type='hidden' name='id' value='{$thisnum}'>";
        echo "<input type='hidden' name='curcat' value='{$catid}' />";
        echo "<input type='hidden' name='sorder' value='{$sorder}'>";
        echo "<input type='hidden' name='picname' value='{$thispicname}'>";
            echo "<table border='0' cellpadding='0' cellspacing='0'><tr>";
            echo "<td align='left' valign='middle' class='norm' width='55'><br>Category:<br></td>";
            echo "<td align='left' valign='top' width='110' class='norm'><br>";
            echo "<select name='imgcat' class='input2' style='width:100%;'>";

            foreach( $catsCol as $cat)
            {
                echo "<option catDesc=\"{$cat->description}\" title=\"$cat->description\" value='{$cat->id}'";
                if ($cat->id == $catid) { echo 'selected="selected"'; }
                echo ">{$cat->name}</option>";
            }
            echo "</select>";
            echo "</td>";
            echo "</tr><tr>";
            echo "<td><br /></td>";
            echo "<td></td>";
            echo "</tr><tr>";
            echo "<td align='left' valign='middle' class='norm' width='55'>Caption:</td>";
            echo "<td align='left' valign='top' width='120' class='norm'><input class='input2' type='text' name='caption' value=\"{$leadin}\"></td>";
            echo "</tr><tr>";
            echo "<td align='left' valign='middle' class='norm' width='55'>Image:</td>";
            echo "<td align='left' valign='top' width='120' class='norm'><input class='input2' type='file' name='image_field' size='10'></td>";
            echo "</tr></table>";

            echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
            echo "<td align='center' valign='top' width='215'><br><br>";
            echo "<input type='submit' name='submitthis' value='Update'><br><br>";
            echo "</td>";
            echo "</tr></table>";
        echo "</form>";
        echo "</td>";
        echo "<td width='15'><br></td>";
        echo "</tr></table>";

    echo "</td>";
    echo "</tr></table>";

echo "</td>";
echo "</tr></table></div>";
echo "<div id='catform' style=\"display:none; \">\n";
echo "<table align='center' style='border:solid #aaa; border-width:thin;' cellpadding='0' cellspacing='0'><tr>";
echo "<td align='left' valign='top' width='590' bgcolor='#ffffff'>";
    echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
    echo "<td align='left' valign='top' width='20'><br></td>";
    echo "<td align='left' valign='top' width='500' class='norm'>";
    echo '<br /><span class="subhead" style="font-weight:900; ">Edit Categories</span><br><br><div style="font-size:14px; font-face:arial; ">
        On the left, drag and drop the categories to the order you want them, then click the "Save Order" button to set the order that the categories appear in the dropdown box on the gallery page.<br /><br />
        On the right, add a category by entering a name in the "Add Cat:" field and optionally entering a description for the category.
        Or, you may select a category from the dropdown box and change its information. Click the "Save" button when done editing, or click the "Delete" button to remove the category selected in the dropdown box.
</div>';
    echo "</td>";
    echo "<td align='left' valign='top' width='20'><br></td>";
    echo "</tr></table>";

    echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
    echo "<td align='center' valign='top' width='540' height='300' background='iface/editbg3.png'>";
        echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
        echo "<td align='left' valign='top' class='norm' width='25'><br></td>";
// category order side
        echo "<td align='center' valign='top' class='norm' width='175'><form method='post' action='galleryManager.php'>";
            echo "<div class='DragContainer' id='DragContainer1' style='width:90%; height:85%; overflow-y:auto; margin-top:35px; position:relative; z-index:0;'>";

            $counter = 0;
            foreach( $catsCol as $cat )
            {
                echo "<div dragable=\"dragable\" catID=\"{$cat->id}\" class='DragBox' id=\"Item{$cat->id}\"  overClass=\"OverDragBox\" dragClass=\"DragDragBox\" style='width:130px; border:solid #CACACA 2px; cursor:default; '>{$cat->name}</div>\n";
                echo "<input id=\"sorder{$counter}\" type=\"hidden\" name=\"sorder[$counter]\" value=\"{$cat->id}\" />\n";
                $counter++;
            }
        echo "</div><div style='width:100%; text-align:center;'><input type='submit' name='catSorder' value='Save Order' style='width:120px; margin-top:10px;' /></div></form></td>";



// spacer
        echo "<td align='left' valign='top' class='norm' width='50'><br></td>";



// form side
        echo "<td align='left' valign='top' class='norm' width='225'><br><br>";
        echo "<form action='galleryManager.php' method='post' name='editcat'>";
        echo "<input type='hidden' name='submitcat' value='1'>";
        echo "<input type='hidden' name='id' value='{$thisnum}'>";
            echo "<table border='0' cellpadding='0' cellspacing='0' style=\"position:relative; z-index:2; \"><tr>";
            echo "<td align='left' valign='middle' class='norm' width='55'>Add Cat:<br></td>";
            echo "<td align='left' valign='top' width='90' class='norm'><input class='input2' style='width:190px;' type='text' name='newcat' value=''></td>";
            echo "</tr><tr>";
            echo "<td align='left' valign='middle' class='norm' width='55'><br>Category:<br></td>";
            echo "<td align='left' valign='top' width='110' class='norm'><br>";
            echo "<select name='imgcat' class='input2' style='width:100%;' onchange=\"this.form.description.value=this.options[this.selectedIndex].getAttribute('catDesc');\"><option catDesc=\"\" value=\"-1\">Select a Category</option>";
            foreach( $catsCol as $cat )
            {
                $selected = "";
                if( $cat->id == $catid )
                    $selected = ' selected="selected"';

                echo "<option catDesc=\"{$cat->description}\" value=\"{$cat->id}\" title=\"{$cat->description}\"$selected>{$cat->name}</option>";
            }
            echo "</select>";
            echo "</td>";
            echo "</tr><tr>";
            echo "<td align='left' valign='middle' class='norm' width='55'>Rename:<br></td>";
            echo "<td align='left' valign='top' width='90' class='norm'><input class='input2' style='width:190px;' type='text' name='newname' value=''></td>";
            echo "</tr><tr>";
            echo "<td align='left' valign='middle' class='norm' width='55'>Description:</td>";
            echo "<td align='left' valign='top' width='90' class='norm'><input class='input2' style='width:190px;' type='text' name='description' value=\"{$leadin}\"></td>";
            echo "</tr></table>";

            echo "<table align='center' border='0' cellpadding='0' cellspacing='0'><tr>";
            echo "<td align='center' valign='top' width='225'><br><br><input id='catFormAction' type='hidden' name='submitaction' value='catSubmit' />";
            echo "<input type='button' value='Delete' style='width:80px;' onclick=\"document.getElementById('catFormAction').value = 'delPhotoCategory'; this.form.submit();\" /> <input type='submit' name='catSubmit' value='Save' style='width:80px;' ><br><br>";
            echo "</td>";
            echo "</tr></table>";
        echo "</form>";
        echo "</td>";
        echo "<td width='15'><br></td>";
        echo "</tr></table>";

    echo "</td>";
    echo "</tr></table>";

echo "</td>";
echo "</tr></table>";

?>
    </div>
    </body>
</html>

<?php
    ob_flush();
    exit();
     }
     else
         header("Location: ../../index.php");
?>