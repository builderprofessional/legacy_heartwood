    <div id="communityLinks"><h3>Locations:</h3>
        <ol type="A">
<?php
    $count = 0;
    $href = "Javascript:map.setCenter(new GLatLng(%s), 10); GEvent.trigger(markers[%s],\"click\");";

    if( $this->user->loggedIn && $this->user->backdoor )
        $href = $this->googleMap->getCommunityEditHref()."?id=%s";

    foreach( $this->googleMap->communities as $comm )
    {  ?>
            <li><a href='<?=( $this->user->loggedIn&&$this->user->backdoor ? sprintf($href, $comm->id) : sprintf($href, $comm->point, $count) )?>' title="<?= $comm->name.' - Home' ?>"><?= $comm->name ?></a>
                <div class="subText">
                    <a href="community_details.php?communityID=<?= $comm->id ?>" title="<?= $comm->name.' - Home' ?>">Details</a> | 
                    <a href="community_directions.php?communityID=<?= $comm->id ?>" title="<?= $comm->name.' - Local Info' ?>">Local Info & Directions</a>
<?php   if( $this->user->loggedIn && $this->user->backdoor ) 
        { echo ' |
                    <a href="Javascript:document.updateLocation.point.value = map.getCenter();document.updateLocation.communityID.value ='.$comm->id.';document.updateLocation.submit()">Move Icon</a>
';
        } ?>
                </div>
            </li>
<?php
        $count++;
    } ?>
        </ol>
    </div>
<?php
    if( $this->user->loggedIn && $this->user->backdoor ) 
    { ?>
        <form name="updateLocation" method="post" action="<?= $this->googleMap->getMoveIconSubmitHref() ?>">
            <input name="point" type="hidden" value="">
            <input name="communityID" type="hidden" value="">
            <input name="updateLocation" type="hidden" value="true">
        </form>
<?php
    }
?>