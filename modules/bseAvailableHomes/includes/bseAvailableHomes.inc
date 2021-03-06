<?php

global $homesTable, $homesPageTable;

$homesTable = "bseHomes";
$homesPageTable = "bseHomesPage";



class bseAvailableHome extends bseModule
{

        //public  $gallery;
        public  $resizeW,
                $resizeH;

        private $img,
                $imageDir;
         
        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseAvailableHomes/");
            $this->setTableName($GLOBALS['homesTable']);

            
            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");


            $this->img = new bseImageManipulator();
            //$this->gallery = new bseHomeGallery($this->id, $pathToDocRoot);
        }
        
        
        public function setHomeId($id)
        {
            $homeid = $this->getEscapedString($id);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$homeid'");
            $this->setDataFromArray($data);
        }
        


        public function getPrice()
        {
            $ret = str_replace('$', "", str_replace(",", "", $this->price));
            if( @trim($ret) != "" )
                return number_format($ret);
            else
                return "";
        }
            



        public function getResizedImage($h=150, $w=150)
        {
            $imgFile = "comingSoon.jpg";
            if( @trim( $this->image_file ) != "" )
                $imgFile = $this->image_file;
                
            $ret = $this->img->getResizedImage($this->rootPath.$this->storeDir.$this->imageDir, "_thumbs", $imgFile, $this->id, $h, $w );
            $this->resizeH = $this->img->resizeH;
            $this->resizeW = $this->img->resizeW;
            return $ret;
        }



        public function getBriefDescription($length=150)
        {
            $ret = $this->description;

            if( strlen($this->description) > $length )
                 $ret = substr($this->description, 0, $length - 3) . "...";

            return $ret;
        }
        
        
        
        
        public function getImageHref()
        {
            $path= $this->rootPath.$this->storeDir.$this->imageDir;
            if( !file_exists($path.$this->image_file) || @trim( $this->image_file ) == "" )
                return $path."comingSoon.jpg";
            else
                return $path.$this->image_file;
        }
        
        
        
        public function getFloorplanHref()
        {
            $ret = "";
            
            if( $this->hasFloorplan() )
                $ret = $this->rootPath.$this->storeDir.$this->imageDir.( trim($this->fp_pdf) != "" ? $this->fp_pdf : trim($this->fp_jpg) );
            
            return $ret;
        }



          
        public function getStatus()
        {
            if( !$this->isSold() )
                return "<span class=\"homeAvailableText \">$this->status</span>";
                  
            else
                return "<span class=\"homeSoldText \">" . strtoupper($this->status) . "</span>";
        }
          
          
        public function isSold()
        {
            return ( strpos(strtolower($this->status), "sold") === false ? false : true );
        }
        
        
        
        public function hasFloorplan()
        {
            return trim($this->fp_pdf) != "" || trim($this->fp_jpg) != "";
        }
        
        
        public function hasGallery()
        {
            return $this->gallery_id > 0;
        }
        
        
        
        public function getDetailGradientHref()
        {
            return $this->rootPath.$this->storeDir.$this->imageDir."iface/detailGradient.png";
        }
        
        public function getDetailTabHref()
        {
            return $this->rootPath.$this->storeDir.$this->imageDir."iface/tab.png";
        }

        public function getDetailTabDownHref()
        {
            return $this->rootPath.$this->storeDir.$this->imageDir."iface/tab_down.png";
        }

}







/*********************************************************************************
Available Homes Collection
*********************************************************************************/
class bseAvailableHomes extends bseCollection
{
        protected $rootPath,
                  $storeDir;




        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot);
            $this->setTableName($GLOBALS['homesPageTable']);
            $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");
            $this->storeDir = "modules/bseAvailableHomes/";
//            include("{$this->rootPath}{$this->storeDir}includes/config.inc");

        }
        
        public function resetRoot($newRoot)
        {
            $this->rootPath = $newRoot . ( substr($newRoot, -1) == "/" ? "" : "/" );
            foreach($this->ary as $item)
                if( is_object($item) ) { $item->resetRoot($this->rootPath); };
        }
        
        

        
        
        public function setPage($page)
        {
            if( trim($page) == "" || !isset($page) )
            {
                throw new Exception("bseAvailableHomes::setPage() - No Page specified for available homes collection on line ".__LINE__);
                return false;
            }
            
            $this->ary = array();
            $homesPage = $this->getEscapedString($page);
            
            $sql = "SELECT * FROM `{$this->table}` WHERE `page` = '$homesPage'";
            $data = $this->getQueryData($sql);
            parent::setDataFromArray($data);
            
            
            $res = $this->getQueryResult("SELECT * FROM `{$GLOBALS['homesTable']}` WHERE `page_id`='{$this->id}'");
            while( $data = mysql_fetch_array($res) )
            {
                $tmpHome = new bseAvailableHome($this->rootPath);
                $tmpHome->setDataFromArray($data);
                $this->add($tmpHome);
                unset( $tmpHome );
            }
        }
        
        
        
        
        public function setAllHomes()
        {
            $this->ary = array();
            $this->id = -1;
            $sql = "SELECT * FROM `{$GLOBALS['homesTable']}`";
            $query = $this->getQueryResult($sql);
            
            while( $data = mysql_fetch_assoc($query) )
            {
                $tmpHome = new bseAvailableHome($this->rootPath);
                $tmpHome->setDataFromArray($data);
                $this->add($tmpHome);
                unset($tmpHome);
            }
        }
        
        
        
        
        public function &getFeaturedHomesCol()
        {
            $ret = new bseAvailableHomes($this->rootPath);
            foreach( $this->ary as $tmp )
            {
                if( $tmp->featured )
                    $ret->add($tmp);
            }
            
            return $ret;
        }




        public function &getSqftFilteredCol($minSqft, $maxSqft)
        {
            $ret = new bseAvailableHomes($this->rootPath);
            
            foreach( $this as $home )
            {
                if( $home->sqft >= $minSqft && $home->sqft <= $maxSqft )
                    $ret->add($home);
            }
            
            return $ret;
        }




        public function &getCommFilteredCol($commid)
        {
            $ret = new bseAvailableHomes($this->rootPath);
            
            foreach($this as $home)
            {
                if( $home->community_id == $commid )
                    $ret->add($home);
            }
            
            return $ret;
        }

       
       
        public function &getFilteredHomes($filter, $value)
        {
            $ret = new bseAvailableHomes($this->rootPath);
            
            foreach($this as $home)
            {
                if( $home->$filter == $value )
                    $ret->add($home);
            }
            
            return $ret;
        }
        


        
        
      

        public function sortByCommunity()
        {
            return $this->sortArray("community");
        }

        public function sortByPrice()
        {
            return $this->sortArray("price");
        }

        public function sortBySize()
        {
            return $this->sortArray("sqft");
        }

        public function getDisplayArray()
        {
            return $this->ary;
        }



        
        
        
        
        
        public function getAdminTemplateHref()
        {
            return "homesAdminTemplate.tpl";
        }
        
        
        
        public function getAdminFormSubmitHref()
        {
            return $this->rootDir.$this->storeDir."process_home.php";
        }

        
        
        public function getHomesListTemplateHref()
        {
            return "homesList.tpl";
        }

        
        
        public function getStyleLinkCode()
        {
            return "<link rel=\"stylesheet\" type=\"text/css\" href=\"{$this->rootPath}modules/includes/css/bseAvailableHomes.css\" media=\"screen\" />";
        }
        
        
        
        
        public function insertNewHome()
        {
            $query = $this->getQueryResult("INSERT INTO `{$GLOBALS['homesTable']}` SET `id` = NULL");
            if( $query )
                return $this->getInsertId();
            
            else
                return null;
        }
        
        
        
        
        private function removeAll()
        {
            foreach($this as $home)
                $this->remove($home->id);
        }

}
