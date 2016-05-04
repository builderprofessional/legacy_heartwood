<?php
// ** Community Details ** //


// Program flow //

    if( !isset($_REQUEST['commid']) )
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
    $template = "communityDetail.tpl";





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
    $bse->setPageRoot();
    $bse->access = $bse->user->getPagePrivelege($bse->curPage);
    $bse->admin->editWidth = 900;
    $bse->admin->editHeight = 550;
    $bse->admin->displayEditBox = true;





    
    
    

//  Add the template directory, if specified
    if( @trim( $bse->config['templateDir'] ) != "" )
        $bse->addPath("template", $rootPath."modules/templates/".$bse->config['templateDir']);
    









// Get content of page
    $bse->content->getContent($bse->retPage);





// assign template variables for various templates

    $bse->dynamicSlideshow = $bse->getModule("bseSlideshow");
    $bse->dynamicSlideshow->setId(1);
    $bse->dynamicSlideshow->height = 100;
    $bse->dynamicSlideshow->heightUnit = "%";
    $bse->dynamicSlideshow->width = 100;
    $bse->dynamicSlideshow->widthUnit = "%";
    $bse->dynamicSlideshow->extraStyle = "position:fixed; z-index:0; top:0; left:0; border:solid 1px; ";
    $bse->dynamicSlideshow->autoStart = false;
    $bse->dynamicSlideshow->singleRandom = true;
    

    $commid = $_REQUEST['commid'];
    $bse->curComm = $bse->getModule("bseCommunity");

    if( $bse->curComm->id != $commid )
    {
        $bse->curComm->setCommunityId($commid);
    }


    $panel = 1;
    if( @$_REQUEST['panel'] > 1 )
    {
        $panel = $_REQUEST['panel'];
    }
    $bse->detailPanel = $panel;






// Get Default Meta Data for head
    $metaData = getDefaultMetaData($bse->db, $panel, $rootPath);

    if( trim($bse->content->title) == "" )
        $bse->content->title = $metaData['title'];

    if( trim($bse->content->metaDesc) == "" )
        $bse->content->metaDesc = $metaData['desc'];

    if( trim($bse->content->metaKeywords) == "" )
        $bse->content->metaKeywords = $metaData['keywords'];






// render template
    $bse->display($template);
?>