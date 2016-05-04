<table cellspacing=0 cellpadding=0 border=0 style="table-layout:auto; width:100%; ">
    <tr>
        <td style="vertical-align:top; ">
            <div style="text-align:center;border-style:solid; ">
                <span class="commMapLink"><a class="commMapLink" href="javascript:map.setCenter(new GLatLng(<?=$this->googleMap->point?>));">Re-Center</a> | <a href="javascript:<?= $this->googleMap->resetCode?>">Reset Map</a> | <a href="javascript:map.closeInfoWindow();">Close windows</a></span>
                <? echo $this->fetch($this->googleMap->getGoogleMapTemplateHref()); ?>
            </div>
<?php
    if( $this->mapsCount > 1 || ($this->user->loggedIn && $this->user->backdoor) )
    {
echo "
            <div id=\"mapselect\" class=\"commMapSelect\">
                See our other community maps 
                <select name=\"mapSelect\" style=\"width:190px; float:right; \" onchange=\"document.location.href='index.php?mapid='+this.options[this.selectedIndex].value;\">
                    ";
        if( $this->user->loggedIn && $this->user->backdoor )
            echo "<option>Select a Map to Edit</opion>
                     <option value=\"new\">New Map</option>
                     ";
        foreach( $this->mapsData as $mapItem )
        {
            $selected = "";
            if( $mapItem->id == $this->googleMap->id ) {$selected = 'selected="selected"'; }
            echo "<option value=\"{$mapItem->id}\" $selected>{$mapItem->mapName}</option>
                    ";
        }
        echo "
                </select>
            </div>";
    }
?>

<?php if( $this->user->loggedIn && $this->user->backdoor ) { ?>
            <div class="norm" id="formDiv" style="width:100%; text-align:center; margin-top:10px; font-size:12px;">
                Use this form to set the map to your likings.
                Move the map to the desired location, zoom to the desired amount, enter a name for this map, then click the "Save" button.<br /><br />
                To move a community icon, move the map so the center of the map is where you want the icon, then click the "Move Icon" link in the community list to the right.<br /><br />
                To add a new community, position the map so the center of the map is where you want the new community then click the "Add New" button.<br /><br />
                <form method="post" action="<?= $this->googleMap->getFormSubmitHref() ?>" onsubmit="this.mapCenter.value=map.getCenter(); this.mapZoom.value=map.getZoom();" style="display:inline; ">
                    <input type="hidden" name="mapid" value="<?= $this->googleMap->id ?>" />
                    <input type="hidden" name="mapCenter" value="" />
                    <input type="hidden" name="mapZoom" value="" />
                    Name: <input style="width:150px;" type="text" name="mapName" value="<?= $this->googleMap->mapName ?>" /> <input type="submit" name="mapSaveSubmit" value="Save" style="width:80px; " /></form> <form style="display:inline; " method="post" action="<?=$this->googleMap->getFormSubmitHref() ?>" onsubmit="return confirm('Do you really want to delete this map?'); "><input type="hidden" name="delid" value="<?= $this->googleMap->id ?>" /><input style="width:80px;" type="submit" name="delMapSubmit" value="Delete" /></form> <form style="display:inline; " method="post" action="<?= $this->googleMap->getFormSubmitHref() ?>" onsubmit="this.iconLocation.value=map.getCenter();" /><input type="hidden" name="iconLocation" value="" /><input type="hidden" name="mapid" value="<?=$this->googleMap->id?>" /><input type="submit" name="addCommunity" value="Add New" style="width:80px;" /></form>
            </div>
<?php } 

echo "        </td>\n";

    if( $this->googleMap->searchOverlay )
    { ?>
        <td class="confInfo" style="padding-left:15px; vertical-align:top; ">
            <div style="font-weight:700; ">Nearby Businesses</div>
            <div style="margin-bottom:20px; ">
                <input id="shopCheck" type='checkbox' name='commonSearch' value='shopping' /> <span style='cursor:pointer; ' onclick="document.getElementById('shopCheck').checked = !document.getElementById('shopCheck').checked;">Shopping</span><br />
                <input id="grocCheck" type='checkbox' name='commonSearch' value='groceries' /> <span style='cursor:pointer; ' onclick="document.getElementById('grocCheck').checked = !document.getElementById('grocCheck').checked;">Groceries</span><br />
                <input id="restCheck" type='checkbox' name='commonSearch' value='restaurant' /> <span style='cursor:pointer; ' onclick="document.getElementById('restCheck').checked = !document.getElementById('restCheck').checked;">Restaurants</span><br />
                <input id="pizaCheck" type='checkbox' name='commonSearch' value='pizza' /> <span style='cursor:pointer; ' onclick="document.getElementById('pizaCheck').checked = !document.getElementById('pizaCheck').checked;">Pizza</span><br />
                <input id="chnsCheck" type='checkbox' name='commonSearch' value='chinese' /> <span style='cursor:pointer; ' onclick="document.getElementById('chnsCheck').checked = !document.getElementById('chnsCheck').checked;">Chinese</span><br />
                <input id="stekCheck" type='checkbox' name='commonSearch' value='steak' /> <span style='cursor:pointer; ' onclick="document.getElementById('stekCheck').checked = !document.getElementById('stekCheck').checked;">Steak</span><br />
                <div style='margin-top:4px; font-size:10px; font-weight:900;'>Custom Search</div>
                <input type='text' id='searchBox' style='width:150px;' /><br />
                <div style='margin-top:8px;'><input type='button' value='Find' onclick=\"buttonOnclick('commonSearch');\" /></div>
            </div>
            <div style='font-weight:700; '>Get Directions To Here</div>
            <div style='font-size:10px;'>Starting Address:</div>
            <input type='text' id='startAdrs' style='width:150px; ' /> <input type='button' value='Directions' onclick="getDirections(document.getElementById('startAdrs').value);" />
        </td>
<?php
    }   // End if( googleMap->searchOverlay )
    else if( $this->hideCommList == false )
    {
        echo "<td class=\"confInfo\" style=\"padding-left:15px; vertical-align:top; width:60%; \">".$this->fetch($this->googleMap->getCommunitiesListTemplateHref())."</td>";
    }
?>
    </tr>
</table>
<?php
    if( $this->googleMap->useDirections )
        echo "
            <div id='dirResults' style='width:550px; margin-top:8px;'></div>
            ";

    if( $this->googleMap->searchOverlay )
        echo "
            <div id='searchwell' style='display:none; width:550px; height:200px; margin-top:10px; border-top-style:solid; overflow-y:auto; padding-top:10px; '></div>
            <div id=\"selected\"></div>
            ";
?>