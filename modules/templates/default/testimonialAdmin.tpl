

<script language="javascript" type="text/javascript" src="<?= $this->getFileHref("tb_standalone.js.php") ?>"></script>


    <div>
        <div style="width:100%; text-align:center; "><h2>Edit Testimonies</h2></div>
<?php

    $mediaHref = "";
    foreach( $this->testimonials as $testimony )
    {
        echo '
        <form method="post" action="' . $this->testimonials->getAdminSubmitHref() . '">
            <div style="width:49%; margin:5px .15%; float:left; border:solid 1px; ">
                <input type="hidden" name="testid" value="' . $testimony->id . '" />
                <div class="inputWrapper">
                    <div>Title: </div><input type="text" name="customer" value="' . $testimony->customerName . '" />
                </div>
                <div class="inputWrapper tb_input">
                    <div>Photo (optional):</div><input id="testimony_' . $testimony->id . '" type="text" name="image" value="' .  $testimony->image_file . '" /><img src="' . $this->rootDir . 'iface/browse_btn.png" alt="Browse for file" title="Browse for File" onmouseup="tinyBrowserPopUp(\'image\',\'testimony_' . $testimony->id . '\', \''. urlencode($testimony->getMediaDirHref(false)) . '\');" />
                </div>
                <div class="inputWrapper" style="height:auto; ">
                    <div>Description:</div><textarea name="content">'. $testimony->content . '</textarea>
                </div>
                <div style="float:right; margin:5px; clear:both; ">
                    <input type="button" value="Delete" onmouseup="document.location.href=\'' . $this->testimonials->getAdminSubmitHref() . '?delid=' . $testimony->id . '\';" />
                    <input type="submit" value="Save" name="testimonySave" />
                </div>
            </div>
        </form>
';
        if( @trim($mediaHref) == "" )
        {
            $mediaHref = $testimony->getMediaDirHref(false);
        }
    }   // End foreach
    
    
    if( $mediaHref == "" )
    {
        $testimony = $this->getModule("bseTestimonialItem");
        $mediaHref = $testimony->getMediaDirHref(false);
    }
?>

        <div class="clear"></div>
        <form method="post" action="<?= $this->testimonials->getAdminSubmitHref() ?>">
            <div style="width:65%; margin:5px auto; border:solid 1px; ">
                <div style="width:100%; text-align:center; "><h2>Add New Testimony</h2></div>
                <input type="hidden" name="buildid" value="new" />
                <div class="inputWrapper">
                    <div>Customer: </div><input type="text" name="customer" />
                </div>
                <div class="inputWrapper tb_input">
                    <div>Photo (optional): </div><input id="testimony_new" type="text" name="image" /><img src="<?= $this->rootDir ?>iface/browse_btn.png" alt="Browse for file" title="Browse for File" onmouseup="tinyBrowserPopUp('image','testimony_new', '<?= urlencode($mediaHref) ?>');" />
                </div>
                <div class="inputWrapper" style="height:auto; ">
                    <div>Description:</div><textarea name="content"></textarea>
                </div>
                <div style="float:right; margin:5px; clear:both; ">
                    <input style="width:80px; height:23px; " type="button" value="Cancel" onmouseup="document.location.href='<?= $this->retPage ?>';" />
                    <input style="width:80px; height:23px; " type="submit" value="Save" name="submitTestimony" />
                </div>
                <div class="clear"></div>
            </div>
        </form>
    </div>
