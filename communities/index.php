<?php
//  ** Communities Page ** //


// Program flow //

    if( isset($_REQUEST['mapid']) )  if( $_REQUEST['mapid'] == "new" )
    {
        header("Location: newmap.php");
        exit();
    }





//  These are helper variables for this page.
//  Set $rootPath to the path from the directory this file is in to the directory that the modules directory is in.
//  Set $template to the name of the file to be displayed for this page.
//  Basically, this file can be copied and pasted into subdirectories for different pages of a website, while only needing to change
//  the two variables below.

    $rootPath = "../";
    $template = "communities.tpl";





//  Create bse object. The bse object holds all of the installed modules for this website, as well as extending the savant template engine class.
//  All instances of the module objects for the website are stored in session variables.
//  The include file that houses the class definition for the bse object includes all required files for the installed modules,
//  sets up the session and defines the bse object.
//  The bse object allows access to any required module and/or template functions.
//  The bse constructor needs to know the path to the root directory (ie, the directory in which the "modules" directory is housed.
//  This allows for pages in subdirectories and for this site to be housed in any directory under any site.

    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $bse->setReturnPage();
    $bse->access = $bse->user->getPagePrivelege($bse->curPage);
    $bse->admin->editWidth = 630;
    $bse->admin->editHeight = 400;



    
    
    

//  Add the template directory, if specified
    if( @trim( $bse->config['templateDir'] ) != "" )
        $bse->addPath("template", $rootPath."modules/templates/".$bse->config['templateDir']);
    




// Set variables for this page

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
    $bse->googleMap->markersOverlay = true;


// Get google Map to display. If the map session variable is set, then we've already determined geolocation and just need to display the map
//echo "Map Id = '{$bse->googleMap->id}'<br />";
    if( @trim( $bse->googleMap->id) == "" || @$bse->googleMap->id <= 0 || isset($_REQUEST['mapid']) )
    {
     // Geolocation has not been determined and we need to get it.

        @$mapid = $_REQUEST['mapid'];
        if( !isset($_REQUEST['mapid']) )
        {
//echo "Getting geolocation";
            if( $_SERVER['SERVER_NAME'] == 'www.projects.lss' )
                $_SERVER['REMOTE_ADDR'] = "64.250.197.176";
            $userLocAry = getLocationFromIp($_SERVER['REMOTE_ADDR']);
            $mapid = getClosestMap($userLocAry, $bse->db);
//echo "Retrieved MapId = '$mapid'<br />";
        }
        
        $bse->googleMap->setNewMapId($mapid);
    }


    $bse->googleMap->mapCenter = $bse->googleMap->point;
    $bse->googleMap->resetMapCodes();
    $bse->googleMap->markersOverlay = true;
    $bse->googleMap->hideCommList = false;
    $bse->googleMap->searchOverlay = false;
    $bse->googleMap->useDirections = false;
    $bse->googleMap->showAllMarkers = true;
    $bse->googleMap->selectedCommunity = null;
    $bse->googleMap->hideMapSelect = false;
    
    
    $bse->mapsData = $bse->getModule("bseMapsCollection");
    $bse->mapsData->setMapsList();




    
    

//  Show the page for a given template

    $bse->display($template);

?>