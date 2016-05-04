<?php

class bseContent extends bseModule
{

        private $img,
                $imageDir,
                $displayPage;

        public function __construct($rootPath="./", $page=null)
        {
            parent::__construct($rootPath, "modules/base/content/");
            $this->setTableName("bseContentData");

            if( isset($page) )
            {
                $dataArray = $this->getQueryData("SELECT * FROM `bseContentData` WHERE `page` = '$page'");

                if( !empty($dataArray) )
                {
                    foreach( $dataArray as $key => $value )
                    {
                        $this->$key = $value;
                    }
                }
            }

            $odir = $this->chgDir();
            include("config.inc");
            chdir($odir);
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
            $this->img = new bseImageManipulator();
        }




        public function setContentId($contentid)
        {
            $id = $this->getEscapedString($contentid);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$id'");
            $this->setDataFromArray($data);
        }





        public function getContent($page=null)
        {
            if( !isset($page) && !isset($this->displayPage) )
            {
                throw new Exception("bseContent::getContent(): 'No Page Selected' on line ".__LINE__);
                return "";
            }

            if( isset($page) )
                $this->displayPage = $this->getEscapedString($page);

            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `page`='{$this->displayPage}'");
            if( !empty($data) )
            {
                foreach( $data as $key => $value )
                {
                    $this->$key = $value;
                }
            }
            else
            {
                unset($this->page, $this->code, $this->title, $this->javascript, $this->metaDesc, $this->metaKeywords);
            }
        }



        public function getImageHref()
        {
            $file = $this->rootPath.$this->storeDir.$this->imageDir.$this->image_file;
            if( file_exists($file) )
                return $file;

            else
                return "file=$file";
        }



        public function getResizedImage($h=150, $w=150)
        {
            return $this->img->getResizedImage($h, $w, $this->getImageHref());
        }



        public function getCssHref()
        {
            return $this->rootPath."css/site_style.css.php";
        }
        
        
        public function getResourceDir()
        {
            return $this->storeDir.$this->imageDir;
        }




/***********************    Private Functions    ************************/



        private function chgDir()
        {
            $cur = getcwd();
            chdir(dirname(__FILE__));
            return $cur;
        }
}

?>