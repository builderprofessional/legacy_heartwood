<?php

    // Filesystem Options
    $imageDir = "resources";

    
    // Google Map api key
    // If developing on your own local server, feel free to include your site and key in this if/then statement,
    // however, please leave all other site/key combinations in tact. Thank you.
    if( $_SERVER['SERVER_NAME'] == "www.projects.lss" )     // John Beavers' development server site key
        $config_GoogleMapKey = "ABQIAAAA8gHuR8HkA7Q0StaF1dsHLxSEkczr6xqZJ1A5FHkthOkUcUs6wxRH866kAbcLlfFV7Ey88HiH_tIosg";
    elseif( stripos($_SERVER['SERVER_NAME'], "websiteinprogress.us") !== false )    // websiteinprogress.us site key
        $config_GoogleMapKey = "ABQIAAAAuD71eDDeMkSpfRrXqb5jKBQixRN4q1S8a0AbCK4zgMM-FAZwbBSFt4UHuJ0n_0GwJpqrN5Swe5WNow";
    else  // this domain's site key
        $config_GoogleMapKey = "AIzaSyAmDyCzR8ol-uI8T4aZq1XTZ1x0WDOO6E8";
?>