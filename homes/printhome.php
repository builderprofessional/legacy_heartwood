<?php
// ** Home Print Page ** //


if( !isset($_REQUEST['homeid']) || @trim($_REQUEST['homeid']) == "" )    // We can't print a home without an id, go back to the list
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
    $template = "printHome.tpl";





//  Create bse object. The bse object holds all of the installed modules for this website, as well as extending the savant template engine class.
//  All instances of the module objects for the website are stored in session variables.
//  The include file that houses the class definition for the bse object includes all required files for the installed modules,
//  sets up the session and defines the bse object.
//  The bse object allows access to any required module and/or template functions.
//  The bse constructor needs to know the path to the root directory (ie, the directory in which the "modules" directory is housed.
//  This allows for pages in subdirectories and for this site to be housed in any directory under any site.

    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
//    $bse->setReturnPage();
//    $bse->bodyLayout = "layout-d";





    
    
    

//  Add the template directory, if specified
    if( @trim( $bse->config['templateDir'] ) != "" )
        $bse->addPath("template", $rootPath."modules/templates/".$bse->config['templateDir']);








// Get modules for this page
    $bse->homes = $bse->getModule("bseAvailableHomes");
    if( $bse->homes-id <= 0 || trim($bse->homes->id) == "" )
    {
        $page = dirname($bse->retPage);
        $page .= ( strlen($page) > 1 && substr($page, -1) != "/" ? "/" : "" ) . "index.php";
        $bse->homes->setPage($page);
    }
    
    $bse->home = $bse->homes->getItemById($_REQUEST['homeid']);
    $bse->community = null;
    $bse->homeContact = $bse->getModule("bseContact");
    $bse->busContact = $bse->getModule("bseContactPage");
    if( $bse->busContact->id != 1 )
        $bse->busContact->setPageId(1);






    if( $bse->home->contact_id > 0 )
    {
        if( $bse->homeContact->id != $bse->home->contact_id )
            $bse->homeContact->setContactId($bse->home->contact_id);
    }
    else
    {
        $bse->homeContact->name = $bse->busContact->company;
        $bse->homeContact->phone = $bse->busContact->phone;
        $bse->homeContact->email = $bse->busContact->email;
    }






    if( $bse->home->community_id > 0 )
    {
        $bse->community = $bse->getModule("bseCommunity");
        if( $bse->community->id != $bse->home->community_id )
            $bse->community->setCommunityId($bse->home->community_id);
    }








    
    

//  Show the page for a given template

    $bse->display($template);

?>