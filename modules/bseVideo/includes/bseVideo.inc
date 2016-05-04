<?php

    class bseVideo extends dbData
    {
        public  $storeDir,
                $videoDir,
                $streamDir,
                $activeDir,
                $imageDir,
                $videoH,
                $videoW;


        public function __construct($dbConnection, $dataArray, $pathToModuleRoot)
        {
            if( !empty($dataArray) )
            {
                foreach( $dataArray as $key => $value )
                {
                    $this->set($key, $value);
                }
                $this->videoH = $dataArray['playerHeight'];
                $this->videoW = $dataArray['playerWidth'];
            }

            $this->storeDir = $pathToModuleRoot.(substr($pathToModuleRoot, strlen($pathToModuleRoot), -1)=="/"?"":"/");;
            include("{$this->storeDir}includes/config.inc");

            $this->activeDir = $this->streamDir = "http://web27.streamhoster.com/rick_bse/stream/".$_SERVER['SERVER_NAME'] . "/";
            $this->videoDir = $videoDir.(substr($videoDir, strlen($videoDir), -1)=="/"?"":"/");
            $this->imageDir = $imageDir.(substr($imageDir, strlen($imageDir), -1)=="/"?"":"/");
            parent::__construct($dbConnection, $dataArray['id'], "bseVideos");

            // Check if the file exists on the remote server
            $ch = curl_init($this->streamDir.$this->videoFile);
            curl_setopt($ch, CURLOPT_NOBODY, true);
            curl_exec($ch);
            $retcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);  // $retcode > 400 -> not found, $retcode = 200, found.
            curl_close($ch);
            
            if( $retcode != "200" )
            {
                $this->activeDir = "../{$this->videoDir}";
                $curDir = realpath($this->storeDir);
                $curDir .= substr($curDir, -1) != "/" ? "/" : "";

                $cmd = $curDir."upload/apps/ftp.sh {$this->id}.flv {$curDir}{$this->videoDir} {$_SERVER['SERVER_NAME']} > /dev/null 2?&1 &";
                // echo $cmd; return;
                exec($cmd);
            }
        }


        public function getEmbedCode()
        {
            $dirInfo = $this->activeDir;                
?>
            <script type="text/javascript"><!-- Hide
                var curMovH = curMovW = 0;
                var curPreview = curVideo = "";
            
                function getFlashMovieObject(movieName)
                {
                    if(document.embeds[movieName])
                        return document.embeds[movieName];
                    if(window.document[movieName])
                        return window.document[movieName];
                    if(window[movieName])
                        return window[movieName];
                    if(document[movieName])
                        return document[movieName];

                    return null;
                }

                function changeMovie(vidFile, preFile, h, w)
                {
                    mov = getFlashMovieObject("bseFlvPlayer");
                    mov.SetVariable("movHeight", h);
                    mov.SetVariable("movWidth", w);
                    mov.SetVariable("vidURL", vidFile);
                    mov.SetVariable("previewURL", preFile);
                    mov.Play();
                    curMovH = h;
                    curMovW = w;
                    curVideo = vidFile;
                    curPreview = preFile;
                }
            // End Hiding -->
            </script>

            <object id="bseFlvPlayer" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="<?=(int)$this->playerWidth?>" height="<?=(int)$this->playerHeight+19?>" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0">
                <param name="FlashVars" value="movHeight=<?=$this->videoH?>&movWidth=<?=$this->videoW?>&vidURL=<?=$dirInfo.$this->videoFile?>&previewURL=<?=$this->storeDir.$this->imageDir.$this->previewFile?>&vidWidth=<?=$this->playerWidth?>&vidHeight=<?=$this->playerHeight?>" />
                <param name="src" value="<?=$this->storeDir."includes/bsePlayer.swf"?>" />
                <param name="allowfullscreen" value="true" />
                <param name="wmode" value="transparent">
                <embed type="application/x-shockwave-flash" width="<?=(int)$this->playerWidth?>" height="<?=(int)$this->playerHeight+19?>" src="<?=$this->storeDir."includes/bsePlayer.swf"?>" allowfullscreen="true" FlashVars="vidURL=<?=$dirInfo.$this->videoFile?>&previewURL=<?=$this->storeDir.$this->imageDir.$this->previewFile?>&vidWidth=<?=$this->playerWidth?>&vidHeight=<?=$this->playerHeight?>" wmode="transparent" allowScriptAccess="always" swliveconnect="true" name="bseFlvPlayer">
                </embed>
            </object>
<?php
        }


        public function delete()
        {
            $this->setValue("active", "0");
        }


        public function getResizePreview($pathToRoot="./", $h=150, $w=150)
        {
            $maxW = $w;
            $maxH = $h;
            $path = $pathToRoot."modules/bseVideo/".$this->imageDir;
			$fullFile = $path.$this->previewFile;

            if(!file_exists($fullFile))
            {
                return "";
            }

            // Get new dimensions
            list($width_orig, $height_orig) = getimagesize($fullFile);
            $ratio_orig = $width_orig/$height_orig;
            $nwidth=$maxH*$ratio_orig;
            $nheight=$maxW/$ratio_orig;
            if( $nwidth>=$maxW ){ $width=$maxW;$height=$nheight; }
            if( $nheight>$maxH ){ $height=$maxH;$width=$nwidth; }

            // Resample
            $image_p = imagecreatetruecolor($width, $height);
            $image = imagecreatefromjpeg($fullFile);
            imagecopyresampled($image_p, $image, 0, 0, 0, 0, $width, $height, $width_orig, $height_orig);

            // Output
            $outFile = $path.$this->id."_sm.jpg";
            imagejpeg($image_p, $outFile, 100);
            imagedestroy($image_p);
            imagedestroy($image);
            return $outFile;
        }

    }
?>