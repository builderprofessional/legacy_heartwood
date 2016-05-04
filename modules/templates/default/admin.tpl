<?php

        $resetText = str_replace( "\r", "", str_replace( "\n", "", str_replace( "'", "\\'", $this->content->code ) ) );
        $resetTitle = str_replace( "\n", "", str_replace( "'", "\\'", $this->content->title ) );
        $resetDesc = str_replace("\n", "", str_replace("'", "\\'", $this->content->metaDesc));
        $resetWords = str_replace("\n", "", str_replace("'", "\\'", $this->content->metaKeywords));
?>
    <script type="text/javascript">
        var data = new Array();
        data['code'] = '<?= $resetText ?>';
        data['title'] = '<?= $resetTitle ?>';
        data['desc'] = '<?= $resetDesc ?>';
        data['words'] = '<?= $resetWords ?>';
        var tinyMCE;
    </script>

<?php

		if( $this->admin->displayEditBox != false )
		{
           echo $this->admin->getTinyMceInitCode();
		}
?>
        <div style="font-size:13px; width:<?= $this->admin->editWidth ?>px; clear:both; border:solid 1px; float:left; ">
            <form id="pageEdit" method="post" action="<?= $this->admin->getSaveFormActionPage() ?>">
                <input type="hidden" name="page" value="<?= $this->page ?>" />
                <input type="hidden" name="contentid" value="<?= $this->content->id ?>" />
                
                <?php if( $this->admin->displayEditBox != false ): ?>
                <textarea id="mceBox" name="code" style="float:left; "><?= $this->content->code ?></textarea>
                <?php endif; ?>
                <div style="width:<?= $this->admin->editWidth ?>px; margin-left:auto; margin-right:auto; margin-top:15px; ">
                    <div style="float:left; width:47%; ">
                        <div>Page Description:</div>
                        <textarea id='pgeDesc' style="width:100%; height:60px; " name="pgeDesc"><?= $this->content->metaDesc ?></textarea>
                    </div>
                    <div style="float:right; width:47%; margin-right:5px; ">
                        <div>Page Keywords (Separate with commas)</div>
                        <textarea id='pgeWords' style="width:100%; height:60px; " name="pgeKeywords"><?= $this->content->metaKeywords ?></textarea>
                    </div>
                    <div style="clear:both;"></div>
                </div>
                <div style="width:100%; text-align:right; margin-left:auto; margin-right:auto; margin-top:15px; text-align:right; ">
                    Page Title:<input id='pgeTitle' type="text" name="pgeTitle" value="<?= $this->content->title ?>" style="width:85%; margin-left:10px; " />
                </div>
                <div style="width:100%; text-align:right; margin-left:auto; margin-right:auto; margin-top:15px; margin-bottom:20px; "><input type="button" value="Reset" onclick="resetInfo();" /> <input type="submit" value="Save" /></div>
            </form>
            <div style="width:100%; clear:both; "></div>
        </div>
        <div style="width:100%; clear:both; "></div>
