<?php
class bseGoogleMap extends dbData
{
    public  $SiteKey,
            $onLoad,
            $onUnload,
            $resetCode,
            $dirs,
            $search;




      /////////////////////////////////////////////////////////////////////////////////////////////
      // constructor

    function __construct($dbConn, $pMapID )
    {
        $rsMap = dbResource( "SELECT * FROM maps WHERE mapID=".$pMapID, $this->dbCon );
        if( $rowMap = mysql_fetch_assoc( $rsMap ))
        {
            $this->MapID = $pMapID;
            $this->MapName = $rowMap['mapName'];
            $this->Point = $rowMap['point'];
            $this->Zoom = $rowMap['zoom'];
            $this->Width = $rowMap['width'];
            $this->Height = $rowMap['height'];
            $this->resetCode = "map.closeInfoWindow();map.setCenter(new GLatLng(".$this->Point."),".$this->Zoom.");";
            $this->dirs = $this->search = false;
        }

// If developing on your own local server, feel free to include your site and key in this if/then statement,
// however, please leave all other site/key combinations in tact. Thank you.
        if( $_SERVER['SERVER_NAME'] == "www.projects.lss" )     // John Beavers' development server site key
            $this->SiteKey = "ABQIAAAA8gHuR8HkA7Q0StaF1dsHLxSEkczr6xqZJ1A5FHkthOkUcUs6wxRH866kAbcLlfFV7Ey88HiH_tIosg";
        elseif( stripos($_SERVER['SERVER_NAME'], "websiteinprogress.us") !== false )    // websiteinprogress.us site key
            $this->SiteKey = "ABQIAAAAuD71eDDeMkSpfRrXqb5jKBQixRN4q1S8a0AbCK4zgMM-FAZwbBSFt4UHuJ0n_0GwJpqrN5Swe5WNow";
        else  // srnexus.com site key
            $this->SiteKey = "ABQIAAAAuD71eDDeMkSpfRrXqb5jKBTPL0Hvfq3D0uZ1y05hIuNVu6qpUxTRV0BmC4jql5adNK7o-i6H4Ar1gA";

        $this->onLoad = 'load();';
        $this->onUnload = 'GUnload();'; 
    }





      //////////////////////////////////////////////////////////////////////////////////////////////
      // page methods

      function getGoogleMapJsTemplateHref()
      {
          return $this->rootPath.$this->storeDir."includes/googleMapJs.tpl";
      }
      
      
      function getToolTipScriptTag()
      {
        // Outputs the correct script tag for the custom tooltips
        // ** Must be called AFTER setting the body tag **
        echo "<script src=\"{$this->rootPath}{$this->storeDir}includes/wz_tooltip.js\" type=\"text/javascript\"></script>";
      }
      
      



    function getBodyLoadUnloadTags ()
    {
        // *This must be inserted into the body tag of any page with a Google map!*
        return "onload=\"{$this->onLoad}\" onunload=\"{$this->onUnload}\"";
    }

}
?>
