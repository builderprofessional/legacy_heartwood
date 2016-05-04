<?php
//  ** Gallery Page ** //

//  These are helper variables for this page.
//  Set $rootPath to the path from the directory this file is in to the directory that the modules directory is in.
//  Set $template to the name of the file to be displayed for this page.
//  Basically, this file can be copied and pasted into subdirectories for different pages of a website, while only needing to change
//  the two variables below.

    $rootPath = "../";
    $template = "gallery.tpl";





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
    $bse->access = $bse->user->getPagePrivelege($bse->curPage);
    $bse->admin->displayEditBox = true;
    $bse->admin->editWidth = 950;
    $bse->admin->editHeight = 400;
    




    
    
    

//  Add the template directory, if specified
    if( @trim( $bse->config['templateDir'] ) != "" )
        $bse->addPath("template", $rootPath."modules/templates/".$bse->config['templateDir']);
    






// Get modules for this page
    $bse->gallery = $bse->getModule("bsePhotoGallery");
    $data = $bse->db->getQueryData("SELECT * FROM `bsePhotoGalleries` WHERE `page` = '{$bse->retPage}'");
    if( isset($data['id']) )
        $bse->gallery->setGalleryId($data['id']);
        
    if( isset($_GET['catid']) )
    {
        if( trim($_GET['catid']) != "" )
             $catid = $_GET['catid'];
    }
    
    if( !isset($catid) )
    {
        $query = $bse->db->getQueryResult("SELECT * FROM `{$bse->gallery->categories->getTable()}` WHERE `galid` = '{$bse->gallery->id}' ORDER BY `sorder` ASC");
        if( mysql_num_rows($query) > 0 )
        {
            $data = mysql_fetch_array($query);
            $catid = $data['id'];
        }
        else
            $catid = -1;
    }

    $bse->gallery->setCurrentCategory($catid);


    
    
    $bse->dynamicSlideshow = $bse->getModule("bseSlideshow");
    $bse->dynamicSlideshow->setId(1);
    $bse->dynamicSlideshow->height = 100;
    $bse->dynamicSlideshow->heightUnit = "%";
    $bse->dynamicSlideshow->width = 100;
    $bse->dynamicSlideshow->widthUnit = "%";
    $bse->dynamicSlideshow->extraStyle = "position:fixed; z-index:0; top:0; left:0; border:solid 1px; ";
    $bse->dynamicSlideshow->autoStart = false;
    $bse->dynamicSlideshow->singleRandom = true;
    
    
    

//  Show the page for a given template

    $bse->display($template);

?>