<?php
// ** Local Info ** //


// Program Flow

    // Check for required info before doing any database calls or setting variables
    if( isset($_GET['commid']) )
    {
        $comid = $_GET['commid'];
    }
    else
    {
        header("Location: ./");
        exit();
    }






//  These are helper variables for this page.
//  Set $rootPath to the path from the directory this file is in to the directory that the modules directory is in.
//  Set $template to the name of the file to be displayed for this page.
//  Basically, this file can be copied and pasted into subdirectories for different pages of a website, while only needing to change
//  the two variables below.

    $rootPath = "../";
    $template = "localInfo.tpl";





//  Create bse object. The bse object holds all of the installed modules for this website, as well as extending the savant template engine class.
//  All instances of the module objects for the website are stored in session variables.
//  The include file that houses the class definition for the bse object includes all required files for the installed modules,
//  sets up the session and defines the bse object.
//  The bse object allows access to any required module and/or template functions.
//  The bse constructor needs to know the path to the root directory (ie, the directory in which the "modules" directory is housed.
//  This allows for pages in subdirectories and for this site to be housed in any directory under any site.

    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $bse->setReturnPage($bse->curPage . ( $_SERVER['QUERY_STRING'] != "" ? "?{$_SERVER['QUERY_STRING']}" : "" ));
    $bse->admin->editWidth = 630;
    $bse->admin->editHeight = 700;




    
    
    

//  Add the template directory, if specified
    if( @trim( $bse->config['templateDir'] ) != "" )
        $bse->addPath("template", $rootPath."modules/templates/".$bse->config['templateDir']);
    









// Get modules and set variables for this page

    $bse->dynamicSlideshow = $bse->getModule("bseSlideshow");
    $bse->dynamicSlideshow->setId(1);
    $bse->dynamicSlideshow->height = 100;
    $bse->dynamicSlideshow->heightUnit = "%";
    $bse->dynamicSlideshow->width = 100;
    $bse->dynamicSlideshow->widthUnit = "%";
    $bse->dynamicSlideshow->extraStyle = "position:fixed; z-index:0; top:0; left:0; border:solid 1px; ";
    $bse->dynamicSlideshow->autoStart = false;
    $bse->dynamicSlideshow->singleRandom = true;
        

    $bse->googleMap = $bse->getModule("bseGoogleMap");
    $bse->curComm = $bse->getModule("bseCommunity");
    
    $bse->curComm->setCommunityId($comid);
    $mapid = $bse->curComm->map_id;
    
    if( $mapid != $bse->googleMap->id )
        $bse->googleMap->setNewMapId($mapid);


    $bse->googleMap->resetMapCodes();
    $bse->googleMap->mapCenter = $bse->curComm->point;
    $bse->googleMap->markersOverlay = true;
    $bse->googleMap->hideCommList = true;
    $bse->googleMap->searchOverlay = true;
    $bse->googleMap->useDirections = true;
    $bse->googleMap->showAllMarkers = false;
    $bse->googleMap->selectedCommunity = $comid;
    $bse->googleMap->hideMapSelect = true;
    




    
    

//  Show the page for a given template

    $bse->display($template);

?>