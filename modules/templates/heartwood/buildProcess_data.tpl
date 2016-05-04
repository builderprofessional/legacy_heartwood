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







 // loop through each build process items and output their info
    foreach($this->buildProcessItems as $processItem)
    {
    	$title = "<h3 style=\"color:#000; margin:5px auto 0; \">$processItem->title</h3>";
    	if( @trim($processItem->image_file) != "" )
    	{
    		$title = sprintf("
    		<a href=\"" . $processItem->getImageHref() . "\" rel=\"shadowbox[steps2];player=img\" title=\"{$processItem->title}\">%s</a>
    		<div style=\"height:auto; height:53%%; overflow:hidden; padding:0; \">
    			<a href=\"" . $processItem->getImageHref() . "\" rel=\"shadowbox[steps];player=img\" title=\"{$processItem->title}\">
                	<img src=\"". $processItem->getPreviewImage(-1, 250) . "\" alt=\"[{$processItem->title}]\">
                </a>
            </div>", $title);
    	}
        echo "
        <div class=\"build_step\">
        	$title
            <div style='overflow-y:auto;'>{$processItem->description}</div>
		</div>
";
    }





 // Finish
?>

    
<!-- End buildProcess_data.tpl -->