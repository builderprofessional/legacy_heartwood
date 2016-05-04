<?php

global $sitemapTbl;

$sitemapTbl = "bseSitemap";




class bseSitemap extends bseCollection
{

        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseSitemap/");
            $this->setTableName($GLOBALS['sitemapTbl']);
            
            $this->rootPath = $pathToDocRoot . ( substr($pathToDocRoot, -1) == "/" ? "" : "/" );
            $this->storeDir = "modules/bseSitemap/";
        }
        
        
        
        
        public function getAdminTemplateHref()
        {
            return "sitemapAdmin.tpl";
        }
        
        
        
        public function getAdminSubmitHref()
        {
            return $this->rootPath . $this->storeDir . "processSitemap.php";
        }
        
        
        
        
        
        public function setAllData()
        {
            $res = $this->getQueryResult("SELECT * FROM `{$this->table}` ORDER BY `sorder` ASC");
            while( $data = mysql_fetch_assoc($res) )
            {
                $tmp = new bseSitemapItem($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
                unset($tmp);
            }
        }
        
        
        
        
        
        public function insertNew()
        {
            $newid = parent::insertNew();
            $tmp = new bseSitemapItem($this->rootPath);
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


}











class bseSitemapItem extends bseModule
{

        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseSitemap/");
            parent::setTableName($GLOBALS['sitemapTbl']);
/*
            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
*/
        }
        

}


?>