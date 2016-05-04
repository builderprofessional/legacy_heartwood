<?php
    require_once($this->getFileHref("math_captcha.inc") );
    $captcha = new mathCaptcha();
?>

        <div class="norm contactFormLabel" style="width:140px; margin-top:3px; "><?= $captcha->msg ?>:</div>
        <div class="norm contactFormInput" style="float:right; "><input id="captcha_code" class="input2" style="width:210px;" type="text" name="<?= $captcha->fieldName ?>" maxlength="30" /></div>