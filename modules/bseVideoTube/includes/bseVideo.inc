<?php

    class bseVideoTube extends bseModule
    {
        private $imageDir,
                $videoDir;
                
        public  $videos,
                $resizeH,
                $resizeW;


        public function __construct($pathToModuleRoot)
        {
            parent::__construct($pathToModuleRoot, "modules/bseVideoTube/");
            parent::setTableName("bseVideoGalleries");

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->videoDir = $videoDir.(substr($videoDir, -1)=="/"?"":"/");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");

        }
        
        
        
        public function setDataFromUserId($userid)
        {
            $id = $this->getEscapedString($userid);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `user_id` = '$id'");
            $this->setDataFromArray($data);
            
            $this->videos = new bseVideoTubeFiles($this->rootPath);
            $this->videos->setDataFromGalleryId($this->id);
        }
        
        
        
        public function setDataFromTubeId($tubeid)
        {
            $id = $this->getEscapedString($tubeid);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$id'");
            $this->setDataFromArray($data);
            
            $this->videos = new bseVideoTubeFiles($this->rootPath);
            $this->videos->setDataFromGalleryId($this->id);
        }

        
        
        


        public function getEmbedCode()
        {
            $vid = $this->videos->getOrdinalArrayItem(0);  
            $dirInfo = $vid->activeDir;  
            
            if( is_null($vid) )
                echo "Error Loading BSE Video Tube";
                
            else
            {
?>
            <script type="text/javascript" src="<?= $this->rootPath.$this->storeDir ?>includes/flowplayer.js"></script>
            <script type="text/javascript"><!-- Hide

                var player = flowplayer("bseVideoPlayer", "<?= $this->rootPath.$this->storeDir?>includes/flowplayer.swf",  {
                                 clip: {autoBuffering: true, autoPlay:false, scaling: 'fit' },
                                 onLoad: function() { this.setClip('<?= $dirInfo . $vid->videoFile ?>'); }
                             });

<?php
/*
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
*/
?>
            // End Hiding -->
            </script>
<?php
    /*   The below code was used on a previous version of the videoTube, it may be needed at some point for a <noscript> tag
<!--
            <object id="bseFlvPlayer" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="<?=(int)$this->width?>" height="<?=(int)$this->height?>" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0">
                <param name="FlashVars" value="movHeight=<?=$vid->height?>&movWidth=<?=$vid->width?>&vidURL=<?=$dirInfo.$vid->videoFile?>&previewURL=<?=$this->rootPath.$this->storeDir.$this->imageDir.$vid->previewFile?>&vidWidth=<?=$this->width?>&vidHeight=<?=$this->height?>" />
                <param name="src" value="<?=$this->rootPath.$this->storeDir."includes/bsePlayer.swf"?>" />
                <param name="allowfullscreen" value="true" />
                <param name="wmode" value="transparent">
                <embed type="application/x-shockwave-flash" width="<?=(int)$this->width?>" height="<?=(int)$this->height?>" src="<?=$this->rootPath.$this->storeDir."includes/bsePlayer.swf"?>" allowfullscreen="true" FlashVars="vidURL=<?=$dirInfo.$vid->videoFile?>&previewURL=<?=$this->rootPath.$this->storeDir.$this->imageDir.$vid->previewFile?>&vidWidth=<?=$this->width?>&vidHeight=<?=$this->height?>" wmode="transparent" allowScriptAccess="always" swliveconnect="true" name="bseFlvPlayer">
                </embed>
            </object>
-->

*/
            }
        }

    }
    
    
    
    
    
    
    
    
    
    
    class bseVideoTubeFile extends bseModule
    {

        public  $imageDir,
                $videoDir,
                $streamDir,
                $activeDir,
                $img;
                

    
        public function __construct($pathToModuleRoot = "./")
        {
            parent::__construct($pathToModuleRoot, "modules/bseVideoTube/");
            parent::setTableName("bseVideos");
        
            $this->img = new bseImageManipulator();
            include("{$this->rootPath}{$this->storeDir}includes/config.inc");

            $this->activeDir = $this->streamDir = "http://web27.streamhoster.com/rick_bse/stream/".$_SERVER['SERVER_NAME'] . "/";
            $this->videoDir = $videoDir.(substr($videoDir, -1)=="/"?"":"/");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
        }
    



        public function setDataFromArray($dataAry)
        {
            parent::setDataFromArray($dataAry);
            
            // Check if the file exists on the remote server
            $ch = curl_init($this->streamDir.$this->videoFile);
            curl_setopt($ch, CURLOPT_NOBODY, true);
            curl_exec($ch);
            $retcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);  // $retcode > 400 -> not found, $retcode = 200, found.
            curl_close($ch);
            
            if( $retcode != "200" )
            {
                $this->activeDir = $this->rootPath.$this->storeDir.$this->videoDir;
                $curDir = realpath($this->rootPath.$this->storeDir);
                $curDir .= substr($curDir, -1) != "/" ? "/" : "";

                $cmd = $curDir."upload/apps/ftp.sh {$this->videoFile} {$curDir}{$this->videoDir} {$_SERVER['SERVER_NAME']} > /dev/null 2?&1 &";
                //echo $cmd; return;
                exec($cmd);
            }
        }





    
    
    
        public function getResizePreview($h=150, $w=150)
        {
            $ret = $this->img->getResizedImage($this->rootPath.$this->storeDir.$this->imageDir, "", $this->previewFile, $this->id, $h, $w );
            $this->resizeH = $this->img->resizeH;
            $this->resizeW = $this->img->resizeW;
            return $ret;
        }
        
        
        
        
        public function getVideoDirectory($includeRootPath = null)
        {
            if( is_null( $includeRootPath ) )
                $includeRootPath = true;
                
            $ret = "";
            
            if( $includeRootPath !== false )
                $ret .= $this->rootPath;
                
            $ret .= $this->storeDir . $this->videoDir;
            
            return $ret;
        }

    }
    
    
    
    
    
    class bseVideoTubeFiles extends bseCollection
    {
    
        protected $rootPath,
                  $storeDir;




        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot);
            $this->setTableName("bseVideos");
            $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");
            $this->storeDir = "modules/bseVideoTube/";
        }
        
        public function resetRoot($newRoot)
        {
            $this->rootPath = $newRoot . ( substr($newRoot, -1) == "/" ? "" : "/" );
            foreach($this->ary as $item)
                if( is_object($item) ) { $item->resetRoot($this->rootPath); };
        }
        

        
        public function setDataFromGalleryId($galid)
        {
            $id = $this->getEscapedString($galid);
            $query = $this->getQueryResult("SELECT * FROM `{$this->table}` WHERE `gallery_id` = '$id'");
            
            while( $data = mysql_fetch_assoc($query) )
            {
                $tmp = new bseVideoTubeFile($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
                unset($tmp);
            }
        }
    
    }

    
?>