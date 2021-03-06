<?php

global $flashTbl, $flashImgTbl;

$flashTbl = "bseFlashSlideshows";
$flashImgTbl = "bseFlashSlideshowImages";

    class bseDynamicFlash extends bseModule
    {
    
        public  $width,
                $height,
                $images=null;

        private $imageDir;
         
        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseDynamicFlash/");
            $this->setTableName($GLOBALS['flashTbl']);

            
            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");


            $this->img = new bseImageManipulator();
            $this->width = $dynMov_Width;
            $this->height = $dynMov_Height;
        }
        
        
        
        




        public function setId($idVal)
        {
            $id = $this->getEscapedString($idVal);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$id'");
            $this->setDataFromArray($data);
        }
        
        
        public function setDataFromArray($data)
        {
            parent::setDataFromArray($data);
            
            $this->images = new bseDynamicFlashImages($this->rootPath);
            $this->images->setDataFromId($this->id);
        }

        


        
        
        
        public function getObjectCode()
        {
            echo <<< CODE

            <object
                type="application/x-shockwave-flash"
                id="SlideShow"
                width="{$this->width}px"
                height="{$this->height}px"
                data="{$this->rootPath}{$this->storeDir}includes/viewer.swf"
                quality="high"
                wmode="transparent"
                FlashVars="dataFile={$this->rootPath}{$this->storeDir}includes/flashGallery.php"
            >
                        <param name="movie" value="{$this->rootPath}{$this->storeDir}includes/viewer.swf" />
                        <param name="quality" value="high" />
                        <param name="flashvars" value="dataFile={$this->rootPath}{$this->storeDir}includes/flashGallery.php" />
                        <param name="wmode" value="transparent" />
            </object>

CODE;
        }
        
        
        
        
        public function getProcessScriptHref()
        {
            return $this->rootPath.$this->storeDir."processFlash.php";
        }

        
        
        
    } // End bseDynamicFlash class







    class bseDynamicFlashImages extends bseCollection
    {
        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot);
            $this->setTableName($GLOBALS['flashImgTbl']);
            $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");
            $this->storeDir = "modules/bseDynamicFlash/";
        }
        
        
        
        
        public function setDataFromId($idVal)
        {
            $id = $this->getEscapedString($idVal);
            
            $query = $this->getQueryResult("SELECT * FROM `{$this->table}` WHERE `show_id` = '$id' ORDER BY `sorder` ASC");
            while( $data=mysql_fetch_assoc($query) )
            {
                $tmp = new bseDynamicFlashImage($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
                unset($tmp);
            }
        }
    }  // End bseDynamicFlashImages class










    class bseDynamicFlashImage extends bseModule
    {
    
        public  $resizeW,
                $resizeH;
                
        private $img;





        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseDynamicFlash/");
            $this->setTableName($GLOBALS['flashImgTbl']);

            
            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");


            $this->img = new bseImageManipulator();
        }







        public function getResizedImage($h=150, $w=150)
        {
            $ret = $this->img->getResizedImage($this->rootPath.$this->storeDir.$this->imageDir, "_thumbs", $this->file, $this->id, $h, $w );
            $this->resizeH = $this->img->resizeH;
            $this->resizeW = $this->img->resizeW;
            return $ret;
        }

        





        public function getImageHref()
        {
            $path= $this->rootPath.$this->storeDir.$this->imageDir;
            if( !file_exists($path.$this->image_file) )
                return "";
            else
                return $path.$this->image_file;
        }
        
        
        
    }   // End bseDynamicFlashImage class
?>