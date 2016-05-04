<?php

    class bseRemodelingGalleryImage extends bseModule
    {
        public $duringGallery,
               $imageDir,
               $bseImage,
               $img;
               
               
        public function __construct($pathToDocRoot)
        {
            parent::__construct($pathToDocRoot, "modules/bseRemodelingGallery/");

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
            $this->img = new bseImageManipulator();
        }
        



        
        public function setDataFromArray($dataAry)
        {
            parent::setDataFromArray($dataAry);
            
            if( $this->during_galid > 0 )
            {
                $this->duringGallery = new bsePhotoGallery($this->rootPath);
                $this->duringGallery->setGalleryId($this->during_galid);
            }
        }
        
        


        public function getPreviewImage($h=150, $w=150, $imgFile=null)
        {
            if( $imgFile == null )
                $imgFile = $this->bseImage->image_file;
        
            $ret = $this->img->getResizedImage($this->rootPath.$this->storeDir.$this->imageDir, "_thumbs", $imgFile, $this->id, $h, $w );
            $this->resizeH = $this->img->resizeH;
            $this->resizeW = $this->img->resizeW;
            return $ret;
        }



    }
    
?>