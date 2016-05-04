<?php
    if( $this->user->backdoor && $this->editSlider !== true )
    {
        echo "<div style=\"width:100%; margin-top:60px; text-align:center; font-size:14px; font-weight:900; color:#FFFFFF; \">Scrolling Images Removed while in the Backdoor</div>";
    }
    else
    {
?>
<div style="width:<?= $this->slider->scrollWidth ?>px; height:<?= $this->slider->imageHeight ?>px; margin:auto; margin-top:16px; ">
<script type="text/javascript">

/***********************************************
* Conveyor belt slideshow script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/


//Specify the slider's width (in pixels)
var sliderwidthint = <?= $this->slider->scrollWidth ?>;
var sliderwidth=sliderwidthint+"px"
//Specify the slider's height
var sliderheight="<?= $this->slider->imageHeight ?>px"
//Specify the slider's slide speed (larger is faster 1-10)
var slidespeed=<?= $this->slider->sliderSpeed ?>

//configure background color:
slidebgcolor="#<?= $this->slider->backgroundColor ?>"

//Specify the slider's images
var leftrightslides=new Array()
var finalslide=''
<?php
    $counter = 0;
    foreach( $this->slider as $image )
    {
        $imgFile = $image->getResizedImage($this->slider->imageHeight, -1);
        echo "leftrightslides[".$counter++."]='<a href=\"{$image->getImageHref()}\" rel=\"lightbox\"><img src=\"$imgFile\" border=0 /></a>'\r\n";
    }
?>

//Specify gap between each image (use HTML):
var imagegap="<span style='padding:<?= floor((integer)$this->slider->spacing / 2)?>px;'></span>";

//Specify pixels gap between each slideshow rotation (use integer):
var slideshowgap=<?= floor($this->slider->spacing) ?>;


////NO NEED TO EDIT BELOW THIS LINE////////////

var imageBoxes = new Array();
var maxBoxes = 0;
var curBox = 0;
var copyspeed=slidespeed
var leftrightslide='<nobr>'+leftrightslides.join(imagegap)+'</nobr>'
var iedom=document.all||document.getElementById
if (iedom)
document.write('<span id="temp" style="visibility:hidden;position:absolute;top:-100px;left:-9000px">'+leftrightslide+'</span>')

var actualwidth=''
var cross_slide, ns_slide

function fillup(){
if( leftrightslides.length > 0 )
{
if (iedom){
cross_slide=document.getElementById? document.getElementById("temp") : document.all.temp
actualwidth=cross_slide.offsetWidth
while( actualwidth * maxBoxes < sliderwidthint )
{
    imageBoxes[maxBoxes] = document.createElement("div");
    document.getElementById('slideContainer').appendChild(imageBoxes[maxBoxes]);
    imageBoxes[maxBoxes].style.position = "absolute";
    imageBoxes[maxBoxes].style.top = 0;
    imageBoxes[maxBoxes].style.left = (maxBoxes==0 ? slideshowgap : parseInt(imageBoxes[maxBoxes-1].style.left)+actualwidth+slideshowgap)+"px";
    imageBoxes[maxBoxes].innerHTML = leftrightslide;
    maxBoxes++;
    if( maxBoxes > leftrightslide.length )
        break;
}
    imageBoxes[maxBoxes] = document.createElement("div");
    document.getElementById('slideContainer').appendChild(imageBoxes[maxBoxes]);
    imageBoxes[maxBoxes].style.position = "absolute";
    imageBoxes[maxBoxes].style.top = 0;
    imageBoxes[maxBoxes].style.left = (maxBoxes==0 ? slideshowgap : parseInt(imageBoxes[maxBoxes-1].style.left)+actualwidth+slideshowgap)+"px";
    imageBoxes[maxBoxes].innerHTML = leftrightslide;
}
else if (document.layers){
ns_slide=document.ns_slidemenu.document.ns_slidemenu2
ns_slide2=document.ns_slidemenu.document.ns_slidemenu3
ns_slide.document.write(leftrightslide)
ns_slide.document.close()
actualwidth=ns_slide.document.width
ns_slide2.left=actualwidth+slideshowgap
ns_slide2.document.write(leftrightslide)
ns_slide2.document.close()
}
lefttime=setInterval(slideleft,50)
}
}
window.onload=fillup

function slideleft(){
if (iedom){
if (parseInt(imageBoxes[curBox].style.left)<(actualwidth*(-1)))
{
    prevBox = (curBox==0 ? maxBoxes : curBox-1);
    imageBoxes[curBox].style.left=parseInt(imageBoxes[prevBox].style.left)+actualwidth+slideshowgap+"px";
}
for( i=0; i <= maxBoxes; i++ )
    imageBoxes[i].style.left=parseInt(imageBoxes[i].style.left)-copyspeed+"px";


}
else if (document.layers){
if (ns_slide.left>(actualwidth*(-1)+8))
ns_slide.left-=copyspeed
else
ns_slide.left=ns_slide2.left+actualwidth+slideshowgap

if (ns_slide2.left>(actualwidth*(-1)+8))
ns_slide2.left-=copyspeed
else
ns_slide2.left=ns_slide.left+actualwidth+slideshowgap
}
curBox++;
if( curBox > maxBoxes )
   curBox = 0;

}


if (iedom||document.layers){
with (document){
document.write('<table border="0" cellspacing="0" cellpadding="0"><td>')
if (iedom){
write('<div style="position:relative;width:'+sliderwidth+';height:'+sliderheight+';overflow:hidden">')
write('<div id="slideContainer" style="position:absolute;width:'+sliderwidth+';height:'+sliderheight+';background-color:'+slidebgcolor+'" onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed">')
write('</div></div>')
}
else if (document.layers){
write('<ilayer width='+sliderwidth+' height='+sliderheight+' name="ns_slidemenu" bgColor='+slidebgcolor+'>')
write('<layer name="ns_slidemenu2" left=0 top=0 onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed"></layer>')
write('<layer name="ns_slidemenu3" left=0 top=0 onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed"></layer>')
write('</ilayer>')
}
document.write('</td></table>')
}
}
</script>
</div>
<?php
    }
?>