<?php


    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = htmlentities($bse->retPage);

    if( isset($_POST['commEditSubmit']) )
    {
        $map =& $bse->getModule("bseGoogleMap");
        $comm = $map->communities->getItemById($_POST['commid']);
        $comm->undirty();
        $comm->name = $_POST['comName'];
        $comm->address = $_POST['comAddress'];
        $comm->priceRange = $_POST['comPrice'];
        $comm->sizeRange = $_POST['comSize'];
        $comm->description = $_POST['comDesc'];
        $comm->contact_id = $_POST['contactid'];
        $comm->commit();
        
        header("Location: editCommunity.php?id={$comm->id}");
        exit();
    }


    if( isset($_GET['id']) ) if( trim($_GET['id']) != "" )
    {
        $map =& $bse->getModule("bseGoogleMap");
        $comm = $map->communities->getItemById($_GET['id']);
        $cons = $bse->getModule("bseContactPage");

        if( isset($_GET['del']) ) if( $_GET['del'] == "yes" )
        {
            $map =& $bse->getModule("bseGoogleMap");
            $map->communities->deleteItem($comm->id);
            $map->setNewMapId($map->id);

            header("Location: ../../{$page}");
            exit();
        }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Edit Community</title>
</head>
<body>
    <div style="width:600px; margin:auto; font-size:35px; font-weight:900; font-family:Arial Verdana Sans Tahoma; text-align:center; margin-top:65px; ">Community Editor<div style="float:right; "><img src="resources/iface/map-marker.png" style="position:relative; top:-60px; " /></div></div>
    <div style="width:450px; margin:auto; text-align:right; font-size:17px; font-weight:900; font-family:Arial Verdana Sans Tahoma; position:relative; top:-60px; clear:both; "><a href="../../<?=$_SESSION['retPage']?>">Back to Communities</a></div>
    <div style="width:440px; margin:auto; clear:both; position:relative; top:-25px;">
        <div style="font-size:17px; font-weight:900; width:100%; text-align:center; margin-bottom:10px; ">Enter The Community's Information Below</div>
        <form method="post" action="editCommunity.php" style="width:430px;">
            <input type="hidden" name="commid" value="<?=$comm->id?>" />
            <div><div>Community Name</div><input style="width:100%;" type="text" name="comName" value="<?=$comm->name?>" /></div>
            <div style="margin-top:10px; "><div>Community Address</div><input style="width:100%;" type="text" name="comAddress" value="<?=$comm->address?>" /></div>
            <div style="margin-top:10px; "><div>Community Price Range</div><input style="width:100%;" type="text" name="comPrice" value="<?=$comm->priceRange?>" />
            <div style="margin-top:10px; "><div>Community Size Range</div><input style="width:100%;" type="text" name="comSize" value="<?=$comm->sizeRange?>" />
<?php
    if( isset($cons) )
    {
?>
            <div style="margin-top:10px; "><div>Community Contact</div>
                <select style="width:100%;" name="contactid">
                    <option></option>
                    <?= $cons->getSelectOptionsList($comm->contact_id) ?>
                </select>
<?php
    }
?>
            <div style="margin-top:10px; "><div>Community Description</div><textarea style="width:100%; height:180px; " name="comDesc"><?=$comm->description?></textarea></div>
            <div style="float:right; margin-top:15px; "><input type="button" value="Cancel" style="width:80px; " onmouseup="document.location.href='../../<?=$page?>';" /> <input style="width:80px;" type="button" value="Delete" onmouseup="document.location.href='editCommunity.php?id=<?=$comm->id?>&del=yes';" /> <input type="submit" name="commEditSubmit" value="Save" style="width:80px;" /></div>
        </form>
    </div>
</body>
</html>
<?php
    }
    else
    {
        header("Location: ../../{$page}");
        exit();
    }

?>