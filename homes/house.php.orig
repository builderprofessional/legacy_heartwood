<?php
//  ** Home Details Page ** //


// Make sure the id is set

    if( !isset($_REQUEST['homeid']) || trim($_REQUEST['homeid']) == "" )
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
    $template = "homeDetail.tpl";





//  Create bse object. The bse object holds all of the installed modules for this website, as well as extending the savant template engine class.
//  All instances of the module objects for the website are stored in session variables.
//  The include file that houses the class definition for the bse object includes all required files for the installed modules,
//  sets up the session and defines the bse object.
//  The bse object allows access to any required module and/or template functions.
//  The bse constructor needs to know the path to the root directory (ie, the directory in which the "modules" directory is housed.
//  This allows for pages in subdirectories and for this site to be housed in any directory under any site.

    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $bse->setReturnPage($bse->curPage . "?" . $_SERVER['QUERY_STRING']);
    $bse->admin->useEditor = false;
    $_SESSION['mailpage'] = $bse->retPage;





    
    
    

//  Add the template directory, if specified
    if( @trim( $bse->config['templateDir'] ) != "" )
        $bse->addPath("template", $rootPath."modules/templates/".$bse->config['templateDir']);
    







// Get modules for this page

    $bse->dynamicSlideshow = $bse->getModule("bseSlideshow");
    $bse->dynamicSlideshow->setId(1);
    $bse->dynamicSlideshow->height = 100;
    $bse->dynamicSlideshow->heightUnit = "%";
    $bse->dynamicSlideshow->width = 100;
    $bse->dynamicSlideshow->widthUnit = "%";
    $bse->dynamicSlideshow->extraStyle = "position:fixed; z-index:0; top:0; left:0; border:solid 1px; ";
    $bse->dynamicSlideshow->autoStart = false;
    $bse->dynamicSlideshow->singleRandom = true;
        


    $bse->homes = $bse->getModule("bseAvailableHomes");
    $bse->homes->setAllHomes();

    $bse->home = $bse->homes->getItemById($_REQUEST['homeid']);
//    $bse->home->setHomeId($_REQUEST['homeid']);         // used in development to force retrieval of data from database
    $bse->homeContact = $bse->getModule("bseContact");
    $bse->homeGallery = null;
    $bse->community = null;





    if( $bse->home->gallery_id > 0 )
    {
        $bse->homeGallery = $bse->getModule("bsePhotoGallery");
        $bse->homeGallery->setGalleryId($bse->home->gallery_id);
    }
    
    
    
    
    if( $bse->home->community_id > 0 )
    {
        $bse->community = $bse->getModule("bseCommunity");
        if( $bse->community->id != $bse->home->community_id )
            $bse->community->setCommunityId($bse->home->community_id);
    }




    if( $bse->home->contact_id > 0 )
    {
        if( $bse->homeContact->id != $bse->home->contact_id )
            $bse->homeContact->setContactId($bse->home->contact_id);
    }
    else
    {
        $conPage = $bse->getModule("bseContactPage");
        if( $conPage->id != 1 )
            $conPage->setPageId(1);
        
        $bse->homeContact->name = $conPage->company;
        $bse->homeContact->phone = $conPage->phone;
        $bse->homeContact->email = $conPage->email;
    }




    
    

//  Show the page for a given template

    $bse->display($template);
echo "<!-- {$_SESSION['mailpage']} -->";
?>