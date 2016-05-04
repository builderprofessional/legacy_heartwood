<?php

// Global variables of the table names used in this class (global so they can be accessed within the classes)

global $tblPages, $tblBrochure;

$tblPages = "bseBrochurePages";
$tblBrochure = "bseBrochures";




/*
    Holds the info from the database for the pages that are in a brochure
//*/
    class bseBrochurePage extends bseModule
    {
        public  $docsDir,
                $pageDir;
                

        public function __construct($pathToModuleRoot)
        {
            parent::__construct($pathToModuleRoot, "modules/bseBrochure/");
            parent::setTableName($GLOBALS['tblPages']);

            include("$this->rootPath{$this->storeDir}includes/config.inc");

            $this->pageDir = $pagesDir.(substr($pagesDir, -1)=="/"?"":"/");
            $this->docsDir = $docsDir.(substr($docsDir, -1)=="/"?"":"/");
        }
        
        
        
    }
    
    
    
    
    
    
    
/*
    Holds the info from the database for the brochure and
    outputs html code to put the brochure on a page.
//*/    
    
    class bseBrochure extends bseModule
    {
        private $pages = Array();
                
        public $DOM_ID,
               $docsDir,
               $pagesDir;
        
        public function __construct($pathToModuleRoot)
        {
            parent::__construct($pathToModuleRoot, "modules/bseBrochure/");
            parent::setTableName($GLOBALS['tblBrochure']);
            
        }
        
        
        
        
        public function setDataFromArray($dataAry)
        {
            parent::setDataFromArray($dataAry);
            $this->DOM_ID = "bseBrochure_{$this->id}";

            $query = $this->getQueryResult("SELECT * FROM `{$GLOBALS['tblPages']}` WHERE `brochureid` = '{$this->id}'");
            while( $data = mysql_fetch_assoc($query) )
            {
                $tmp = new bseBrochurePage($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->addPage($tmp);
                unset($tmp);
            }
            include("$this->rootPath{$this->storeDir}includes/config.inc");
            $this->pageDir = $pagesDir.(substr($pagesDir, -1)=="/"?"":"/");
            $this->docsDir = $docsDir.(substr($docsDir, -1)=="/"?"":"/");
        }
        
        
        
        
        
        public function addPage(bseBrochurePage $page)
        {
            $this->pages[$page->id] = $page;
        }
        
        
        public function removePage($pageID)
        {
            $this->pages[$pageID]->delete();
            unset($this->pages[$pageID]);
        }
        
        
        public function getOutput()
        { 
?>
            <object
                type="application/x-shockwave-flash"
                id="<?=$this->DOM_ID?>"
                width="<?=intval($this->width) * 2?>"
                height="<?=$this->height?>"
                data="<?=$this->rootPath.$this->storeDir?>includes/bseBrochure.swf"
                quality="high"
                allowScriptAccess="sameDomain"
                wmode="transparent"
                FlashVars="pageWidth=<?=$this->width?>&pageHeight=<?=$this->height?>&xmlFile=<?=$this->rootPath.$this->storeDir?>includes/getBrochureInfo.php&idNum=<?=$this->id?>&rootDir=<?=$this->rootPath.$this->storeDir?>&zoomPcnt=<?=$this->maxZoom?>"
            >
                <param name="movie" value="<?=$this->rootPath.$this->storeDir?>includes/bseBrochure.swf" />
                <param name="quality" value="high" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="wmode" value="transparent" />
                <param name="FlashVars" value="pageWidth=<?=$this->width?>&pageHeight=<?=$this->height?>&xmlFile=<?=$this->rootPath.$this->storeDir?>includes/getBrochureInfo.php&idNum=<?=$this->id?>&rootDir=<?=$this->rootPath.$this->storeDir?>&zoomPcnt=<?=$this->maxZoom?>" />
            </object>
<?php
        }


        public function insertIntoDB($connection = null)
        {
            if( isset( $connection ) )
                $this->connection = $connection;
            
            if( !$this->getQueryResult("INSERT INTO `{$this->tableName}` SET `pdfFile`=''") )
            {
                echo mysql_error();
                exit();
            }
            $id = $this->getInsertId();

            $res = $this->getQueryResult("SELECT * FROM `{$this->tableName}` WHERE `id` = '$id'");
            $dataArray = mysql_fetch_assoc($res);
            $this->setDataFromArray($dataArray);
            
            return $id;
        }




        
        
        public function getAdminFormSubmitHref()
        {
            return $this->rootPath . $this->storeDir . "makeBrochure.php";
        }
        
        
        
        
        public function getAdminTemplateHref()
        {
            return "brochureAdmin.tpl";
        }
        
        
        
        
        public function getPDF_HREF()
        {
            return $this->rootPath.$this->storeDir.$this->docsDir.$this->pdfFile;
        }
        


    }

?>