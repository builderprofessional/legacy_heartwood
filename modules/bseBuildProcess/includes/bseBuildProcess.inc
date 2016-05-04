<?php

global $buildTbl;

$buildTbl = "bseBuildProcess";




class bseBuildProcessItems extends bseCollection
{

        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseBuildProcess/");
            $this->setTableName($GLOBALS['buildTbl']);
            
            $this->rootPath = $pathToDocRoot . ( substr($pathToDocRoot, -1) == "/" ? "" : "/" );
            $this->storeDir = "modules/bseBuildProcess/";
        }
        
        
        
        
        public function getAdminTemplateHref()
        {
            return "processAdmin.tpl";
        }
        
        
        
        public function getAdminSubmitHref()
        {
            return $this->rootPath . $this->storeDir . "processBuildProcess.php";
        }
        
        
        
        
        
        public function setAllData()
        {
            $res = $this->getQueryResult("SELECT * FROM `{$this->table}` ORDER BY `sorder` ASC");
            while( $data = mysql_fetch_assoc($res) )
            {
                $tmp = new bseBuildProcessItem($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
                unset($tmp);
            }
        }
        
        
        
        
        public function insertNew()
        {
            $newid = parent::insertNew();
            $tmp = new bsePhotoGalleryImage($this->rootPath);
            $tmp->setImageId($newid);
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










class bseBuildProcessItem extends bseModule
{

        private $imageDir,
                $img;

        public  $resizeH,
                $resizeW;

        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseBuildProcess/");
            parent::setTableName($GLOBALS['buildTbl']);

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
            $this->img = new bseImageManipulator();
        }
        
        

        
        
        
        
/*
        public function setId($id)
        {
            $imgid = $this->getEscapedString($id);
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$imgid'");
            $this->setDataFromArray($data);
        }
*/        
        
        
        


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