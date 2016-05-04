<?php
//  ** Mail a Friend Page ** //


// Make sure the id is set

    if( !isset($_REQUEST['homeid']) || trim($_REQUEST['homeid']) == "" )
    {
        echo "<html><script type=\"text/javascript\"> alert('ERROR: There is no home selected to email.\\nThis may be an error or you may be you may be trying to hack this page.\\n\\nEither way, it won\'t work without a home selected.'); parent.Shadowbox.close(); </script></html>";
        exit();
    }


//  These are helper variables for this page.
//  Set $rootPath to the path from the directory this file is in to the directory that the modules directory is in.
//  Set $template to the name of the file to be displayed for this page.
//  Basically, this file can be copied and pasted into subdirectories for different pages of a website, while only needing to change
//  the two variables below.

    $rootPath = "../";
    $template = "mailFriend.tpl";





//  Create bse object. The bse object holds all of the installed modules for this website, as well as extending the savant template engine class.
//  All instances of the module objects for the website are stored in session variables.
//  The include file that houses the class definition for the bse object includes all required files for the installed modules,
//  sets up the session and defines the bse object.
//  The bse object allows access to any required module and/or template functions.
//  The bse constructor needs to know the path to the root directory (ie, the directory in which the "modules" directory is housed.
//  This allows for pages in subdirectories and for this site to be housed in any directory under any site.

    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);





    
    
    

//  Add the template directory, if specified
    if( @trim( $bse->config['templateDir'] ) != "" )
        $bse->addPath("template", $rootPath."modules/templates/".$bse->config['templateDir']);
    





// Set some traps for spammers

    $tofield = substr(md5( rand(100000, 999999) ), 0, 10);
    $_SESSION['tofield'] = $bse->tofield = $tofield;




    

//  Show the page for a given template

    $bse->display($template);


// Clear the contact info
unset($_SESSION['mailFriend']);

?>