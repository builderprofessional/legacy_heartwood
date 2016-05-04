<?php

global $conTbl,
       $consTbl;


$conTbl = "bseContactUs";
$consTbl = "bseContacts";

class bseContact extends bseModule
{

        private $imageDir,
                $img;
                 
        public  $resizeH,
                $resizeW;
                 

        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/bseContactUs/");
            $this->setTableName($GLOBALS['consTbl']);

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");
            $this->img = new bseImageManipulator();
        }
        
        
        
        
        
        
        public function insertNewContact()
        {
            $this->getQueryResult("INSERT INTO `{$this->table}` SET `id` = null");
            $id = $this->getInsertId();
            $this->setContactId($id);
            
            return $id;
        }




        public function setContactId($id)
        {
            $conid = $this->getEscapedString($id);
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$conid'");
            $this->setDataFromArray($data);
        }






        public function getEmailCode()
        {
            $ret = "";
            if( $this->email != "" )
            {
                if( strpos(strtolower($this->email), "mailto") === false )
                    $ret = "<a class=\"contactEmailLink\" href=\"mailto:{$this->email}\">{$this->email}</a>";
                else
                    $ret = $this->email;
             }
             return $ret;
        }





// ***** Phone Number functions ****** //

        private function formatPhone($number)
        {
            $ret = "";
            if( $number !== "" )
            {
                $ret = str_replace("-", "", $number);
                if( strlen($ret) > 7 )
                {
                    $acode = substr($ret, 0, 3);
                    $prefix = substr($ret, 3, 3);
                    $lineNum = substr($ret, 6, 4);
                    $extra = substr($ret, 10, strlen($ret) - 10);
                    $ret = "$acode-$prefix-$lineNum". ( trim($extra)==""?"": (substr($extra, 0, 1)==" "?",".$extra: $extra));
                }
                else if( strlen($ret) == 7 )
                {
                    $prefix = substr($ret, 3, 3);
                    $lineNum = substr($ret, 6, 4);
                    $ret = "$acode-$prefix";
                }
            } // If the number is less than 7, return nothing
            return $ret;
        }


        public function getPhone()
        {
            return $this->formatPhone($this->phone);
        }

        public function getCell()
        {
             return $this->formatPhone($this->cell);
        }








// ****** Image Function ****** //

        public function getImageHref()
        {
            $file = $this->rootPath.$this->storeDir.$this->imageDir.$this->image_file;
            if( file_exists($file) )
                return $file;

            else
                return "";
        }

//$storeDir, $thumbDir="", $imgName, $newImagePrefix, $h=150, $w=150

        public function getResizedImage($h=150, $w=150)
        {
            $ret = $this->img->getResizedImage($this->rootPath.$this->storeDir.$this->imageDir, "_thumbs", $this->image_file, $this->id, $h, $w );
            $this->resizeH = $this->img->resizeH;
            $this->resizeW = $this->img->resizeW;
            return $ret;
        }




        public function getPictureCode($resizeH=-1, $resizeW=-1, $extraCode = "")
        {
             $ret="";
             if( $this->image_file != "" )
             {
                 if( $resizeH != -1 || $resizeW != -1 )
                     $src = $this->getResizedImage($resizeH, $resizeW);
                 else
                     $src = $this->getImageHref();

                 $ret = "<img class=\"staffImage\" src=\"$src\" $extraCode/>";
              }
                     
             return $ret;
        }



}












class bseContactPage extends bseCollection
{

      protected $rootPath,
                $storeDir,
                $imageDir;


        public function __construct($rootPath="./")
        {
            parent::__construct($rootPath);
            parent::setTableName($GLOBALS['conTbl']);
            $this->rootPath = $rootPath.(substr($rootPath, -1)=="/"?"":"/");
            $this->storeDir = "modules/bseContactUs/";

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->imageDir = $imageDir.(substr($imageDir, -1)=="/"?"":"/");

        }




        public function setPageId($pageid)
        {
            $id = $this->getEscapedString($pageid);
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id`='$id'");
            $this->setDataFromArray($data);
            
            $res = $this->getQueryResult("SELECT * FROM `{$GLOBALS['consTbl']}`");
            while( $data = mysql_fetch_array($res) )
            {
                $tmp = new bseContact($this->rootPath);
                $tmp->setDataFromArray($data);
                $this->add($tmp);
            }
        }
        
        
        
        
        
        public function insertNewPage()
        {
            $this->getQueryResult("INSERT INTO `{$this->table}` SET `id` = null");
            $id = $this->getInsertId();
            $this->setPageId($id);
            
            return $id;
        }



        public function resetRoot($newPathToRootDir)
        {
            $this->rootPath = $newPathToRootDir.(substr($newPathToRootDir, -1)=="/"?"":"/");
            foreach( $this->ary as $item )
                $item->resetRoot($newPathToRootDir);
        }



        public function getCaptchaTemplateHref()
        {
            return "captcha.tpl";
        }



        public function getCaptchaIncludeHref()
        {
             return $this->rootPath.$this->storeDir."includes/math_captcha.php";
        }



        public function getWarrantyTemplate()
        {
            return "warrantyForm.tpl";
        }



        public function getContactTemplate()
        {
            return "contactForm.tpl";
        }



        public function getFormSubmitHref()
        {
             return $this->rootPath.$this->storeDir."contact-send.php";
        }


        public function getStyleLink()
        {
            return "<link href=\"{$this->rootPath}css/bseContactUs.css\" rel=\"stylesheet\" type=\"text/css\">";
        }



        public function getFormCheckJs()
        {
            return "<script type=\"text/javascript\" src=\"{$this->rootPath}modules/includes/js/formCheck.js\"></script>";
        }


        public function getStaffTemplateHref()
        {
            return "staffList.tpl";
        }



        public function getContactsAdminTemplateHref()
        {
            return "contactsAdmin.tpl";
        }



        public function getSaveFormSubmitHref()
        {
            return $this->rootPath.$this->storeDir."saveContactInfo.php";
        }


        public function getSelectOptionsList($selectedid)
        {
            $ret = "";
            foreach($this->ary as $item)
            {
                if( trim($item->name) != "" )
                    $ret .= "<option value=\"{$item->id}\"". ($item->id==$selectedid ? " selected=\"selected\"" : "" ).">{$item->name}</option>\n";
            }
            return $ret;
        }

}
?>