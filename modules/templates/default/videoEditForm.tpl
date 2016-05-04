

    <form method="post" action="saveVid.php">
        <input type="hidden" name="videoid" value="<?= $this->video->id ?>" />
        <input type="hidden" name="galleryid" value="<?= $this->video->gallery_id ?>" />
        <input type="hidden" name="userid" value="<?= $this->videoTube->user_id ?>" />
        <div class="inputWrapper"><div>