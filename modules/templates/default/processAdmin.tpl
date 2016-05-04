

<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>
<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("dragdrop.js") ?>"></script>
<script type="text/javascript">


//Browser Support Code
function ajaxConnection()
{
    var ajaxRequest;  // The variable that makes Ajax possible!
    
    try
    {
        // Opera 8.0+, Firefox, Safari
        ajaxRequest = new XMLHttpRequest();
    } 
    catch (e)
    {
        // Internet Explorer Browsers
        try
        {
            ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
        } 
        catch (e) 
        {
            try
            {
                ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
            } 
            catch (e)
            {
                // Something went wrong
                alert("Your browser broke!");
                return false;
            }
        }
    }
    return ajaxRequest;
}



    function objectDropped(container)
    {
        var index = 0;
        var out = "";
        var sendData = false;
        
        for( i=0; i < container.childNodes.length; i++)
        {
            if( typeof(container.childNodes[i].getAttribute) != "undefined" )
            {
                if( container.childNodes[i].getAttribute('dragable') == "dragable" )
                {
                    if( document.getElementById('sorder'+index) )
                    {
                        var inputEl = document.getElementById('sorder' + index);
                        if( inputEl.value != container.childNodes[i].getAttribute('processID') )
                        {
                        	inputEl.value = container.childNodes[i].getAttribute('processID');
                        	sendData = true;
                        }
                        out += "sorder[" + index + "]=" + container.childNodes[i].getAttribute('processID') + "&";
                    }
                    else
                        alert("index = '" + index + "'");

                    index++
                }
           }
        }

        if( !sendData )
        {
            //alert("Not Sending Data");
            return;
        }
        
        out += "processSorderSubmit=true";
        //alert(out);	// This will alert you of what is being posted to the server

        http = ajaxConnection();
        
        http.open("POST", '<?= $this->buildProcessItems->getAdminSubmitHref() ?>', true);

        //Send the proper header information along with the request
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", out.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() 
        {//Call a function when the state changes.
            if(http.readyState == 4 )
            {
                if( http.status != 200) 
                    alert("Error Saving Data: Please Click the Save Button Again.");
                //else
                    //alert(http.responseText);		// This will alert you of what the processing page said
            }
        }
        http.send(out);


    }
    
</script>

	<div>
    	<div class="DragContainer" id="DragContainer1">
<?php

	$counter = 0;
    foreach( $this->buildProcessItems as $buildProcess )
    {
        echo '
            <div processID="'.$buildProcess->id.'" dragable="dragable" class="detailGalleryImage" style="width:45%; margin:5px 2.2%; float:left; border:solid 1px; ">
                <form method="post" action="' . $this->buildProcessItems->getAdminSubmitHref() . '">
                	<input id="sorder'.$counter.'" type="hidden" name="sorder['.$counter.']" value="'.$buildProcess->id.'" />
                    <input type="hidden" name="buildid" value="' . $buildProcess->id . '" />
                    <div class="inputWrapper">
                        <div>Title: </div><input onmouseup="if( !this.hasFocus ) {this.focus(); this.select(); this.hasFocus = true; } " onblur="this.hasFocus = false; " type="text" name="title" value="' . $buildProcess->title . '" />
                    </div>
                    <div class="inputWrapper tb_input">
                        <div>Photo: </div><input onmouseup="if( !this.hasFocus ) {this.focus(); this.select(); this.hasFocus = true; } " onblur="this.hasFocus = false; " style="margin-left:15px; " id="buildStep_' . $buildProcess->id . '" type="text" name="image" value="' .  $buildProcess->image_file . '" /><img src="' . $this->rootDir . 'iface/browse_btn.png" alt="Browse for file" title="Browse for File" onmouseup="tinyBrowserPopUp(\'image\',\'buildStep_' . $buildProcess->id . '\', \''. urlencode($buildProcess->getMediaDirHref(false)) . '\');" />
                    </div>
                    <div class="inputWrapper" style="height:auto; ">
                        <div>Description:</div><textarea onmouseup="if( !this.hasFocus ) {this.focus(); this.select(); this.hasFocus = true; } " onblur="this.hasFocus = false; " name="description">'. $buildProcess->description . '</textarea>
                    </div>
                    <div style="float:right; margin:5px; clear:both; ">
                        <input type="button" value="Delete" onmouseup="document.location.href=\'' . $this->buildProcessItems->getAdminSubmitHref() . '?delid=' . $buildProcess->id . '\';" />
                        <input type="submit" value="Save" name="processSave" />
                    </div>
                </form>
                <div class="clear"></div>
            </div>
';
        $counter++;
    }   // End foreach
    
    $buildProcess = $this->getModule("bseBuildProcessItem");
?>
		
        	<div class="clear"></div>
        </div>
        <form method="post" action="<?= $this->buildProcessItems->getAdminSubmitHref() ?>">
            <div style="width:45%; margin:5px auto; border:solid 1px; clear:both; ">
                <div style="width:100%; text-align:center; "><h2>Add New Build Process Step</h2></div>
                <input type="hidden" name="buildid" value="new" />
                <div class="inputWrapper">
                    <div>Title: </div><input type="text" name="title" value="" />
                </div>
                <div class="inputWrapper tb_input">
                    <div>Photo: </div><input style="margin-left:15px; " id="buildStep_new" type="text" name="image" value="" /><img src="<?= $this->rootDir ?>iface/browse_btn.png" alt="Browse for file" title="Browse for File" onmouseup="tinyBrowserPopUp('image','buildStep_new', '<?= urlencode($buildProcess->getMediaDirHref(false)) ?>');" />
                </div>
                <div class="inputWrapper" style="height:auto; ">
                    <div>Description:</div><textarea name="description"></textarea>
                </div>
                <div style="float:right; margin:5px; clear:both; ">
                    <input style="width:80px; " type="button" value="Cancel" onmouseup="document.location.href='<?= $this->retPage ?>';" />
                    <input style="width:80px; " type="submit" value="Save" name="submitBuildProcess" />
                </div>
                <div class="clear"></div>
            </div>
        </form>
    </div>
