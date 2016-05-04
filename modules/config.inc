<?php


    // What is the template directory
    $templateDir = "heartwood";



    // Database options

    $dbHost = "localhost";
    $dbSchema = "heartwood_new";
    $dbUser = "heartwoodUser";
    $dbPass = "*HeartwoodP@ss*";
  

    
// CSS Options

    // Body
    $body_background_color = "#FFF";
    $body_color = "#FFF";
    $body_font_family = 'Verdana, Arial, serif';
    $body_font_size = "16px";
    $body_background_image = "";
    $body_background_repeat = "";
    
    // Admin header
    $admin_backgound_color = "";    // Default is the same as the body color
    $admin_color = "#000";
    $frontback_link_color = "";	// Defaults to $admin_color if left empty


    // BSE Footer Links
    $bse_footer_color = "#FFF";
    $bse_footer_link_color = "";      // Default is the same as $bse_footer_color
    $bse_footer_font_size = "11px";       // Defaults to $body_font_size
    $bse_footer_font_weight = "";     // Defaults to 400;


    // SEO Options
global $useStatistics, $bseLinkId;
    $GLOBALS['useStatistics'] = true;	// True for the 'Statistics' link to show up in the admin header
    $GLOBALS['bseLinkId'] = "818284";	// The link id for bselink.com business partners



// End user configurable code










// Below here is internal code
// Please do not change code below this
    $templateDir .= (substr($templateDir, -1) == "/" ? "" : "/" );  // add forward slash if it is not there
    
    
    
  
?>