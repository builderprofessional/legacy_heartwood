		foreach ($contentArray as $record => $keyValueArray) 
		{
                    <div class="testimonial">
			<?php
			if ($contentArray[$record]['image'] != "") 
			{ // Add attachment if present
				$contentString1 = '<a href="image.php?image_file='.$contentArray[$record]['image'].'&image_size=large" rel="lightbox[gallery]" title="'.$contentArray[$record]['caption'].'"><img class="testimonial_pic" src="image.php?image_file='.$contentArray[$record]['image'].'&image_size=testimonial"></a>';
			} 
			else { $contentString1 = ''; }

			if ($contentArray[$record]['text'] != "") 
			{ // Add attachment if present
				if (strlen($contentArray[$record]['text']) >= 400) 
				{
					$summary = substr($contentArray[$record]['text'],0,400);
					$summary = $summary.'...<div class="testimonial_more">More ...</div>';
					//$summary_array = explode('</h3>', $contentArray[$record]['text']);
					$contentString2 = '<div class="testimonial_summary" id="summary'.$contentArray[$record]['contentID'].'">'.$summary.'</div>';
					if (!$_SESSION['admin_loggedIn']) 
					{
						$contentString2 = "<a href=\"Javascript:toggleDiv('".$contentArray[$record]['contentID']."')\">".$contentString2."</a>";
					}
				} 
				else 
				{
					$contentString2 = $contentArray[$record]['text'];
				}
				$contentString3 = '<div class="testimonial_full" id="full'.$contentArray[$record]['contentID'].'" style="display:none">'."<a href=\"Javascript:toggleDiv('".$contentArray[$record]['contentID']."')\">".$contentArray[$record]['text']."<div style='text-align:center;font-size:10px'><a href=\"Javascript:toggleDiv('".$contentArray[$record]['contentID']."')\">Close |x|</div></a></div>";
			} 
			else { $contentString2 = ''; $contentString3 = ''; }
			$contentString = $contentString1.$contentString2.$contentString3;
			// Make content link to content editor if logged in
			echo $contentString;
			$contentString = '<a href="edit_content.php?type=testimonials&module='.$module.'&contentID='.$contentArray[$record]['contentID'].'"><span style="font-size:10px">Edit/Move</span></a>';
			if ($_SESSION['admin_loggedIn']) 
			{ ?>
				<div class="edit_layout"><?php
				if (!is_null($previous)) 
				{ ?>
					<a href="edit_layout.php?from=<?php echo $contentArray[$record]['layoutOrder'] ?>&to=<?php echo $previous ?>" target="_self"><img src="iface/edit_layout_images/up.png" alt="Move Up" /></a><?php
				}
				echo makeClickable('Edit/Move', 'mixed', $module, $contentArray[$record]['contentID']);
				if (!is_null($next)) 
				{ ?>
				    <a href="edit_layout.php?from=<?php echo $contentArray[$record]['layoutOrder'] ?>&to=<?php echo $next ?>" target="_self"><img src="iface/edit_layout_images/down.png" alt="Move Down" /></a><?php
				} ?><br />
				<a style="font-size:10px" href="Javascript:deleteContentImage(<?php echo $contentArray[$record]['contentID'] ?>)" title="Delete <?php echo $contentArray[$record]['contentID'] ?>">Delete |x|</a>
				</div><?php
			}
			unset($contentString);
			echo '<div class="spacer"></div>'; ?>
                     </div>
                     <div class="spacer"></div>
                     <?php
		}