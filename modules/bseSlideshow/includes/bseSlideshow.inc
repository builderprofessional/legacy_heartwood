<?php

global $slideshowTbl, $slideshowImgTbl;

$slideshowTbl = "bseSlideshows";
$slideshowImgTbl = "bseSlideshowImages";

    class bseSlideshow extends bseModule
    {
    
        public  $width,
                $height,
                $config_width,
                $config_height,
                $images=null;

        private $imageDir;
         
        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseSlideshow/");
            $this->setTableName($GLOBALS['slideshowTbl']);

            
            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");


            $this->img = new bseImageManipulator();
            $this->width = $this->config_width = $dynMov_Width;
            $this->height = $this->config_height = $dynMov_Height;
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
            
            $this->images = new bseSlideshowImages($this->rootPath);
            $this->images->setDataFromId($this->id);
        }
        
        
        
        
        public function resetRoot($rootPath)
        {
        	parent::resetRoot($rootPath);
        	
        	if( !is_null($this->images) )
        		$this->images->resetRoot($rootPath);
        		
        }

        


        
        
        
        
        
        public function getProcessScriptHref()
        {
            return $this->rootPath.$this->storeDir."processShow.php";
        }

        
        public function getJavascriptURL($rootPath=null)
        {
        	if( is_null($rootPath) )
        	{
        		$rootPath = "./";
        	}
        	
        	$url = $rootPath . $this->storeDir . "includes/slideshow.js.php";
        	if( file_exists( $url ) )
        		return $url;
        		
        	else
        	{
        		throw new Exception("bseSlideshow::getJavascriptURL(): File not found on line " . __LINE__ . ". Cannot continue without the javascript file.");
        		return false;
        	}
        }
        
    } // End bseDynamic class







    class bseSlideshowImages extends bseCollection
    {
        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot);
            $this->setTableName($GLOBALS['slideshowImgTbl']);
            $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");
            $this->storeDir = "modules/bseSlideshow/";
        }
        
        
        
        
        public function setDataFromId($idVal)
        {
            $id = $this->getEscapedString($idVal);
            
            $query = $this->getQueryResult("SELECT * FROM `{$this->table}` WHERE `show_id` = '$id' ORDER BY `sorder` ASC");
            while( $data=mysql_fetch_assoc($query) )
            {
                $tmp = new bseSlideshowImage($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
                unset($tmp);
            }
        }
        
        
        
        public function resetRoot($rootPath)
        {
        	$this->rootPath = $rootPath;
        	foreach($this->ary as $item)
        		$item->resetRoot($rootPath);
        }
    }  // End bseSlideshowImages class










    class bseSlideshowImage extends bseModule
    {
    
        public  $resizeW,
                $resizeH;
                
        private $img;





        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseSlideshow/");
            $this->setTableName($GLOBALS['slideshowImgTbl']);

            
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
            if( !file_exists($path.$this->file) )
                return "";
            else
                return $path.$this->file;
        }
        
        
        
    }   // End bseSlideshowImage class
?>