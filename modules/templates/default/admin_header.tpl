<!-- Begin admin_header.tpl -->

<script type="text/javascript"> <!-- Hide
var root = "<?= $this->rootDir ?>";
var leftArrow = new Image();
var rightArrow = new Image();

leftArrow.src = root + "iface/admin_arrow_left.png";
rightArrow.src = root + "iface/admin_arrow_right.png";

    function setCookie(c_name,value,exdays)
    {
        var exdate=new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
        document.cookie=c_name + "=" + c_value + "; path=/;";
    }


    function showHideMenu(menu)
    {
        if( menu.offsetLeft >= 0 )
        {
            hideAdminMenu(menu)
        }
        else
        {
            showAdminMenu(menu);
        }
    }



    function showAdminMenu(menu)
    {
        setTimeout(function() {moveMenu(menu,150);}, 20);
    }



    function hideAdminMenu(menu)
    {
        setTimeout(function() {moveMenu(menu,-150);}, 20);
    }



    function moveMenu(menu, amount)   // positive number moves to the right, negative numbers move to the left
    {
        menu.style.left = (menu.offsetLeft + amount) + "px";

        if( amount > 0 )
        {
            if( menu.offsetLeft > -(amount) )	// Done moving menu, do required stuff
            {
                menu.style.left = "0px";
                img = document.getElementById('show_hide_btn');
                document.getElementById('show_hide_img').src = leftArrow.src;
                setOpacity(img, 10);
                setCookie("menu_position","out", 2);
            }
            else
                showAdminMenu(menu);
        }
        else
        {
            if( menu.offsetLeft + menu.offsetWidth < Math.abs(amount) )
            {
                menu.style.left = -(menu.offsetWidth) + "px";
                img = document.getElementById('show_hide_btn');
                document.getElementById('show_hide_img').src = rightArrow.src;
                setOpacity(img, 3);
                setCookie("menu_position","in", 2);
            }
            else
                hideAdminMenu(menu);
        }
    }


    function setOpacity(obj, opacity)
    {
        obj.style.filter='progid:DXImageTransform.Microsoft.Alpha(Opacity=' + opacity * 10 + ')';
        obj.style.opacity = opacity/10;
    }
        

    function clickAdminLink()
    {
        var menu = document.getElementById('admin_header');
        menu.style.left = "0px";
        menu.style.top = "1px";
        window.scroll(0,0);
        <?php if( $this->user->loggedIn )
            echo "window.scroll(0,0); showAdminMenu(document.getElementById('admin_header'));";
        else
            echo "document.getElementById('loginInput').focus();";
        ?>
    }

// Unhide -->
</script>
<div id="admin_header" style="font-size:14px; <?php if( $this->user->loggedIn && $_COOKIE['menu_position']=="out" ){ echo ' left:0px; top:1px; '; } else if( $this->user->loggedIn && $_COOKIE['menu_position']=="in" ) { echo ' left:-95.5%; top:1px; '; }?>">
    <div id="show_hide_btn" style="position:absolute; top:2px; right:-28px; cursor:pointer; <?php if( $this->user->loggedIn && $_COOKIE['menu_position']=="in" ){ echo "opacity:0.3; filter:alpha(opacity=30);";}?> " onmouseover="if( this.parentNode.offsetLeft < 0 ) {setOpacity(this, 9);}" onmouseout="if( this.parentNode.offsetLeft < 0 ) {setOpacity(this, 3); }" onclick="showHideMenu(document.getElementById('admin_header') );"><img id="show_hide_img" src="<?= $this->rootDir ?>iface/<?php if( $this->user->loggedIn && $_COOKIE['menu_position'] == "in" ){echo "admin_arrow_right.png";}else {echo "admin_arrow_left.png";} ?>" /></div>
<?php
    if( !$this->user->loggedIn )
        $this->display("admin_header_login_form.tpl");

    else
    {

        if( $GLOBALS['useStatistics'] )
        {
?>

    <div style="position:absolute; bottom:1px; right:1px; ">
        <a href="/plesk-stat/webstat/" target="_blank"><span class="frontback_link">Statistics</span></a>
    </div>
<?php
        }
?>
    <div style="position:absolute; top:8px; left:50px; font-weight:900; ">Welcome: <?= $this->user->firstName ?><span style="margin-left:15px; font-weight:400; "><a href="<?= $this->rootDir ?>modules/base/admin/logout.php"><span class="frontback_link">Logout</span></a></span></div>
    <form name="nav" id="admin_nav" style="display:inline; ">
        Goto:
        <?php $this->display("admin_menu_select.tpl"); ?>
        <input name="Go" type="button" onClick="document.location.href=document.getElementById('selAdminMenu').options[document.getElementById('selAdminMenu').selectedIndex].value;" value="Go >>">
    </form>
    <span style="margin-left:35px;"><a href="<?= $this->rootDir ?>modules/base/admin/frontback.php"><span class="frontback_link"><?= ( $this->user->backdoor ? "Frontdoor" : "Backdoor" ) ?></span></a></span>
<?php
    }
?>
</div>

<!-- End admin_header.tpl -->

