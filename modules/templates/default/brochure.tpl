
    <div style="width:<?= $this->brochure->width * 2 ?>px; height:<?= $this->brochure->height ?>px; margin:auto; ">
        <?= $this->brochure->getOutput() ?>
    </div>
    <div class="brochureButtons">
        <img src="<?= $this->rootDir ?>iface/broc-back.png" onmouseup="document.getElementById('<?=$this->brochure->DOM_ID?>').prevPage();" /><img src="<?= $this->rootDir ?>iface/broc-next.png" onmouseup="document.getElementById('<?=$this->brochure->DOM_ID?>').nextPage();" /><img src="<?= $this->rootDir ?>iface/broc-zoom.png" onmouseup="document.getElementById('<?=$this->brochure->DOM_ID?>').applyZoom();" /><a href="<?= $this->brochure->getPDF_HREF() ?>" target="_blank"><img src="<?= $this->rootDir ?>iface/broc-pdf.png" /></a>
    </div>
