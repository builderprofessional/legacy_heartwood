

<!-- Begin testimonial_data.tpl  -->

<script type="text/javascript">

    function toggleDiv (divID) 
    {
        summaryDiv = 'summary' + divID;
        fullDiv = 'full' + divID;
        if( document.getElementById(fullDiv).style.display == 'block') 
        {
            document.getElementById(fullDiv).style.display = 'none';
            document.getElementById(summaryDiv).style.display = 'block';
        } 
        else 
        {
            document.getElementById(fullDiv).style.display = 'block';
            document.getElementById(summaryDiv).style.display = 'none';
        }
    }

</script>


<?php

	$this->testimonials->sortArray("id", -1);
    
    foreach( $this->testimonials as $testimony )
    {
        echo "
        <div class=\"testimonial\">
";
        $contentString1 = "";
        if( $testimony->image_file != "")
        {
            $previewUrl = $testimony->getPreviewImage();
            $imgUrl = $testimony->getImageHref();
            $contentString1 = "<a href=\"$imgUrl\" rel=\"shadowbox\" title=\"{$testimony->image_caption}\"><img height=\"{$testimony->resizeH}\" width=\"{$testimony->resizeW}\" class=\"testimonial_pic\" src=\"$previewUrl\"></a>";
        } 


    
        if( $testimony->content != "" )
        {
            $cust = $testimony->customerName;
            if( strlen($testimony->content) >= 400) 
            {
                $summary = substr($testimony->content,0,400);
                $summary = $summary.'...<div class="testimonial_more">More ...</div>';
                $contentString2 = '<div class="testimonial_summary" id="summary'.$testimony->id.'">'.$contentString1.$summary.'<div class="clear"></div></div>';
                if( !$this->user->inBackDoor() ) 
                {
                    $contentString2 = "<div class=\"testimonial_moreLink\" onclick=\"toggleDiv('{$testimony->id}')\">".$contentString2."</div>";
                }
            } 
            else 
            {
                $contentString2 = $contentString1.$testimony->content.'<div class="clear"></div>';
            }
            $contentString2 = "<div class=\"testimonial_customer\">$cust</div>$contentString2";
            $contentString3 = '<div class="testimonial_full" id="full'.$testimony->id.'" style="display:none">'."<div class=\"testimonial_moreLink\" onclick=\"toggleDiv('{$testimony->id}')\">".$contentString1.$testimony->content."<div style='text-align:center;font-size:10px;clear:both;'>Close |x|</div></div></div>";
        } 
        else { $contentString2 = ''; $contentString3 = ''; }
        $contentString = $contentString2.$contentString3;
        // Make content link to content editor if logged in
        echo $contentString;
        echo '<div class="spacer"></div>
        </div>
';
    }
    
?>
<!-- End testimonial_data.tpl   -->



