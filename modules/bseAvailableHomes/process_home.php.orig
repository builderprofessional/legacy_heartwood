<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;


    if( !$bse->user->loggedIn )
    {
        header("Location: $rootPath");
        exit();
    }


    

    $homes =& $bse->getModule("bseAvailableHomes");
    $homes->setAllHomes();
    $homeid = $_POST['homeid'];


    if( isset($_POST['homeEditSubmit']) )
    {
        if(  $_POST['homeid'] == "new" || trim($_POST['homeid']) == ""  )
        {
            $homeid = $homes->insertNewHome();
            $home = $bse->getModule("bseAvailableHome");
            $home->setHomeId($homeid);
            $homes->add($home);
        }
        
        
        $home =& $homes->getItemById($homeid);
        $home->undirty();
        $home->page_id = $_POST['pageid'];
        $home->user_id = $_POST['userid'];
        $home->community_id = $_POST['community_id'];
        $home->communityName = $_POST['communityName'];
        $home->contact_id = $_POST['contact_id'];
        $home->lot = $_POST['lot'];
        $home->addr = $_POST['addr'];
        $home->city = $_POST['city'];
        $home->state = $_POST['state'];
        $home->zip = $_POST['zip'];
        $home->price = $_POST['price'];
        $home->beds = $_POST['beds'];
        $home->baths = $_POST['baths'];
        $home->partbaths = $_POST['partbaths'];
        $home->floors = $_POST['floors'];
        $home->garage = $_POST['garage'];
        $home->sqft = $_POST['sqft'];
        $home->lotsize = $_POST['lotsize'];
        $home->acres = $_POST['acres'];
        $home->yr_built = $_POST['yr_built'];
        $home->mls = $_POST['mls'];
        $home->image_file = $_POST['image_file'];
        $home->fp_pdf = $_POST['fp_pdf'];
        $home->fp_jpg = $_POST['fp_jpg'];
        $home->description = $_POST['description'];
        $home->status = $_POST['status'];
        $home->featured = ( isset($_POST['featured']) ? $_POST['featured'] : 0 );
        $home->active = ( isset($_POST['active']) ? $_POST['active'] : 1 );
        $home->commit();
    }
    
    
    
    if( isset($_REQUEST['delid']) )
    {
        $homes->deleteItem($_REQUEST['delid']);
        $homes->remove($_REQUEST['delid']);
        $page = $bse->removeArgFromURL("homeid", $page);
        header("Location: $rootPath{$page}");
        exit();
    }
    
    
    
    if( isset($_POST['homeAddGallery']) )
    {
        $home =& $homes->getItemById($_POST['homeid']);
        $gallery =& $bse->getModule("bsePhotoGallery");
        $galid = $gallery->insertNew();
        $gallery->setGalleryId($galid);
        $home->gallery_id = $galid;
        $home->commit();

        //die("New Gallery id = '$galid'");
    }
    
    
    
    $urlhome = "";
    if( strpos($page, "homeid=") === false )
    {
        $separator = ( strpos($page, "?") === false ? "?" : "&" );
        $urlhome = $separator . "homeid=$homeid";
    }
    header("Location: $rootPath{$page}$urlhome");
?>