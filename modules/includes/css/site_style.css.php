<?php
    $root = "../../../";
    include("{$root}modules/config.inc");
    
    header("Content-type: text/css");
?>


/* Page Elements */

html
{
    height:100%;
}
body 
{
    color: <?= $body_color ?>;
    background-color: <?= $body_background_color ?>;
    background-image:url('<?= $root."iface/".$body_background_image ?>');
    background-position: center center;
    background-repeat: <?= $body_background_repeat ?>;
    font-family: <?= $body_font_family ?>;
    font-size: <?= $body_font_size ?>;
    width:100%;
    min-height:100%;
    margin:0;
}

a
{
    color:<?= $body_color ?>;
    text-decoration:none;
}
a img
{
    border:0;
}

hr
{
    color:<?= $body_color ?>;
    margin-bottom:30px;
}
h1
{
	font-family:'Franklin Gothic Medium', sans-serif;
	font-variant:small-caps;
}







/* Elements with ID */
#admin_header
{
    background-color:<?= ($admin_backgound_color == "" ? $body_background_color : $admin_backgound_color) ?>;
    color:<?= ($admin_color == "" ? $body_color : $admin_color) ?>;
    height: 30px;
    width:95%;
    position:absolute;
    top:-100px;
    left:-1000px;
    border: solid 2px #<?= oppositeHex( ($admin_backgound_color == "" ? $body_background_color : $admin_backgound_color) ) ?>; 
    text-align:center;
    padding-top:4px;
    z-index:2;
}


/* Navigation */

#nav 
{
	position:relative;
	width:100%;
	height:60%;
	top:12%;
	text-align:center;
    left:-40px;
    visibility:hidden;
}
#nav hr
{
	width:43%;
	margin:2% auto;
	padding:0;
}
#nav img
{
	width:60%;
	margin:0;
	padding:0;
}
#nav a 
{
    color:#FFF;
    text-decoration:none;
    margin:0;
}
#nav a.selected 
{
    color:#fff;
}
.nav_item
{
	font-size:37%;
    color:#FFF;
}
.nav_margin
{
    margin-top:-4.5%;
}

/* Page layout */
#wrapper
{
    position:absolute;
    width:100%;
    min-height:100%;
}

#bse_footer
{
    color:<?= $bse_footer_color ?>;
    font-size:<?= ( empty($bse_footer_font_size) ? $body_font_size : $bse_footer_font_size ) ?>;
    font-weight:<?= ( empty($bse_footer_font_weight) ? "400" : $bse_footer_font_weight) ?>;
    text-align:center;
    margin-top:15px;
}
#bse_footer a
{
    color:<?= ( empty($bse_footer_link_color) ? $bse_footer_color : $bse_footer_link_color ) ?>;
}

#bse_footer_container
{
    text-align:center;
    margin:auto;
    width:85%;
}

#contentContainer
{
    width:896px;
    margin:6px auto 35px;
    background-color:#FFF;
}

#contentBackground
{
    position:absolute;
    z-index:0;
    right:0px;
    bottom:0px;
    left:0px;
    top:0px;
    background-image:url('<?= $root ?>iface/content-bg.jpg');
}

#pageTitle
{
    float:right;
    position:relative;
    z-index:0;
    width:645px;
    height:49px;
    color:#EEE;
    font-size:33px;
    font-weight:900;
    background-image:url('<?= $root ?>iface/pg-header-bar.png');
    text-align:center;
}

#navMenu
{
    position:absolute;
    z-index:2;
    height:500px;
    width:375px;
    overflow-y:visible;
}

#pageBanner
{
    width:100%;
    text-align:center;
    margin-top:30px;
}




/* Classes */
.bodyBackColor
{
    background-color: <?= $body_background_color ?>;
}

.frontback_link
{
    color:<?= ($frontback_link_color != "" ? $frontback_link_color : $admin_color ) ?>;
}

.build_step
{
	float: left;
	width: 302px;
	height:420px;
	margin: 5px 0.66%;
	text-align:center;
	background-color:#EAF4FE;
	color:#000;
	border:solid 1px #333;
}
.build_step img 
{
	max-width:100%;
}
.build_step div 
{
	padding: 5px;
	margin: 5px;
	border: 1px solid #ccc;
	background-color:#fff;
	color:#000;
	position:relative;
	height:135px;
	overflow:hidden;
}

.layoutWrapper
{
    width:1000px;
    margin:auto;
    background-image:url('../../../iface/content-tile.jpg');
}
.content
{
    margin-bottom:15px;
}
.contentBackground
{
	position:absolute;
	top:0;
	left:0;
	right:0;
	bottom:0;
    background-color:#793C27;
    -moz-border-radius: 8px;
    border-radius: 8px;
    z-index:-1;
}
.contentWrapper
{
    position:relative;
    z-index:0;
    left:207px;
    top:30px;
    width:70%;
    padding:8px 20px 40px 165px;
	margin-bottom:40px;
    min-height:493px;
}


.innerContent
{
    width:95%;
    padding-left:2.5%;
    padding-right:2.5%;
    position:relative;
}

.navBG
{
    position:relative;
    z-index:0;
    display:block;
}

.bottom_fader
{
    position:absolute; 
    bottom:-20px; 
    left:0px; 
    right:0px; 
    height:24px; 
    background-image:url('<?= $root ?>iface/window-bottom.png'); 
    background-repeat:repeat-x;
}

.clear
{
    width:100%;
    clear:both;
}

.backgroundImage
{
    position:absolute;
}


.textPositioner
{
    float:left;
    clear:left;
}

.modValueLine
{
    float:left;
    font-size:12px;
    margin-bottom:1px;
    clear:left;
}
.modValueLabel
{
    float:left;
    font-weight:900;
    margin-right:7px;
}
.modValueData
{
    float:left;
}

div.mailfriend_label
{
    float:left;
    width:140px;
    text-align:right;
    padding-right:4px;
    font-size:12px;
    font-weight:900;
}
div.mailfriend_input
{
    float:left;
    width:250px;
    text-align:left;
}
input.mailfriend_input
{
    width:100%;
}

.homeAdminFormLabel
{
    float:left;
    width:28%;
    height:100%;
    margin-right:4px;
    margin-top:4px;
    text-align:right;
    font-size:12px;
    font-weight:900;
}

.contactFormLabel
{
    float:left;
    width:140px;
    margin-right:4px;
    text-align:right;
    font-size:12px;
    font-weight:900;
}
div.contactFormInput
{
    float:left;
    width:250px;
}
input.contactFormInput
{
    width:100%;
}
.inputWrapper
{
    clear:left;
    margin:0px;
    width:100%;
    height:21px;
    padding:0px;
}
.inputWrapper input
{
    float:left;
    width:65%;
    margin-left:2%;
}
.inputWrapper select
{
    float:right;
    width:66.5%;
    margin-top:3px;
}
.inputWrapper div
{
    margin:0px;
    padding-top:5px;
    float:left;
    text-align:right;
    width:30%;
    height:90%;
}
.inputWrapper textarea
{
    float:left;
    width:65%;
    height:60px;
    margin-left:2%;
}
.tb_input input
{
    float:left;
    width:58%;
    margin-left:2%;
}
.tb_input img
{
    width:20px;
    height:20px;
    float:left;
    cursor:pointer;
    margin-left:5px;
}

input.submit
{
    height:23px;
    padding:1px;
}


.adminSubHeading
{
    width:100%;
    text-align:center;
    font-size:16px;
    font-weight:900;
    margin-bottom:45px;
    margin-top:3px;
}

.pageHeading
{
    width:60%;
    height:80px;
}

.pageHeading .headingContent
{
    float:left;
    width:90%;
    height:100%;
    background-image:url('<?= $root ?>iface/red_back.png');
    padding-right:20px; 
    text-align:right;
}

.pageHeading .headingBorder
{
    float:left;
    width:8px;
    height:100%;
    position:relative;
    z-index:2;
}


.infoText
{
    width:95%;
    margin:auto;
    font-size:15px;
    font-weight:900;
    margin-bottom:18px;
    text-align:center;
}


.transBack
{
    opacity:0.9;
    filter:alpha('opacity=90');
}



.brochureButtons
{
    width:100%;
    text-align:center;
    margin-top:15px;
    margin-bottom:8px;
}
.brochureButtons img
{
    margin:0px 10px;
    border:0;
    cursor:pointer;
}



.popupMenu
{
    width:200px;
    background-color:#552211;
    display:none;
    font-size:16px;
    font-weight:900;
    text-align:center;
}
.menuItem
{
    width:100%;
    height:25px;
    padding-top:6px;
    cursor:pointer;
}
.menuItem:Hover
{
    background-color:#FFFCCF;
    color:#112211;
}
.menuContainer
{
    position:absolute;
    width:204px;
    overflow:hidden;
    z-index:2;
    display:none;
}


.testimonial 
{
    margin: 10px;
    padding: 5px;
    color:#5D232B;
    background-color: #f5f5f5;
    border:1px solid #333;
    -moz-box-shadow: 0px 0px 3px 1px #999;
    -webkit-box-shadow: 0px 0px 3px 1px #999;
    box-shadow: 0px 0px 3px 1px #999;
}
.testimonial_more 
{
    clear:both;
    text-align:center;
    font-size:10px;
}
.testimonial_moreLink
{
    text-decoration:underline;
    cursor:pointer;
    color:#707D55;
}
img.testimonial_pic 
{
    float: left;
    background-color: #ccc;
    clear: none;
    margin: 5px;
    padding: 3px;
}
.testimonial_summary 
{
    display: inline;
}
.testimonial_full 
{
    display: inline;
}
.testimonial_customer
{
    margin-left:20px;
    margin-bottom:12px;
    font-size:20px;
    font-weight:900;
    font-family:verdana;
}



#slidesControlPanel
{
    width:20%;
    min-width:280px;
    max-width:350px;
    height:6%;
    max-height:50px;
    text-align:center;
    position:absolute;
    z-index:2;
    top:1%;
    left:4.5%;
    font-size:0;
    opacity:0.3;
    filter:alpha('opacity=30');
}
#slidesControlPanel:hover
{
    opacity:0.8;
    filter:alpha('opacity=80');
}

#slidesControlPanel img
{
    display:inline;
    height:100%;
    cursor:pointer;
}








<?php
function oppositeHex($color)
{
    if( substr($color, 0, 1) == "#" )
        $color = substr($color, 1);
    
    $r = dechex(255 - hexdec(substr($color,0,2)));
    $r = (strlen($r) > 1) ? $r : '0'.$r;
    $g = dechex(255 - hexdec(substr($color,2,2)));
    $g = (strlen($g) > 1) ? $g : '0'.$g;
    $b = dechex(255 - hexdec(substr($color,4,2)));
    $b = (strlen($b) > 1) ? $b : '0'.$b;
    return $r.$g.$b;
}


?>