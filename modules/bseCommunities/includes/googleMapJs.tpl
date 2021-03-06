<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<?= $this->googleMap->SiteKey ?>" type="text/javascript"></script>
<script type="text/javascript">
    var map = null;


    function load()
    {
        if( GBrowserIsCompatible() )
        {
            map = new GMap2(document.getElementById('map'));
            map.setCenter(new GLatLng(<?= $this->googleMap->point ?>), <?=$this->googleMap->zoom?>);
            map.addControl(new GLargeMapControl());
//          map.removeControl(map.eh[1].control);
//          map.removeControl(map.eh[0].control);
        }
        else
           alert("Your Browser is Incompatible with the Map System!\nWe're Sorry, but you will not be able to see the map.");
    }
</script>

<?php
    if( $this->googleMap->useGeoCoder )
    { ?>
<script type="text/javascript">
    var adrs = new GClientGeocoder();

    function adrsCallback(point)
    {
        if( point != null )
        {
            map.setCenter(point, 15);
            map.addOverlay(new GMarker(point));
        } 
        else
        {
            alert("That Address Could Not Be Located.");
        }
    }
</script> <?php
    }     // End if( googleMap->useCeoCoder )


    if( $this->googleMap->useDirections )
    {
        $this->googleMap->resetCode .= "dirs.clear();";
        $this->googleMap->onLoad .= "setDirs();";
        $this->googleMap->useDirections = true;
?>
<script type="text/javascript"> 
    var dirs = null;
    function setDirs()
    {
        dirs = new GDirections(map, document.getElementById('dirResults'));
        GEvent.addListener(dirs, 'error', function(){alert('That Address Was Not Found.');document.getElementById('startAdrs').focus();document.getElementById('startAdrs').select();});
    }
    
    function getDirections(adrs, src)
    {
        if( adrs != '' )
        {
            if( src==null )
                src = true;
                
            var end = '$locAddress'
            var start = adrs;
            if( src==false )
            {
                var temp = start;
                start = end;
                end = temp;
            }
            var query = new Array(start, end);
            dirs.loadFromWaypoints(query);
        }
    }
</script>
<?php
    }  // End if( googleMap->useDirections )


// Begin markers overlay
    if( $this->googleMap->markersOverlay )
    {
        $this->googleMap->onLoad .= 'markersOverlay();';
        $count = 0;
?>        
<script type="text/javascript">

    var baseIcon = null;
    var markers = new Array();
    function markersOverlay()
    {
        // Create a base icon for all of our markers that specifies the
        // shadow, icon dimensions, etc.

        baseIcon = new GIcon();
        baseIcon.shadow = 'http://www.google.com/mapfiles/shadow50.png';
        baseIcon.iconSize = new GSize(20, 34);
        baseIcon.shadowSize = new GSize(37, 34);
        baseIcon.iconAnchor = new GPoint(9, 34);
        baseIcon.infoWindowAnchor = new GPoint(9, 2);
        baseIcon.infoShadowAnchor = new GPoint(18, 25);

        // Creates a marker whose info window displays the letter corresponding
        // to the given index.

        function createMarker(point, index, text, toolTip)
        {  // Create a lettered icon for this point using our icon class

            // Limits number of possible communities on the map to 26
            var letter = String.fromCharCode('A'.charCodeAt(0) + index);
            var communityIcon = new GIcon(baseIcon);
            communityIcon.image = 'http://www.google.com/mapfiles/marker'+letter+'.png';
            var marker = new GMarker(point, communityIcon);
            markers[index] = marker;

            GEvent.addListener(marker, 'infowindowopen', function()
            {
                map.savePosition();
            });

            GEvent.addListener(marker, 'click', function()
            {
                marker.openInfoWindowHtml(text);
            });

            GEvent.addListener(marker, 'mouseover', function()
            {
                Tip(toolTip);
            });

            GEvent.addListener(marker, 'mouseout', function()
            {
                UnTip();
            });

            GEvent.addListener(marker, 'infowindowopen', function()
            {
                UnTip();
            });

            GEvent.addListener(marker, 'infowindowclose', function()
            {
                map.returnToSavedPosition();
            });

            return marker;
        }
<?php
    foreach($this->googleMap->communities as $markerItem)
    {
        $link = "<a href=\"community_details.php?communityID={$markerItem->id}\">Detailed Information</a>";
        $content = '<div class="infoWindow"><div id="title" class="communityMarkerName" style="margin-top:10px; padding:0; font-size:17px; ">'.$markerItem->name.'</div><div id="description" class="confInfo">'.($markerItem->address==""?"":$markerItem->address.'<br />').($markerItem->priceRange==""?"":$markerItem->priceRange.'<br />').($markerItem->sizeRange==""?"":$markerItem->sizeRange.'<br />').$link.'</div></div>';
        echo "\nmap.addOverlay( createMarker( new GLatLng(".$markerItem->point."), ".$count.",\"".str_replace("\n", "", addslashes($content))."\", '".$markerItem->name."'));";
        $count++;
    }
?>

    }
</script>
<?php
    }    // End if( googleMap->markersOverlay )


// Search Overlay
    if( $this->googleMap->searchOverlay )
    {
    $this->googleMap->onLoad .= 'searchOverlay();';
    $this->googleMap->onUnload .= 'GUnload();';
    $this->googleMap->resetCode .= 'clearMap()';
    $count = 0;
 ?>
    <script src="http://www.google.com/uds/api?file=uds.js&amp;v=0.1&amp;key=<?= $this->googleMap->SiteKey ?>" type="text/javascript"></script>
    <script type="text/javascript">
        //<![CDATA[

        // Our global state
        var gLocalSearch;
        var gSelectedResults = [];
        var gCurrentResults = [];
        var okToClear = true;

        // Create our "tiny" marker icon
        var gSmallIcon = new GIcon();
        gSmallIcon.image = "http://labs.google.com/ridefinder/images/mm_20_yellow.png";
        gSmallIcon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
        gSmallIcon.iconSize = new GSize(12, 20);
        gSmallIcon.shadowSize = new GSize(22, 20);
        gSmallIcon.iconAnchor = new GPoint(6, 20);
        gSmallIcon.infoWindowAnchor = new GPoint(5, 1);

        function clearMap()
        {
            // Clear the map and the old search well
            document.getElementById('searchwell').style.display = 'none';
            document.getElementById('searchwell').innerHTML = "";
            for (var i = 0; i < gCurrentResults.length; i++) 
            {
                if (!gCurrentResults[i].selected()) 
                {
                    map.removeOverlay(gCurrentResults[i].marker());
                }
            }
            gCurrentResults = [];
        }
        
        // Set up the map and the local searcher.
        function searchOverlay() 
        {
            var commonSearch = document.getElementById("commonSearch");

            // Initialize the local searcher
            gLocalSearch = new GlocalSearch();
            gLocalSearch.setCenterPoint(map);
            gLocalSearch.setSearchCompleteCallback(null, OnLocalSearch);
            gLocalSearch.setAddressLookupMode(google.search.LocalSearch.ADDRESS_LOOKUP_DISABLED);

        }

        // Called when Local Search results are returned, we clear the old
        // results and load the new ones.
        function OnLocalSearch() 
        {
            if (!gLocalSearch.results) return;
            var searchWell = document.getElementById("searchwell");
            for (var i = 0; i < gLocalSearch.results.length; i++) 
            {
                gCurrentResults.push(new LocalResult(gLocalSearch.results[i]));
            }
        }

        // Cancel the form submission, executing an AJAX Search API search.
        function CaptureForm(form) 
        {
            if (form["q"].value == '') 
            {
                gLocalSearch.execute(form["commonSearch"].value);
            } 
            
            else 
            {
                gLocalSearch.execute(form["q"].value);
            }
            return false;
        }


        function buttonOnclick(elName)
        {
            var element = document.getElementsByName(elName);
            var showIt = false;
            clearMap();
            if( element[0].type = "checkbox" )
            {
                var checks = element;
                for( i = 0; i < checks.length; i++ )
                {
                    if( checks[i].checked )
                    {
                        gLocalSearch.execute(checks[i].value);
                        showIt = true;
                    }
                }
            }
            
            if( document.getElementById('searchBox').value != "" )
            {
                gLocalSearch.execute(document.getElementById('searchBox').value);
                showIt = true;
            }
            
            if( showIt )
                document.getElementById('searchwell').style.display = "block";
        }



        // A class representing a single Local Search result returned by the
        // Google AJAX Search API.
        function LocalResult(result) 
        {
            this.result_ = result;
            this.resultNode_ = this.unselectedHtml();
            document.getElementById("searchwell").appendChild(this.resultNode_);
            map.addOverlay(this.marker(gSmallIcon));
        }

        // Returns the GMap marker for this result, creating it with the given
        // icon if it has not already been created.
        LocalResult.prototype.marker = function(opt_icon) 
        {
            if (this.marker_) return this.marker_;
            var marker = new GMarker(new GLatLng(parseFloat(this.result_.lat),
                                     parseFloat(this.result_.lng)),
                                     opt_icon);
                                     
            var toolTip = this.result_.titleNoFormatting;

            GEvent.addListener(marker, 'infowindowopen', function() {
                UnTip();
                map.savePosition();
            });

            GEvent.addListener(marker, 'infowindowclose', function() {
                map.returnToSavedPosition();
            });
            
            GEvent.addListener(marker, 'mouseover', function() {
                Tip(toolTip);
            });
            
            GEvent.addListener(marker, 'mouseout', function() {
                UnTip();
            });

            GEvent.bind(marker, "click", this, function() 
            {
                marker.openInfoWindow(this.selected() ? this.selectedHtml() : this.unselectedHtml());
/*                var text = "";
                for( prop in this.result_ )
                    text = text + prop+" = "+ this.result_[prop]+"<br />";
                    
                document.getElementById('test').innerHTML = text;
*/            });

            GEvent.bindDom(this.titleNode, "click", this, function()
            {
                this.marker_.openInfoWindow(this.selected() ? this.selectedHtml() : this.unselectedHtml());
            });
            this.marker_ = marker;
            return marker;
        }

        // "Saves" this result if it has not already been saved
        LocalResult.prototype.select = function() 
        {
            if (!this.selected()) 
            {
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
        LocalResult.prototype.unselectedHtml = function() 
        {
            var link = '<a class="confLink" style="text-decoration:underline;" href="javascript:map.closeInfoWindow();getDirections(\''+this.result_.addressLines+'\', false);">Get Directions</a>';

            var container = document.createElement("div");
            container.className = "unselected";

            var infoDiv = document.createElement("div")
            infoDiv.className = "infoWindow";
            
            var titleDiv = document.createElement("div");
            titleDiv.name="title";
            titleDiv.className="confLink confTitle";
            titleDiv.style.cssText="margin-top:10px; padding:0; font-size:17px; cursor:pointer; ";
            titleDiv.innerHTML = this.result_.title;
            infoDiv.appendChild(titleDiv);
            this.titleNode = titleDiv;
            
            var descDiv = document.createElement("div");
            descDiv.className = "confInfo";
            descDiv.innerHTML = this.result_.streetAddress+'<br />'+this.result_.city+', '+this.result_.region+'<br />'+this.result_.phoneNumbers[0].number+'<br />'+link;
            infoDiv.appendChild(descDiv);

            container.appendChild(infoDiv);
/*            var saveDiv = document.createElement("div");
            saveDiv.className = "confInfo";
            saveDiv.innerHTML = "Save this location";
            GEvent.bindDom(saveDiv, "click", this, function() 
            {
                map.closeInfoWindow();
                this.select();
                gSelectedResults.push(this);
            });
            container.appendChild(saveDiv);
*/            return container;
        }

        // Returns the HTML we display for a result after it has been "saved"
        LocalResult.prototype.selectedHtml = function() 
        {
            return this.result_.html.cloneNode(true);
        }

        // Returns true if this result is currently "saved"
        LocalResult.prototype.selected = function() 
        {
            return this.selected_;
        }

        //]]>
    </script>
<?php
    }   // End if( googleMap->searchOverlay )