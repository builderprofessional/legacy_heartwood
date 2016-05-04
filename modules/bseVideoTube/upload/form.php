<?php
    session_start();
    $sid = $_SESSION['sid'];
    $baseDir = $_SESSION['baseDir'];
    $root = $_SESSION['root'];
    $page = $_SESSION['returnPage'];
    if( substr($page, 0, 1) != "." && substr($page, 0, 1) != "/" )
        $page = "../../../$page";
?>
<html>
<body>
    <form id="videoFrm" enctype="multipart/form-data" method="post" action="apps/upload.cgi?root=<?=$root?>&sid=<?= $sid ?>&path=<?= $baseDir ?>">
        <div>Video File</div>
        <input id="vidFile" type="file" name="file" style="width:275px;" /><br />
    </form>
    <div style="width:275px; text-align:right;"><input type="button" value="Cancel" onmouseup="parent.document.location.href='<?=$page?>?cancel=cancel';" /> <input type="button" value="Upload" onclick="parent.postUploadForm('progress.php?sid=<?=$sid?>');" /></div>
</body>
</html>