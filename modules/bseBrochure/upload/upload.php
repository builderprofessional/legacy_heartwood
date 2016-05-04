<?
$page = "/";
if( isset($_GET['page']) )
    $page = $_GET['page'];
?>
<html>
<head>
</head>
<body>
<div style="width:250px;">
    <h2 style="width:100%; font-family:Arial, Verdana, Sans, Times; font-weight:900; font-size:16px; text-align:center; ">Use This Form to Upload A PDF<br />And Make It a Brochure</h2>
    <form id="vidSaveFrm" method="post" action="makeBrochure.php" enctype="multipart/form-data" style="width:100%;">
        <div>Brochure Name</div>
        <input type="text" name="title" style="width:100%;" />
        <div style="width:100%; margin-top:15px;">
            <div style="float:left; width:55%;">
                <div>Width</div>
                <select name="bWidth" style="width:75%;">
                    <option value="200">200</option>
                    <option value="250">250</option>
                    <option value="300">300</option>
                    <option value="350">350</option>
                    <option value="400">400</option>
                    <option value="450">450</option>
                    <option value="500">500</option>
                </select>
                <span style="margin-left:7px;">X</span>
            </div>
            <div style="float:left; width:44%;">
                <div>Height</div>
                <select name="bHeight" style="width:100%;">
                    <option value="300">300</option>
                    <option value="350">350</option>
                    <option value="400">400</option>
                    <option value="450">450</option>
                    <option value="500">500</option>
                    <option value="550">550</option>
                    <option value="600">600</option>
                </select>
            </div>
        </div>
        <div style="clear:both; margin-top:15px;">Maximum Zoom</div>
        <select name="maxZoom" style="width:100%; ">
            <option value="1.5">150%</option>
            <option value="1.6">160%</option>
            <option value="1.7">170%</option>
            <option value="1.8" selected="selected">180%</option>
            <option value="1.9">190%</option>
            <option value="2.0">200%</option>
        </select>
        <div style="margin-top:15px; ">Brochure PDF File</div>
        <input type="file" name="pdfFile" style="width:100%;" /><br>
        <div style="width:100%; text-align:right; margin-top:25px;"><input type="button" value="Cancel" onmouseup="" /> <input type="submit" value="Upload" /></div>
        <input type="hidden" value="<?=$page?>" name="page" />
    </form>
</div>
</body>
</html>