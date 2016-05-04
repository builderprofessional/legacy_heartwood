<?php
    foreach( $this->contactPage as $staff )
    { ?>
        <div style="width:95%; margin:auto; margin-bottom:20px;">
            <table style="width:100%;"><tr><td style="width:65%; ">
                <div>
                    <div class="norm staffName"><?= $staff->name ?></div>
                    <div class="norm staffTitle"><?= ( $staff->title==""?"":" - {$staff->title}" ) ?></div>
                    <div class="norm staffDept"><?= ( $staff->department==""?"":"Dept: ".$staff->department) ?></div>
                </div>
                <div>
                    <div class="norm staffDesc"><div class="staffPic"><?= $staff->getPictureCode(-1, 190) ?></div><?= $staff->description ?></div>
                </div></td>
                <td><div class="norm staffContactInfo"><?php
$phone = $staff->getPhone();
$cell = $staff->getCell();
                     echo ($phone==""?"":"<span style=\"font-weight:normal; font-size:14px; margin-right:8px; \">Phone:</span>{$phone}<br />\n");
                     echo ($cell==""?"":"<span style=\"font-weight:normal; font-size:14px; margin-right:8px; \">Cell:</span>{$cell}<br />\n");
                     echo $staff->getEmailCode()."\n";
                     ?>
                     </div>
                </td>
            </tr></table>
        </div>
<?php }
?>