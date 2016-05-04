/* 
 * PHP File Uploader with progress bar Version 1.20
 * Copyright (C) Raditha Dissanyake 2003
 * http://www.raditha.com

 * Licence:
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 * 
 * The Initial Developer of the Original Code is Raditha Dissanayake.
 * Portions created by Raditha are Copyright (C) 2003
 * Raditha Dissanayake. All Rights Reserved.
 * 
 */
 
var url = '';
var xmlhttp;
var task = "Uploaded";

/* 
 * add any extension that you do no want to upload to the list 
 * below they should be placed with in the /^ and / characters
 * separate each extension by a pipe symbol |
 */
 
var re = /^(\.php)|(\.sh)/;  // disallow shell scripts and php


/**
 * dofilter = false; if you don't want this filtering
 */
var dofilter=true;

/**
 * this method will match each of the filenames with a
 * given list of banned extension. If any one of the
 * extensions match, an alert will be popped up and the
 * upload will not continue;
 */
 
function check_types() {
	with(document.forms[0])
	{
		/*
		 * with who uses with?
		 * i do, i am an ancient. ok?
		 */
		
		for(i=0 ; i < elements.length ; i++)
		{
			if(elements[i].value.match(re))
			{
				alert('Sorry ' + elements[i].value + ' is not allowed');
				return false;
			}
		}
	}
	return true;
}

function postUploadForm(progressPage)
{
	if(check_types() == false)
	{
		return false;
	}

    window.frames['upForm'].document.getElementById('videoFrm').submit();
    startTracking(progressPage);
    document.getElementById('upFile').value = window.frames['upForm'].document.getElementById('vidFile').value;
    return true;
}


// Progress Bar Functions
// John Beavers 2-20-2010

function createXMLObj()
{
    try
    {
        // Opera 8.0+, Firefox, Safari
        xmlhttp = new XMLHttpRequest();
    } 
    catch (e)
    {
        // Internet Explorer Browsers
        try
        {
            xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
        } 
        catch (e) 
        {
            try
            {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            } 
            catch (e)
            {
                // Something went wrong
                alert("Your browser broke!");
                return false;
            }
        }
    }
    return true;
}


function getXMLObj()
{
    var ret;
    try
    {
        // Opera 8.0+, Firefox, Safari
        ret = new XMLHttpRequest();
    } 
    catch (e)
    {
        // Internet Explorer Browsers
        try
        {
            ret = new ActiveXObject("Msxml2.XMLHTTP");
        } 
        catch (e) 
        {
            try
            {
                ret = new ActiveXObject("Microsoft.XMLHTTP");
            } 
            catch (e)
            {
                // Something went wrong
                return false;
            }
        }
    }
    return ret;
}


function startTracking(page, taskDesc)
{
    url=page;
    if( taskDesc != null )
        task = taskDesc;
    
    document.getElementById('progress').style.display = "block";
    xmlhttp = getXMLObj();
    if( xmlhttp != false )
    {
        xmlhttp.onreadystatechange = dataReceived;
        loadXMLDoc();
    }
}

function setValues(pcnt)
{
    if( pcnt == "100.00" || document.getElementById('complete').innerText == "100% " + task )
        pcnt = "100";
    
    document.getElementById('complete').innerText = pcnt+"% "+ task;
    document.getElementById('bar').style.width = pcnt+"%";
    if( pcnt != "100" )
        setTimeout("loadXMLDoc()", 1000);

}

function loadXMLDoc()
{
    xmlhttp.open("GET",url,false);
    xmlhttp.send(null);
}

function dataReceived()
{
    if( xmlhttp.readyState == 4 )
    {
        setValues(xmlhttp.responseText);
    }
}




// editVideo Functions
// John Beavers 2-20-2010

function showHideAdvances(value)
{
    if( value == true )
        document.getElementById('advancedOptions').style.display = 'block';
        
    else
        document.getElementById('advancedOptions').style.display = 'none';
}


function clearBackgrounds(vidID)
{
    fm = 2;
    
    do
    {
        el = document.getElementById('frame'+ ++fm + '-' + vidID);
        
        if( el != null )
        {
            el.style.backgroundColor = "";
        }
    } 
    while(el != null);
}

function moveImg(show)
{
    var plyr = document.getElementById('playerPreview');
    var vid = document.getElementById('previewImg');
    if( show )
        vid.style.display = "block";
        
    vid.style.left = Math.round((plyr.offsetWidth - picW) / 2) + 'px';
    vid.style.top = Math.round((plyr.offsetHeight - picH) / 2) + 'px';
}
function selectPreview(el, vidID)
{
    document.getElementById('previewImg').src = imgDir + el.id + ".jpg";
    moveImg(true);

    clearBackgrounds(vidID);
    el.style.backgroundColor="#99B0FF";
    document.getElementById('previewFrame').value = el.id + ".jpg";
}


function setPlayerW(value)
{
    if( value != "" && value != "0" )
    {
        var plyr = document.getElementById('playerPreview');
        var vid = document.getElementById('previewImg');
        
        plyr.style.width=value + 'px';
        vid.style.left = Math.round((value - vid.offsetWidth) / 2) + 'px';
    }
    return true;
}


function setPlayerH(value)
{
    if( value != "" && value != "0" )
    {
        var plyr = document.getElementById('playerPreview');
        var vid = document.getElementById('previewImg');
        
        plyr.style.height=value + 'px';
        vid.style.top = Math.round((value - vid.offsetHeight) / 2) + 'px';
    }
    return true;
}


function setVideoW(value)
{
    if( value != "" && value != "0" )
    {
        var vid = document.getElementById('previewImg');
        var plyr = document.getElementById('playerPreview');
        
        vid.style.width=value + 'px';
        picW = value;        
        if( keepAspect() )
        {
            newVal = Math.round(value/ratio);
            vid.style.height=newVal + 'px';
            document.getElementById('videoH').value = newVal;
            picH = newVal;
        }
        
        vid.style.left = Math.round((plyr.offsetWidth - vid.offsetWidth) / 2) + 'px';
        vid.style.top = Math.round((plyr.offsetHeight - vid.offsetHeight) / 2) + 'px';
    }
    return true;
}


function setVideoH(value)
{
    if( value != "" && value != "0" )
    {
        var vid = document.getElementById('previewImg');
        var plyr = document.getElementById('playerPreview');
        
        vid.style.height=value + 'px';
        picH = value;
        if( keepAspect() )
        {
            newVal = Math.round(value*ratio);
            vid.style.width=newVal + 'px';
            document.getElementById('videoW').value = newVal;
            picW = newVal;
        }

        vid.style.left = Math.round((plyr.offsetWidth - vid.offsetWidth) / 2) + 'px';
        vid.style.top = Math.round((plyr.offsetHeight - vid.offsetHeight) / 2) + 'px';
    }
    return true;
}


function bgChangeEvent()
{
    document.getElementById('playerPreview').style.backgroundColor = "#"+cp1.color.hex;
    document.getElementById('bgColorInput').value = cp1.color.hex;
}


function keepAspect()
{
    return document.getElementById('aspectR').checked;
}


function resetSizes(vidW, vidH, boxW, boxH)
{
    setVideoW(vidW);
    setVideoH(vidH);
    setPlayerW(boxW);
    setPlayerH(boxH);

    document.getElementById('videoW').value = vidW;
    document.getElementById('videoH').value = vidH;
    document.getElementById('playerW').value = boxW;
    document.getElementById('playerH').value = boxH;
}