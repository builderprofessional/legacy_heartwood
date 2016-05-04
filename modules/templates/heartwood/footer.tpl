



<!--  Begin footer.tpl  -->


        </div>
        <div class="clear"></div>
        <div id="bse_footer_container" >
            <div style="float:left; width:250px; ">
                <a href="http://www.nhab.org" target="_blank">
                    <img src="<?php echo $this->rootDir; ?>iface/nahb.jpg" style="height:35px; "/>
                </a>
                <a href="http://www.texasbuilders.org" target="_blank">
                    <img src="<?php echo $this->rootDir; ?>iface/tab_h.jpg" style="height:35px; " />
                </a>
                <a href="http://www.ghba.org/" taget="_blank">
                    <img src="<?php echo $this->rootDir; ?>iface/ghba.jpg" style="height:35px; " />
                </a>
                <img src="<?php echo $this->rootDir; ?>iface/cbc_ghba.jpg" style="height:35px; " />
            </div>
            <div class="clear"></div>
        <?php
            $this->display("bse_tagline.tpl");
        ?>
        </div id="bse_footer_container">
    </div>
</body>
<script type="text/javascript">

    <?= ( $this->googleMap == null ? "" : $this->googleMap->onLoad ) ?>

    Shadowbox.init();
    
    try
    {
        new JsDatePick({
            useMode:2,
            target:"ev_dateInput",
            isStripped:false,
            dateFormat:"%Y-%m-%d",
            imgPath:"modules/includes/js/jsdatepick-calendar/img/"
        });
    }
    catch(e)
    {
        // file probably not included, just ignore this
    }


</script>
</html>

<!-- End footer.tpl -->