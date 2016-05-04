<!-- Begin buildProcess_data.tpl -->

<?php

/***********************************************************

Module Info:

  Modules Used:
    Common Modules for all pages:
     (
      $this variable = bse module
      $this->user = bseUser
     )

    Required Modules:
     (
      $this->buildProcessItems = bseBuildProcessItems
     )

***********************************************************/


 // Setup the build process items container
?>

    <div id="buildProcessContainer"> 
<?php
    





 // loop through each build process items and output their info
    $switch = 0;
    foreach($this->buildProcessItems as $processItem)
    {
    	$title = "<h3>$processItem->title</h3>";
    	if( @trim($processItem->image_file) != "" )
    	{
    		$title = sprintf("<a href=\"" . $processItem->getImageHref() . "\" rel=\"shadowbox[steps];player=img\" title=\"{$processItem->title}\">%s
                <img src=\"". $processItem->getPreviewImage(-1, 500) . "\" alt=\"[{$processItem->description}]\">
            </a>", $title);
    	}
        echo "
        <div class=\"build_step\">
			<hr style=\"margin-top:50px; margin-bottom:-12px; \"/>
        	$title
            <div>{$processItem->description}</div>
		</div>
";
        $switch++;
        
        if( $switch > 1 )
        {
            echo '<div class="clear"></div>';
            $switch = 0;
        }
    }





 // Finish
?>
    </div>

    
<!-- End buildProcess_data.tpl -->