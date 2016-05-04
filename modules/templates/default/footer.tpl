



<!--  Begin footer.tpl  -->

    <div class="clear"></div>
    <div id="bse_footer_container" >
    <?php
        $this->display("bse_tagline.tpl");
    ?>
    </div id="bse_footer_container">

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