



<!--  Begin footer.tpl  -->

		</div>
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