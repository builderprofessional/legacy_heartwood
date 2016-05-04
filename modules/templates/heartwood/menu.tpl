<script type="text/javascript" src="<?= $this->getFileHref("jquery.fittext.js") ?>"></script>

<script type="text/javascript">
    var menuHidden = false;

    $(window).resize( function()
    {
        $(".nav_item").fitText(1.5);
    });

    $(document).ready( function()
    {
        $(".nav_item").fitText(1.5);
        $("#nav").css("visibility", "visible");
    });
    
</script> 
<?php if( $this->curPage == "index.php" ): ?>
    <div id="slidesControlPanel">
        <img src="<?php echo $this->rootDir; ?>iface/prevSlide.png"      onmouseover="Tip('Previous Slide');" onmouseout="UnTip();" onmouseup="$('#slideshowBox').cycle('prev');" />
        <img src="<?php echo $this->rootDir; ?>iface/playPauseSlide.png" onmouseover="if( slidePaused ){Tip('Resume Show');}else{Tip('Pause Show');}" onmouseout="UnTip();" onmouseup="if( slidePaused ){ $('#slideshowBox').cycle('resume');$('#slideshowBox').cycle('next'); } else{ $('#slideshowBox').cycle('pause'); slidePaused=true; }" />
        <img src="<?php echo $this->rootDir; ?>iface/minimizeSlide.png"  onmouseover="if( menuHidden ){Tip('Show Menu');}else{Tip('Hide Menu');}" onmouseout="UnTip();" onmouseup="if( menuHidden ){ $('#navContainer').slideDown(200); }else{ $('#navContainer ').slideUp(200); }; menuHidden = !menuHidden; "/>
        <img src="<?php echo $this->rootDir; ?>iface/nextSlide.png"      onmouseover="Tip('Next Slide');" onmouseout="UnTip();" onmouseup="$('#slideshowBox').cycle('next');" />
    </div>
<?php endif; ?>
   


    <script type="text/javascript">

        var menus = new Array();
        menus["menu1"] = new Object();

        menus["menu1"].divId = "menu1";
        menus["menu1"].outTimer = 0;
        menus["menu1"].showning = false;
        menus["menu1"].animating = false;
        menus["menu1"].mouseOver = false;

        
        $(document).ready(function()
        {
            $("#divMenu1").mouseenter(function(e)
            {
                getMouseXY(e);
                menus["menu1"].mouseOver = true;
                setTimeout(function(){ showMenu(menus["menu1"]); }, 10);
            });
            $("#divMenu1").mouseleave(function(e)
            {
                menus["menu1"].mouseOver = false;
                hideMenu(menus["menu1"]);
            });

            $('div[id^="menu"]').mouseenter(function(e)
            {
                menus[this.id].mouseOver = true;
                setTimeout(function(){ showMenu(menus[this.id]); }, 10);
            });
            $('div[id^="menu"]').mouseleave(function(e)
            {
                menus[this.id].mouseOver = false;
                hideMenu(menus[this.id]);
            });
            
        });
    
        function showMenu(menu_obj)
        {
            var menuId = "#" + menu_obj.divId;

            for( menu in menus )
            {
                if( menus[menu] != menu_obj )
                    closeMenu(menus[menu]);
            }

            if( $(menuId).length > 0 )
            {

                if( menu_obj.showing || menu_obj.animating )
                {
                    clearTimeout(menu_obj.outTimer);
                    menu_obj.outTimer = 0;
                }


                $(menuId).parent().css("top",window.mouseTop + 10);
                $(menuId).parent().css("left", window.mouseLeft - 20);
                $(menuId).parent().css("display", "block");
                $(menuId).parent().css("width", $(menuId).width() );
                $(menuId).parent().css("height", $(menuId).height());
                $(menuId).css("display", "block");
                $(menuId).css("opacity", "0");

                menu_obj.animating = true;
                $(menuId).animate({
                    opacity: 1,
                    left: 0,
                    top: 0 }, {duration: 200, queue:true, complete: function(){ animationComplete(menu_obj); } });
            }
        }


        function animationComplete(menu_obj)
        {
            // Check to see if the user has exited the menu button before the animation has finished
            if( menu_obj.mouseOver == false )
            {
                clearTimeout(menu_obj.outTimer);
                hideMenu(menu_obj);
            }
            menu_obj.showing = true;
            menu_obj.animating = false;
        }
        

        function hideMenu(menu_obj)
        {
            clearTimeout(menu_obj.outTimer);
            //if( menu_obj.outTimer > 0 )
                //return;
            
            menu_obj.mouseOver = false;
            menu_obj.outTimer = setTimeout(function(){ closeMenu(menu_obj); }, 500 );
        }


        function closeMenu(menu_obj)
        {
            if( menu_obj.mouseOver )    // If the menu is opening
            {   // Postpone the closing till after the menu has opened. If the user has moved the mouse over the pic again, this time out will be cancelled.
                clearTimeout(menu_obj.outTimer);
                //menu_obj.outTimer = setTimeout(function(){ closeMenu(menu_obj); }, 100);
                return;
            }

            
            var menuId = "#" + menu_obj.divId;

            if( $(menuId).length > 0 )
            {
                clearTimeout(menu_obj.outTimer);
                menu_obj.outTimer = 0;

                menu_obj.animating = true;
                $(menuId).animate({
                    opacity: 0,
                    left: '-50%',
                    top: '-50%' }, {duration:400, queue:true, complete: function(){menu_obj.outTimer = 0; menu_obj.showing = false; menu_obj.animating=false; $("#" + menu_obj.divId).parent().css("display", "none"); if( menu_obj.mouseOver ){ showMenu(menu_obj); } } });
                
                //menu_obj.showing = false;
            }

        }


        function hideAllMenus()
        {
            for( var menu in menus)
            {
                closeMenu(menus[menu]);
            }
        }


        function getMouseXY(e)
        {
            var offset = $("#" + e.target.id).offset();
            var left = offset.left + e.target.offsetWidth - 10;

            var top = offset.top + e.target.offsetHeight - 5;
            
            window.mouseLeft = left;
            window.mouseTop = top;
        }

    </script>


    <div class="menuContainer">
        <div class="popupMenu" id="menu1">
            <a href="<?php echo $this->rootDir ?>homes/"><div class="menuItem">Available Homes</div></a>
            <a href="<?php echo $this->rootDir ?>communities/"><div class="menuItem">Community Locator</div></a>
        </div>
    </div>

	<div id="navContainer" style="position:absolute; height:542px; width:385px; z-index:1; left:4%; top:8%; ">
		<img id="menuBackground" src="<?= $this->rootDir ?>images/nav.png" style="position:absolute; z-index:0; max-height:100%; max-width:100%; " />
		<div id="nav">
			<div style="width:100%; height:40%;"></div>
			<div class="nav_item"><a href="<?php echo $this->rootDir; ?>"><span style="font-size:19px; ">HOME</span></a></div>
			<img src="<?php echo $this->rootDir; ?>images/swoosh.png" style="position:relative; top:-7px; " />
			<div class="nav_item nav_margin"><a href="<?php echo $this->rootDir; ?>about/"><span style="font-size:19px; ">ABOUT</span></a></div>
			<img src="<?php echo $this->rootDir; ?>images/swoosh.png" style="position:relative; top:-7px; " />
            <div class="nav_item nav_margin" style="cursor:default; "><span id="divMenu1" style="font-size:19px; ">PROPERTIES</span></div>
            <img src="<?php echo $this->rootDir; ?>images/swoosh.png" style="position:relative; top:-7px; " />
			<div class="nav_item nav_margin"><a href="<?php echo $this->rootDir; ?>gallery/"><span style="font-size:19px; ">GALLERY</span></a></div>
			<img src="<?php echo $this->rootDir; ?>images/swoosh.png" style="position:relative; top:-7px; " />
			<div class="nav_item nav_margin"><a href="<?php echo $this->rootDir; ?>testimonials/"><span style="font-size:19px; ">TESTIMONIALS</span></a></div>
			<img src="<?php echo $this->rootDir; ?>images/swoosh.png" style="position:relative; top:-7px; " />
			<div class="nav_item nav_margin"><a href="<?php echo $this->rootDir; ?>process/"><span style="font-size:19px; ">BUILD PROCESS</span></a></div>
			<img src="<?php echo $this->rootDir; ?>images/swoosh.png" style="position:relative; top:-7px; " />
			<div class="nav_item nav_margin"><a href="<?php echo $this->rootDir; ?>contact/"><span style="font-size:19px; ">CONTACT US</span></a></div>
            
		</div>
	</div>
	
