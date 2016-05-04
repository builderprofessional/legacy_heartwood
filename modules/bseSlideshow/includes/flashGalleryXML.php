<?php

// ************************************************ //
//
//
// Flash Photo Slide Show data file
// This file is used to connect to the database to retrieve the images that will be played by the flash movie.
// The data needs to be sent as xml data.
// The xml structure needs to have a root tag named "gallery" that has an attribute named "duration".
// The "duration" attribute tells how long to display each image. If it is not present in the database, the default shall be 5 seconds.
// A subtag under gallery needs to be "images", which houses the xml tags for each individual image to be in the slide show.
// The tags under the "images" tag are called "image" and have attributes of: "label", "file", and "link".
// The "label" attribute gives the tooltiptext when the mouse hovers over an image.
// The "file" attribute gives the location of the image file the flash movie loads as a slide. If the file does not exist, the flash movie ignores the information in this attribute seamlessly.
// *** NOTE: The "file" attribute must be a path to the image file relative to the flash movie. ***
// The "link" attribute gives the url to send the browser if the user clicks on the image in the slide show (this is reserved for future use at the moment).
//
//
// ************************************************ //


    header("Content-Type: application/xml");
    header("Cache-Control: no-cache");
    header("Expires: -1");
    


    $rootPath = "../../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);


// Send the start of the xml data
    echo '<?xml version="1.0" encoding="utf-8"?>
';


// Here we get the data from the database.
    $showid = 1;
    $data = $bse->db->getQueryData("SELECT * FROM `bseSlideshows` WHERE `id`='$showid'");
    $dur = $data['duration'];
    echo "<gallery duration=\"$dur\">
    <images>
        ";

// Here we get the images that are in the slide show
    $query = $bse->db->getQueryResult("SELECT * FROM `bseSlideshowImages` WHERE `show_id`='$showid' ORDER BY `sorder` ASC");
    while( $data = mysql_fetch_array($query) )
    {
        echo "<image>
            <label>{$data['label']}</label>
            <file>images/{$data['file']}</file>
            <link>{$data['link']}</link>
        </image>
        ";
    }
    echo "
    </images>
</gallery>";
?>