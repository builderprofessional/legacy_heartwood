<?php
class Google_map extends dbData
{
        public  $Google_key,
                $mapName,
                $mapID,
                $point,
                $zoom,
                $width,
                $height,
                $onLoad,
                $onUnload;
        function __construct ($mapName) 
        {
		// You must obtain a seperate Google map API key from http://www.google.com/apis/maps/signup.html
		// for each domain
		$this->Google_key = 'ABQIAAAATcgO9IiwMxOeDHcSRJw_ThQToQ_lAFIXx2G0osWsmh2A8YSgpBTVY6g_-pmjb23I530-Z6BD-AEVFw';
		
		// iofficeonline.com key
		//$this->Google_key = 'ABQIAAAAQml6wLr0DSD-GDOeGDt_NRSCZq6KUuVXmGRQNhR6KOT_l41blBRuvbVCqmdeDCLp-RkUcZD5AxhXUw';
		$this->onLoad = 'load();';
		$this->onUnload = 'GUnload();';
	}

	function Google_mapJS () {
		// *This must be inserted into the header of any page with a Google map!*
?>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<?php echo $this->Google_key ?>" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
var map = null;
<?php echo $this->JSvars ?>

function load() {
	if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById("map"));
		map.addControl(new GLargeMapControl());
		map.addControl(new GMapTypeControl());
		map.addControl(new GScaleControl());
		map.setCenter(new GLatLng(<?php echo $this->point ?>), <?php echo $this->zoom ?>);
	}
}
//]]>
</script>
<?php
	}


	function communitiesOverlay ($Communities) { // Inserts Google maps JS to show community markers for the given map
		// *This must be called before displayBodyTag() and after Google_mapJS() is run
		$this->onLoad .= 'communitiesOverlay();';
		$count = 0;
		echo "\n<script type=\"text/javascript\">\n" ?>
//<![CDATA[
var baseIcon = null;
var markers = [];
	function communitiesOverlay() {
		// Create a base icon for all of our markers that specifies the
		// shadow, icon dimensions, etc.
		baseIcon = new GIcon();
		baseIcon.shadow = "http://www.google.com/mapfiles/shadow50.png";
		baseIcon.iconSize = new GSize(20, 34);
		baseIcon.shadowSize = new GSize(37, 34);
		baseIcon.iconAnchor = new GPoint(9, 34);
		baseIcon.infoWindowAnchor = new GPoint(9, 2);
		baseIcon.infoShadowAnchor = new GPoint(18, 25);
		// Creates a marker whose info window displays the letter corresponding
		// to the given index.
		function createMarker(point, index, text) {
			// Create a lettered icon for this point using our icon class
			var letter = String.fromCharCode("A".charCodeAt(0) + index); // Limits number of possible communities on the map to 26
			var communityIcon = new GIcon(baseIcon);
			communityIcon.image = "http://www.google.com/mapfiles/marker" + letter + ".png";
			var marker = new GMarker(point, communityIcon);
			GEvent.addListener(marker, "infowindowopen", function() {
				map.savePosition();
			});
			GEvent.addListener(marker, "click", function() {
				marker.openInfoWindowHtml(text);
			});
			GEvent.addListener(marker, "mouseover", function() {
				map.closeInfoWindow();
			});
			GEvent.addListener(marker, "infowindowclose", function() {
				map.returnToSavedPosition();
			});
			return marker;
		}
		<?php
		while ($row_Communities = mysql_fetch_assoc($Communities)) {
			if ($row_Communities['infoWindowImage'] != '') {
				$infoWindowImage = '<img src="image.php?image_file='.$row_Communities['infoWindowImage'].'&image_size=infoWindow">';
			}
			$content = '';
			if ($_SESSION['admin_loggedIn']) {
				$content = // infoWindow admin content
					'<div class=infoWindow>'
						.'<form action=community_locator.php?show=infoWindow method=POST enctype=multipart/form-data name=updateCommunity>'
						.'Title: <input name=communityName type=text value="'.$row_Communities['communityName'].'">'
						.'<div id=description>'
							.'Description:<br /><textarea name=communityDescription cols=20 rows=2>'.$row_Communities['communityDescription'].'</textarea>'
						.'</div>'
						.'<input name=communityID type=hidden value='.$row_Communities['communityID'].'>'
						.'<input name=reset type=reset value=Reset><input name=submit type=submit value=Update>'
						.'</form>'
					.'</div>';
			} else { // infoWindow public content
				$content =
					'<div class="infoWindow">'
						.'<h4>'.$row_Communities['communityName'].'</h4>'
						.'<p>'
							.$row_Communities['communityDescription']
						.'</p>'
					.'</div>';
			}/*
			$text =
			'<table border=0 cellpadding=0 cellspacing=0><tr><td><img name=top_left src=Images/top_left.gif width=20 height=20 border=0></td><td style="background-image:url(Images/top.gif)">&nbsp;</td><td><img name=top_right src=Images/top_right.gif width=20 height=20 border=0></td></tr>'
  			.'<tr><td style="background-image:url(Images/left.gif)">&nbsp;</td>'
					.'<td style="background-image:url(Images/content.gif)">'.$content.'</td>'
					.'<td style="background-image:url(Images/right.gif)">&nbsp;</td></tr>'
				.'<tr><td><img name=bottom_left src=Images/bottom_left.gif width=20 height=20 border=0></td><td style="background-image:url(Images/bottom.gif)">&nbsp;</td><td><img name=bottom_right src=Images/bottom_right.gif width=20 height=20 border=0></td></tr>'
			.'</table>';*/
			echo "\n"; ?>
			markers[<?php echo $count ?>] = createMarker(new GLatLng(<?php echo $row_Communities['point'] ?>), <?php echo $count ?>, <?php echo '"'.addslashes($content).'"' ?>);
			map.addOverlay(markers[<?php echo $count ?>]);<?php
			if ($_GET['communityID'] == $row_Communities['communityID']) { ?>
			GEvent.trigger(markers[<?php echo $count ?>],"click");<?php
			}
			$count++;
			unset($infoWindowImage);
		}
		echo "}\n
//]]>\n
</script>\n";
	}
	function searchOverlay () { // Inserts Google maps JS to show community markers for the given map
		// *This must be called before displayBodyTag() and after Google_mapJS() is run
		$this->onLoad .= 'searchOverlay();';
		$this->onUnload .= 'GUnload();';
		$count = 0; ?>
<style type="text/css">
    form {
		margin: 0;
		padding: 0;
		display: inline;
    }
	#search {
		margin: 5px;
		padding: 0;
		font-size: small;
	}
    #results {
		margin: 0;
		padding: 7px;
		font-size: small;
    }
    #searchwell {
    }
    #searchwell .unselected {
      background-image: url("http://labs.google.com/ridefinder/images/mm_20_yellow.png");
      background-repeat: no-repeat;
      background-position: top left;
      float:left;
    }
    .gs-city {
      display: inline;
    }
    .gs-region {
      display: inline;
	  margin-left: .25em;
    }
    .gs-country {
      display: none;
    }
    .gs-phone {
      display: block;
    }
    .gs-directions {
      display: none;
    }
    .gs-directions-to-from .gs-secondary-link {
      display: inline;
    }
    .gs-directions-to-from .gs-spacer {
      display: inline;
	  margin-left: .25em;
	  margin-right: .25em;
    }
    .gs-watermark {
      display: none;
    }
    #searchwell .select {
      display: none;
    }
    .unselected {
    	background-color:#fff;
        clear:both;
    }
    .unselected .select {
      display: none;
    }
    #selected {
      margin-top: 1em;
    }
    #selected .gs-result {
      background-image: url("http://www.google.com/mapfiles/icon.png");
      background-repeat: no-repeat;
      background-position: top left;
	  background-color: #ffffff;
    }
    </style>
<script src="http://www.google.com/uds/api?file=uds.js&amp;v=0.1&amp;key=<?php echo $this->Google_key ?>" type="text/javascript"></script>
    <script type="text/javascript">
    //<![CDATA[

    // Our global state
    var gLocalSearch;
    var gSelectedResults = [];
    var gCurrentResults = [];

    // Create our "tiny" marker icon
    var gSmallIcon = new GIcon();
    gSmallIcon.image = "http://labs.google.com/ridefinder/images/mm_20_yellow.png";
    gSmallIcon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
    gSmallIcon.iconSize = new GSize(12, 20);
    gSmallIcon.shadowSize = new GSize(22, 20);
    gSmallIcon.iconAnchor = new GPoint(6, 20);
    gSmallIcon.infoWindowAnchor = new GPoint(5, 1);

    // Set up the map and the local searcher.
    function searchOverlay() {
      var input = document.getElementById("q");
      var commonSearch = document.getElementById("commonSearch");
      //input.focus();

      // Initialize the local searcher
      gLocalSearch = new GlocalSearch();
      gLocalSearch.setCenterPoint(map);
      gLocalSearch.setSearchCompleteCallback(null, OnLocalSearch);

      // Execute the initial search
      gLocalSearch.execute(commonSearch.value);
    }

    // Called when Local Search results are returned, we clear the old
    // results and load the new ones.
    function OnLocalSearch() {
      if (!gLocalSearch.results) return;
      var searchWell = document.getElementById("searchwell");

      // Clear the map and the old search well
      searchWell.innerHTML = "";
      for (var i = 0; i < gCurrentResults.length; i++) {
        if (!gCurrentResults[i].selected()) {
          map.removeOverlay(gCurrentResults[i].marker());
        }
      }

      gCurrentResults = [];
      for (var i = 0; i < gLocalSearch.results.length; i++) {
        gCurrentResults.push(new LocalResult(gLocalSearch.results[i]));
      }

      // move the map to the first result
      var first = gLocalSearch.results[0];
      map.recenterOrPanToLatLng(new GPoint(parseFloat(first.lng), parseFloat(first.lat)));

    }

    // Cancel the form submission, executing an AJAX Search API search.
    function CaptureForm(form) {
			if (form["q"].value == '') {
				gLocalSearch.execute(form["commonSearch"].value);
			} else {
				gLocalSearch.execute(form["q"].value);
			}
      return false;
    }


    // A class representing a single Local Search result returned by the
    // Google AJAX Search API.
    function LocalResult(result) {
      this.result_ = result;
      this.resultNode_ = this.unselectedHtml();
      document.getElementById("searchwell").appendChild(this.resultNode_);
      map.addOverlay(this.marker(gSmallIcon));
    }

    // Returns the GMap marker for this result, creating it with the given
    // icon if it has not already been created.
    LocalResult.prototype.marker = function(opt_icon) {
      if (this.marker_) return this.marker_;
      var marker = new GMarker(new GLatLng(parseFloat(this.result_.lat),
                                         parseFloat(this.result_.lng)),
                               opt_icon);
      GEvent.bind(marker, "click", this, function() {
        marker.openInfoWindow(this.selected() ? this.selectedHtml() :
                                                this.unselectedHtml());
      });
      this.marker_ = marker;
      return marker;
    }

    // "Saves" this result if it has not already been saved
    LocalResult.prototype.select = function() {
      if (!this.selected()) {
        this.selected_ = true;

        // Remove the old marker and add the new marker
        map.removeOverlay(this.marker());
        this.marker_ = null;
        map.addOverlay(this.marker(G_DEFAULT_ICON));

        // Add our result to the saved set
        document.getElementById("selected").appendChild(this.selectedHtml());

        // Remove the old search result from the search well
        this.resultNode_.parentNode.removeChild(this.resultNode_);
      }
    }

    // Returns the HTML we display for a result before it has been "saved"
    LocalResult.prototype.unselectedHtml = function() {
      var container = document.createElement("div");
      container.className = "unselected";
      container.appendChild(this.result_.html.cloneNode(true));
      var saveDiv = document.createElement("div");
      saveDiv.className = "select";
      saveDiv.innerHTML = "Save this location";
      GEvent.bindDom(saveDiv, "click", this, function() {
        map.closeInfoWindow();
        this.select();
        gSelectedResults.push(this);
      });
      container.appendChild(saveDiv);
      return container;
    }

    // Returns the HTML we display for a result after it has been "saved"
    LocalResult.prototype.selectedHtml = function() {
      return this.result_.html.cloneNode(true);
    }

    // Returns true if this result is currently "saved"
    LocalResult.prototype.selected = function() {
      return this.selected_;
    }

    //]]>
    </script><?php
	}
	function displayBodyTag () {
		// *This must be inserted into the body tag of any page with a Google map!*
		echo 'onload="'.$this->onLoad.'" onunload="'.$this->onUnload.'"';
	}
	function displayGoogle_map () { ?>
<div>
	<div style="text-align:center">
	<a href="" onMouseover="map.setCenter(new GLatLng(<?php echo $this->point ?>), <?php echo $this->zoom ?>);">Re-center map</a> |
	<a href="" onMouseover="map.closeInfoWindow();">Close windows</a>
    </div>
	<div id="map" style="width: <?php echo $this->width ?>px; height: <?php echo $this->height ?>px;margin:10px auto"></div>
</div>
<?php
		if ($_SESSION['admin_loggedIn'] && $_SERVER['PHP_SELF'] != '/community_directions.php') { // Display map editor
?>
<form name="addCommunity" method="post" onsubmit="document.addCommunity.point.value = map.getCenter();" style="margin:20px" />
	<input name="addCommunity" type="submit" value="Add Community" />
	<input id="placementType" name="placementType" type="hidden" value="point" />
	<input id="point" name="point" type="hidden" value="" />
	<input name="mapID" type="hidden" value="<?php echo $this->mapID ?>" />
</form>
<form name="editMap" method="post" onsubmit="document.editMap.point.value = map.getCenter(); document.editMap.zoom.value = map.getZoom();" style="margin:20px" />
	<input id="point" name="point" type="hidden" value="" />
	<input id="zoom" name="zoom" type="hidden" value="" />
	<div style="margin:5px">Width: <input name="width" type="text" value="<?php echo $this->width ?>" /></div>
	<div style="margin:5px">Height: <input name="height" type="text" value="<?php echo $this->height ?>" /></div>
	<input name="mapID" type="hidden" value="<?php echo $this->mapID ?>" />
	<input name="updateMap" type="submit" value="Save Map" />
</form>
<?php
		}
	}
} ?>