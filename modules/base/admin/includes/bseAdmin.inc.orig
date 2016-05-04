<?php

class bseAdmin extends bseModule
{

        public  $editHeight,
                $editWidth,
                $useEditor;

        private $dbCon;

        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/base/admin/");
            
            $this->editHeight=500;
            $this->editWidth=700;
            $this->useEditor=true;
        }



        public function resetRoot($newPathToRootDir)
        {
            $this->rootPath = $newPathToRootDir.(substr($newPathToRootDir, -1)=="/"?"":"/");
        }



        public function getTinyMceHref()
        {
            return $this->rootPath.$this->storeDir."includes/tinymce/jscripts/tiny_mce/tiny_mce_dev.js";
        }


        public function getTinyBrowserHref()
        {
             return $this->rootPath.$this->storeDir."includes/tinymce/jscripts/tiny_mce/plugins/tinybrowser/tb_tinymce.js.php";
        }



        public function getLogoutHref()
        {
             return $this->rootPath.$this->storeDir."logout.php";
        }



        public function getToggleFrontBackHref()
        {
             return $this->rootPath.$this->storeDir."frontback.php";
        }



        public function getTinyMceInitCode()
        {
            if( $this->useEditor )
            {
                $code = <<< JAB
    <script type="text/javascript" src="{$this->getTinyMceHref()}"></script>
    <script type="text/javascript" src="{$this->getTinyBrowserHref()}"></script>
    <script language="JavaScript" type="text/JavaScript">

        function resetInfo()
        {
            tinyMCE.activeEditor.setContent(data['code']);
            document.getElementById('pgeTitle').value = data['title'];
            document.getElementById('pgeDesc').value = data['desc'];
            document.getElementById('pgeWords').value = data['words'];
        }

        tinyMCE.init({
            file_browser_callback : "tinyBrowser",
            width:{$this->editWidth},
            height:{$this->editHeight},
            theme : "advanced",
            plugins : "inlinepopups,style,layer,table,advhr,advimage,advlink,iespell,preview,media,searchreplace,contextmenu,paste,noneditable,nonbreaking,xhtmlxtras",
            theme_advanced_buttons1_add_before : "preview,separator",
            theme_advanced_buttons1_add : "separator,forecolor,backcolor",
            theme_advanced_buttons2_add : "separator,advsearchreplace",
            theme_advanced_buttons2_add_before: "cut,copy,paste,pasteword,separator,iespell,separator",
            theme_advanced_buttons3_add_before: "insertlayer,moveforward,movebackward,absolute,|,styleprops,separator,media,separator",
            theme_advanced_buttons3_add : "fontselect,fontsizeselect",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_statusbar_location : "bottom",
            theme_advanced_resizing : true,
            theme_advanced_resizing_use_cookie : false,
            mode : "exact",
            elements : "code",
            content_css : "{$this->rootPath}modules/base/content/includes/default.css",
            body_class : "bodyMCE"
        });
    </script>
JAB;
            }
            else
            {
                 $code = <<< JAB
    <script type="text/javascript">

        function resetInfo()
        {
            document.getElementById('pgeTitle').value = data['title'];
            document.getElementById('pgeDesc').value = data['desc'];
            document.getElementById('pgeWords').value = data['words'];
        }

    </script>

JAB;
            }
            return $code;
        }



        public function getSaveFormActionPage()
        {
             return $this->rootPath.$this->storeDir."savePage.php";
        }


        public function getLoginFormActionPage()
        {
            return $this->rootPath.$this->storeDir."login.php";
        }
}
?>