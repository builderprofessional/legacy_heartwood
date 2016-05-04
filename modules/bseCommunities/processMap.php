<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;


    if( isset($_POST['updateLocation']) )
    {
        $community =& $bse->getModule("bseGoogleMap")->communities->getItemById($_POST['communityID']);
        $community->undirty();
        $community->setPoint($_POST['point']);
        $community->commit();
    }



    if( isset($_POST['mapSaveSubmit']) )
    {
        $map =& $bse->getModule("bseGoogleMap");
        if( $_POST['mapid'] != $map->id )
            $map->setMapId($_POST['mapid']);

        $map->undirty();
        $map->mapName = $_POST['mapName'];
        $map->point = str_replace("(", "", str_replace(")", "", $_POST['mapCenter']));
        $map->zoom = $_POST['mapZoom'];
        $map->commit();
    }



    if( isset($_POST['addCommunity']) )
    {
        $map =& $bse->getModule("bseGoogleMap");
        if( $_POST['mapid'] != $map->id )
            $map->setMapId($_POST['mapid']);
        
        $comm =& $map->createCommunity();
        $comm->setPoint($_POST['iconLocation']);
        $comm->commit();
        header("Location: editCommunity.php?id={$comm->id}");
        exit();
    }



    if( isset($_POST['mapCreateSubmit']) )
    {
    	$maps =& $bse->getModule("bseMapsCollection");
    	$mapID =& $maps->insertNew();
    	
    	$newMap = $bse->getModule("bseGoogleMap");
    	$newMap->setItemId($mapID);
    	$newMap->undirty();
        $newMap->mapName = $_POST['mapName'];
        $newMap->zoom = $_POST['mapZoom'];
        $newMap->point = str_replace("(", "", str_replace(")", "", $_POST['mapPoint']));
        $newMap->commit();
        $maps->add($newMap);
    }




    if( isset($_POST['delMapSubmit']) )
    {
        //$id = $bse->db->getEscapedString($_POST['delid']);
        //$bse->db->getQueryResult("DELETE FROM `bseCommMaps` WHERE `id`='$id' AND `id` != 0 LIMIT 1");
        
        $maps =& $bse->getModule("bseMapsCollection");
        $maps->deleteItem($_POST['delid']);
        
        $map =& $bse->getModule("bseGoogleMap");
        $map->setNewMapId(0);
    }


    $_SESSION['dirty'] = true;
    header("Location: $rootPath{$page}");
?>