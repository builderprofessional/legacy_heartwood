
<link rel="stylesheet" href="<?= $this->rootDir ?>css/bseVideoTube.css" type="text/css" media="screen" />
<script type="text/javascript" > <!-- Hide

    var backHover = new Image();
    backHover.src = '<?= $this->rootDir ?>iface/vidButBG_hover.png';
    
    var backDown = new Image();
    backDown.src = '<?= $this->rootDir ?>iface/vidButBG_down.png';

    function moveMovie(el, ev)
    {
        var ev = ev || window.event;
        var mov = getFlashMovieObject("bseFlvPlayer");
        //var movObject = document.getElementById("bseFlvPlayer");
            
        if (ev.pageX == null)
        {
          // IE case
          var d= (document.documentElement && document.documentElement.scrollLeft != null) ? document.documentElement : document.body;
          docX= d.scrollLeft;
          docY= d.scrollTop;
        }
        else
        {
          // all other browsers
          docX= window.pageXOffset;
          docY= window.pageYOffset;
        }

        var viewportheight;
         
        // the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight 
        if (typeof window.innerWidth != 'undefined')
        {
            viewportheight = window.innerHeight;
        }

        // IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
        else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0)
        {
            viewportheight = document.documentElement.clientHeight;
        }

        // older versions of IE
        else
        {
            viewportheight = document.getElementsByTagName('body')[0].clientHeight;
        }

        if( el.style.position != "absolute" )
        {
            el.style.position = "absolute";
            el.style.top = docY+"px";
            el.style.left = docX+"px";
            el.style.width = "100%";
            el.style.height = viewportheight + "px";
            mov.style.position = "absolute";
            mov.style.width = "65%";
            mov.style.height = "65%";
            mov.style.top = ((el.offsetHeight - mov.offsetHeight) / 2)+"px";
            mov.style.left = ((el.offsetWidth - mov.offsetWidth) / 2)+"px";
            document.getElementById('restoreButton').style.left = mov.offsetLeft+"px";
            document.getElementById('restoreButton').style.top = (mov.offsetTop + mov.offsetHeight + 5)+"px";
            document.getElementById('restoreButton').style.display = "block";
            document.getElementById('screenBackground').style.display = "block";
            document.body.style.overflow = "hidden";
        }
       
        else
        {
            el.style.top = 0+"px";
            el.style.left = 0+"px";
            el.style.position = "relative";
            el.style.width = "100%";
            el.style.height = "100%";
            mov.style.position = "absolute";
            mov.style.width = "100%";
            mov.style.height = "100%";
            mov.style.top = 0+"px";
            mov.style.left = 0+"px";
            document.getElementById('restoreButton').style.display = "none";
            document.body.style.overflow = "auto";
            document.getElementById('screenBackground').style.display = "none";
        }
        
        mov.style.visibility = "hidden";
        setMovieVars();
    }
    
    function setMovieVars()
    {
        var movie = getFlashMovieObject("bseFlvPlayer");
        if( curMovH != 0 )
            movie.SetVariable("movHeight", curMovH);
        if( curMovW != 0 )
            movie.SetVariable("movWidth", curMovW);
        movie.SetVariable("vidHeight", movie.offsetHeight-19);
        movie.SetVariable("vidWidth", movie.offsetWidth);
        movie.SetVariable("vidURL", curVideo);
        movie.SetVariable("previewURL", curPreview);
        movie.SetVariable("resizeOnly", true);
        movie.Play();
        movie.style.visibility = "visible";
    }
    
    
    function deleteMovie()
    {
        if( confirm("Are you sure you want to delete this movie?") )
            document.location.href='delVid.php?galID='+document.getElementById('vidSelect').options[document.getElementById('vidSelect').selectedIndex].value+'&page=gallery.php';
    }
    
    
    function scrollList(direction)
    {
        var list = document.getElementById('scrollArea');
        var movement = 73;
        //alert(list.offsetHeight - list.parentNode.offsetHeight);
        
        if( direction < 0 )
        {
            if( list.offsetTop > -(list.offsetHeight - list.parentNode.offsetHeight) ) // if we still have hidden movies below us
            {
                list.style.top = (list.offsetTop - movement) + "px";
            }
        }
        
        else
        {
            if( list.offsetTop < 0 )
            {
                list.style.top = (list.offsetTop + movement) + "px";
            }
        }
    }
    
// Stop Hiding -->
</script>
<?php

    if( $this->videoTube->videos->count() == 0 )
    {
        if( $this->user->inBackDoor() )
            echo "<div style='width:100%; text-align:right; margin-top:20px; margin-bottom:20px; '><a rel='shadowbox;width=550;height=390;' class='option' href='edVid.php'>Add New Video</a></div>";
        echo "<div style='width:100%; margin-top:25px; margin-bottom:25px; padding-top:5px;'>\n";
            echo "<span class='videoMsg'>Video Gallery is Empty</span>\n";
        echo "</div>";
    
    }
    
    else
    {
        if( $this->user->inBackDoor() )
            echo "<div style='width:100%; text-align:right; margin-top:20px; margin-bottom:-20px; '><a rel='shadowbox;width=550;height=390;' class='option' href='edVid.php'>Add New Video</a></div>";
        echo "<div style='width:100%; height:325px; margin-top:25px; margin-bottom:25px; background-color:#000000; padding-top:5px;'>\n";
            echo "<table style='width:100%; '>\n";
                echo "<tr>\n";
                    echo "<td valign='top' align='right' >
                            <div style='width:100%; height:292px; overflow:hidden; position:relative; '>
                                <div id='scrollArea' style='width:100%; position:absolute; '>\n";

                    $startVid = -1;
                    foreach( $this->videoTube->videos as $video )
                    {
                        if( $startVid == -1 )
                            $startVid = $video->id;
                        $vidCaption = $video->description;
                        $iconFile = $video->getResizePreview(40);
                        if( $iconFile == "" ){$iconFile = "nopic.jpg";}
                        echo "<div class='vidButton' " .(!$this->user->inBackDoor() ? "onclick=\"player.setClip('".$video->activeDir.$video->videoFile."'); player.startBuffering(); \"" : "").">
                                ".($this->user->inBackDoor() ? "<a rel='shadowbox;width=550;height=390;' style='color:#FFFFFF; text-decoration:none; ' href='edVid.php?id={$data['id']}'>":"")."
                                <img style='float:left; height:40px; border:0; ' src='$iconFile' />
                                <div style='width:auto; margin-left:1px; margin-right:2px; text-align:center; font-weight:700; font-size:13px; '>".$video->title."</div>
                                <div style='clear:both; width:100%; font-size:10px; text-align:left; padding-left:4px; ' >$vidCaption</div>
                                <img style='position:absolute; top:0; left:0; width:100%; height:100%; z-index:1; border:0; ' src='{$this->rootDir}iface/vidButBG.png' onmouseover=\"this.src = backHover.src;\" onmouseout=\"this.src = '{$this->rootDir}iface/vidButBG.png';\" />
                                ". ($this->user->inBackDoor() ?"</a>":"") . "
                            </div>\n";
                    }
                        
                        if( $this->videoTube->videos->count() <= 4 )
                            $offPic = "off";
                            $this->videoTube->width = 400;
                            $this->videoTube->height = 300;
                        echo "</div></div><div style='width:100%; height:25px; text-align:left; '><input type='image' src='{$this->rootDir}iface/fullscreenBut.png' onmouseup=\"moveMovie(document.getElementById('movContainer'),event);\" style='height:22px; margin-top:3px; ' /><div style='float:right; margin-top:5px; margin-right:5px; '><a href=\"javascript:scrollList(1);\"><img border=0 src='{$this->rootDir}iface/btn_up$offPic.gif' style='display:inline; ' /></a><a href=\"javascript:scrollList(-1);\"><img border=0 src='{$this->rootDir}iface/btn_down$offPic.gif' style='display:inline; ' /></a></div></div>
                        </td>
                        <td valign='top' style='width:400px; height:320px; padding:0; text-align:right; overflow:visible; '>
                            <div id='movContainer' style='width:100%; height:100%; position:relative; z-index:2; ' >
                            <div id='screenBackground' style='background-color:#000000; opacity:0.8; filter:alpha(opacity=80); position:absolute; width:100%; height:100%; top:0; left:0; z-index:-1; '></div>
                            <div id='bseVideoPlayer' style='width:{$this->videoTube->width}px; height:{$this->videoTube->height}px; '></div>\n";
                            //$vid =& $this->videoTube->videos->getItemById($startVid);
                            $this->videoTube->getEmbedCode();
                    echo "<input id='restoreButton' type='image' src='{$this->rootDir}iface/restoreBut.png' onmouseup=\"moveMovie(document.getElementById('movContainer'),event);\" style='display:none; position:absolute; ' /></div>\n</td>\n";
                echo "</tr>\n";
            echo "</table>\n";
        echo "</div>\n";
    }
?>