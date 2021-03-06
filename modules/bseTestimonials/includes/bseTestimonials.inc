<?php

global $testimonialsTbl;

$testimonialsTbl = "bseTestimonials";




class bseTestimonialItems extends bseCollection
{

        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseBuildProcess/");
            $this->setTableName($GLOBALS['testimonialsTbl']);
            
            $this->rootPath = $pathToDocRoot . ( substr($pathToDocRoot, -1) == "/" ? "" : "/" );
            $this->storeDir = "modules/bseTestimonials/";
        }
        
        
        
        
        public function getAdminTemplateHref()
        {
            return "testimonialAdmin.tpl";
        }
        
        
        
        public function getAdminSubmitHref()
        {
            return $this->rootPath . $this->storeDir . "processTestimonials.php";
        }
        
        
        
        
        
        public function setAllData()
        {
            $res = $this->getQueryResult("SELECT * FROM `{$this->table}` ORDER BY `sorder` ASC");
            while( $data = mysql_fetch_assoc($res) )
            {
                $tmp = new bseTestimonialItem($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
                unset($tmp);
            }
        }
        
        
        
        
        public function insertNew()
        {
            $newid = parent::insertNew();
            $tmp = new bseTestimonialItem($this->rootPath);
            $tmp->setItemId($newid);
            $this->add($tmp);
            return $newid;
        }

        
        


        public function resetRoot($rootPath)
        {
             $this->rootPath = $rootPath.(substr($rootPath, -1)=="/"?"":"/");
             foreach($this->ary as $item)
                 $item->resetRoot($this->rootPath);
        }


        
        
        public function &getDataArray()
        {
            return $this->ary;
        }
        
        
        
        
        
        public function arrangeBySortorder()
        {
            $this->sortArray("sorder", 1);
        }

}










class bseTestimonialItem extends bseModule
{

        private $imageDir,
                $img;

        public  $resizeH,
                $resizeW;

        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseTestimonials/");
            parent::setTableName($GLOBALS['testimonialsTbl']);

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
            $this->img = new bseImageManipulator();
        }
        
        

        
        
        
        
        


        public function getImageHref()
        {
            $file = $this->rootPath.$this->storeDir.$this->imageDir.$this->image_file;
            if( file_exists($file) )
                return "$file";

            else
                return "";
        }



        public function getPreviewImage($h=150, $w=150, $imgFile=null)
        {
            if( $imgFile == null )
                $imgFile = $this->image_file;
        
            $ret = $this->img->getResizedImage($this->rootPath.$this->storeDir.$this->imageDir, "_thumbs", $imgFile, $this->id, $h, $w );
            $this->resizeH = $this->img->resizeH;
            $this->resizeW = $this->img->resizeW;
            return $ret;
        }



}



?>