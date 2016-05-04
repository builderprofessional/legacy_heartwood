<?php

// Header Info
    $this->header = $this->fetch('header.tpl');
    echo $this->header;


// Get Page Content
    $this->pageContent = $this->fetch('content.tpl');


// Output Content
?>
                        <div style="width:99%; float:left; margin-top:20px; margin-left:15px; margin-bottom:25px; ">
                            <?= $this->pageContent ?>
                            <div class="mainBody" style="width:100%; ">
                                <div>
                                    <?= $this->fetch("commMap.tpl") ?>
                                </div>
                                <div style='width:100%; clear:both; '></div>
                                <div id='directions'></div>
                            </div>
                        </div>
<?php

// Footer Info
    $this->footer = $this->fetch("footer.tpl");
    echo $this->footer;
/*

?>


<?php
/*  Temporary

                            $adminCode = "";
                            $adminForm = "";
                            if( isset($user) )
                            {
                                if( $user->admin_loggedIn && $_SESSION['frontback'] == "back" )
                                {
                                    $adminCode = "<div class='confInfo' style='width:auto; text-align:right; margin-right:20px; '><a href='editLoc.php?id={$location->id}'>Edit</a> <a style='margin-left:10px;' href='process/deleteLoc.php?id={$location->id}'>Delete</a></div>";
                                    $adminForm = "<form id='editMap' method='post' action='process/saveMap.php' onsubmit=\"document.getElementById('editMap').point.value = map.getCenter();document.getElementById('editMap').zoom.value = map.getZoom();\" style='margin:10px; text-align:right; ' />
                                            <input id='point' name='point' type='hidden' value='' />
                                            <input id='zoom' name='zoom' type='hidden' value='' />
                                            <input name='mapID' type='hidden' value='{$map->MapID}' />
                                            <input name='locID' type='hidden' value='{$location->id}' />
                                            <input name='updateMap' type='submit' value='Save Map' />
                                        </form>";
                                }
                            }
                            

  

                                  <div style='font-weight:700; '>Nearby Businesses</div>
                                    <div style='margin-bottom:20px;'>
                                        <input id='shopCheck' type='checkbox' name='commonSearch' value='shopping' /> <span style='cursor:pointer; ' onclick=\"document.getElementById('shopCheck').checked = !document.getElementById('shopCheck').checked;\">Shopping</span><br />
                                        <input id='grocCheck' type='checkbox' name='commonSearch' value='groceries' /> <span style='cursor:pointer; ' onclick=\"document.getElementById('grocCheck').checked = !document.getElementById('grocCheck').checked;\">Groceries</span><br />
                                        <input id='restCheck' type='checkbox' name='commonSearch' value='restaurant' /> <span style='cursor:pointer; ' onclick=\"document.getElementById('restCheck').checked = !document.getElementById('restCheck').checked;\">Restaurants</span><br />
                                        <input id='pizaCheck' type='checkbox' name='commonSearch' value='pizza' /> <span style='cursor:pointer; ' onclick=\"document.getElementById('pizaCheck').checked = !document.getElementById('pizaCheck').checked;\">Pizza</span><br />
                                        <input id='chnsCheck' type='checkbox' name='commonSearch' value='chinese' /> <span style='cursor:pointer; ' onclick=\"document.getElementById('chnsCheck').checked = !document.getElementById('chnsCheck').checked;\">Chinese</span><br />
                                        <input id='stekCheck' type='checkbox' name='commonSearch' value='steak' /> <span style='cursor:pointer; ' onclick=\"document.getElementById('stekCheck').checked = !document.getElementById('stekCheck').checked;\">Steak</span><br />
                                        <div style='margin-top:4px; font-size:10px; font-weight:900;'>Custom Search</div>
                                        <input type='text' id='searchBox' style='width:150px;' /><br />
                                        <div style='margin-top:8px;'><input type='button' value='Find' onclick=\"buttonOnclick('commonSearch');\" /></div>
                                    </div>
                                    <div style='font-weight:700; '>Get Directions To Here</div>
                                    <div style='font-size:10px;'>Starting Address:</div>
                                    <input type='text' id='startAdrs' style='width:150px; ' /> <input type='button' value='Directions' onclick=\"getDirections(document.getElementById('startAdrs').value);\" />



        if( $this->dirs )
            echo "
                            <div id='dirResults' style='width:550px; margin-top:8px;'></div>
";
        if( $this->search )
            echo "
                            <div id='searchwell' style='display:none; width:550px; height:200px; margin-top:10px; border-top-style:solid; overflow-y:auto; padding-top:10px; '></div>
                            <div id=\"selected\"></div>
";

*/
?>