<?php

global $galTbl, $galImgsTbl, $galCatsTbl;

$galTbl     = "bsePhotoGalleries";
$galCatsTbl = "bsePhotoGalleryCategories";
$galImgsTbl = "bsePhotoGalleryImages";

class bsePhotoGalleryCategories extends bseCollection
{

        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseGallery/");
            $this->setTableName($GLOBALS['galCatsTbl']);
            
            $this->rootPath = $pathToDocRoot . ( substr($pathToDocRoot, -1) == "/" ? "" : "/" );
            $this->storeDir = "modules/bseGallery/";
        }
        
        
        
        public function setGalleryId($id)
        {
            if( $this->id == $id )
            {
                return;
            }
            
            
            $galid = $this->getEscapedString($id);

            $res = $this->getQueryResult("SELECT * FROM `{$this->table}` WHERE `galid` = '$galid'");
            if( mysql_num_rows($res) > 0 )
            {
                while( $data = mysql_fetch_assoc($res) )
                {
                    $tmp = new bsePhotoGalleryCategory($this->rootPath);
                    $tmp->setDataFromArray($data);
                    $this->add($tmp);
                }
            }
        }
        
        
        
        public function insertNew()
        {
            $newid = parent::insertNew();
            $tmp = new bsePhotoGalleryCategory($this->rootPath);
            $tmp->setCategoryId($newid);
            $this->add($tmp);
            return $newid;
        }
        
        
        


        public function resetRoot($rootPath)
        {
            $this->rootPath = $rootPath.(substr($rootPath, -1)=="/"?"":"/");
            foreach($this->ary as $item)
            {
                if( is_object($item) )
                    $item->resetRoot($this->rootPath);
            }
        }
        
        
        
        
        public function arrangeBySortorder()
        {
            $this->sortArray("sorder", 1);
        }

}



class bsePhotoGalleryCategory extends bseModule
{


        public $images;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseGallery/");
            $this->setTableName($GLOBALS['galCatsTbl']);
        }
        
        
        public function setCategoryId($id)
        {
            $catid = $this->getEscapedString($id);
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$catid'");
            $this->setDataFromArray($data);
        }
        
        
        
        public function setDataFromArray($data)
        {
            parent::setDataFromArray($data);
            
            $this->images = new bsePhotoGalleryImages($this->rootPath);
            $this->images->setDataFromCategoryId($this->id);
        }
        
        
        
        public function resetRoot($newRootPath)
        {
            parent::resetRoot($newRootPath);
            $this->images->resetRoot($this->rootPath);
        }
        
        
        
        
        public function &getImagesArray($pageNum, $picsPerPage)
        {
            $ary = $this->images->getDataArray();
            $retAry = array();
            $start = ($pageNum-1)*$picsPerPage;
            $count = 0;
            
            foreach( $ary as $pic )
            {
                if( $count++ >= $start )
                {
                    if( $count <= $start + $picsPerPage )
                        $retAry[$pic->id] = $pic;
                    else
                        break;
                }
                else
                    continue;
            }

            return $retAry;
        }


        
        
}




















class bsePhotoGalleryImages extends bseCollection
{

        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseGallery/");
            $this->setTableName($GLOBALS['galImgsTbl']);
            
            $this->rootPath = $pathToDocRoot . ( substr($pathToDocRoot, -1) == "/" ? "" : "/" );
            $this->storeDir = "modules/bseGallery/";
        }
        
        
        
        public function setDataFromCategoryId($id)
        {
            $catid = $this->getEscapedString($id);

            $res = $this->getQueryResult("SELECT * FROM `{$this->table}` WHERE `catid` = '$catid'");
            while( $data = mysql_fetch_assoc($res) )
            {
                $tmp = new bsePhotoGalleryImage($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
            }
            $this->arrangeBySortorder();
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










class bsePhotoGalleryImage extends bseModule
{

        private $imageDir,
                $img;

        public  $resizeH,
                $resizeW;

        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseGallery/");
            parent::setTableName($GLOBALS['galImgsTbl']);

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
            $this->img = new bseImageManipulator();
        }
        
        

        
        
        
        
        public function setImageId($id)
        {
            $imgid = $this->getEscapedString($id);
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$imgid'");
            $this->setDataFromArray($data);
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
















class bsePhotoGallery extends bseModule
{
        private $curPage,
                $imageDir,
                $curCategory;

        public  $categories;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseGallery/");
            $this->setTableName($GLOBALS['galTbl']);

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");

            $this->curPage = 1;
        }
        
        
        
        
        
        public function setGalleryId($id)
        {
            if( isset($this->id) ) if( $this->id == $id )
                return;

            $galid = $this->getEscapedString($id);
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$galid'");
            $this->setDataFromArray($data);
        }
        
        
        
        
        public function setGalleryFromUserId($userid)
        {
            $id = $this->getEscapedString($userid);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `user_id` = '$id'");
            if( $data == false )
            {
                $this->id = -1;
            }
            else
            {
                $this->setDataFromArray($data);
            }
        }
        
        
        
        
        public function setDataFromArray($aryData)
        {
            parent::setDataFromArray($aryData);
            
            $this->categories = new bsePhotoGalleryCategories($this->rootPath);
            $this->categories->setGalleryId($this->id);
        }
        
        
        
        public function setCurrentCategory($catid)
        {
            $this->curCategory = $catid;
        }
        




        public function resetRoot($newRoot)
        {
             parent::resetRoot($newRoot);
             if( is_object($this->categories) )
                $this->categories->resetRoot($this->rootPath);
        }



        public function getFormSubmitHref()
        {
            return $this->rootPath.$this->storeDir."galleryProcessor.php";
        }
        
        
        
        public function getGalleryStyleLink()
        {
            return "<link rel=\"stylesheet\" type=\"text/css\" href=\"{$this->rootPath}css/bsePhotoGallery.css\" media=\"screen\" />";
        }
        
        
        
        public function getImgManagerHref($showCatid=true)
        {
            $catCode = "";
            if( $this->curCategory > 0 && $showCatid )
                $catCode = "?catid={$this->curCategory}";
            return $this->rootPath.$this->storeDir."galleryManager.php$catCode";
        }



        public function currentPage()
        {
            return $this->curPage;
        }
        
        public function setCurrentPage($page)
        {
            $this->curPage = $page;
        }


        public function picsPerPage()
        {
            return $this->rows * $this->cols;
        }
        
        
        
        public function numPics()
        {
            $ret = false;
            
            if( $this->curCategory > 0 )
            {
                $cat = $this->categories->getItemById($this->curCategory);
                $ret = $cat->images->count();
            }
            else
            {
                throw new Exception("bsePhotoGallery::numPics(".__LINE__."): Trying to get number of pics without a category selected.");
            }
            
            return $ret;
        }
        
        
        
        
        public function numPages()
        {
            $ret = false;
            
            if( $this->curCategory != 0 )
            {
                $ret = ceil( $this->numPics() / $this->picsPerPage() );
            }
            else
                throw new Exception("bsePhotoGallery::numPages(".__LINE__."): Trying to get number of pages without a category selected.");
        
            return $ret;
        }
        


        public function getGalleryTemplateHref()
        {
            return "galleryLayout.tpl";
        }
        
        
        
        public function getActiveCategoryId()
        {
            return $this->curCategory;
        }
        
        
}



class bsePhotoGalleries extends bseCollection
{
        private $rootPath,
                $storeDir;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot);
            $this->setTableName($GLOBALS['galTbl']);
            $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");
            $this->storeDir = "modules/bseGallery/";
//            include("{$this->rootPath}{$this->storeDir}includes/config.inc");

        }
        
        public function resetRoot($newRoot)
        {
            $this->rootPath = $newRoot . ( substr($newRoot, -1) == "/" ? "" : "/" );
            foreach($this->ary as $item)
                if( is_object($item) ) { $item->resetRoot($this->rootPath); };
        }
        
        
        
        
        
        
        
        public function setAllGalleries()
        {
            $query = $this->getQueryResult("SELECT * FROM `{$this->table}`");
            
            while( $data = mysql_fetch_assoc($query) )
            {
                $tmp = new bsePhotoGallery($this->rootDir);
                $tmp->setDataFromArray($data);
                if( @trim($tmp->id) != "" && @trim($tmp->id) > 0 )
                {
                    $this->add($tmp);
                }
            }
        }

}
?>