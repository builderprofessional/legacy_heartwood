<?php

if( !function_exists("getModulesParentDir") )
{
    include("function.inc");
}

// Get directory under "modules" folder to prepare for inclusion of files

    $orgDir = dirname($_SERVER['SCRIPT_FILENAME']);
    $bseCurDir = dirname(__FILE__);
    chdir($bseCurDir);

    $bseRoot = getModulesParentDir( $bseCurDir );
    $bseRoot .= (substr($bseRoot, -1)=="/"?"":"/");
    

// Include base classes
    require_once($bseRoot."modules/includes/main/savant/Savant3.inc");
    require_once($bseRoot."modules/includes/main/dbClass.inc");
    require_once($bseRoot."modules/base/moduleControl/includes/bseModules.inc");
    



// Include all files
    // base system
    require_once($bseRoot."modules/base/admin/includes/bseAdmin.inc");
    require_once($bseRoot."modules/base/content/includes/bseContent.inc");
    require_once($bseRoot."modules/base/user/includes/bseUser.inc");
    




// Get include files for installed modules
    $modules = new bseModules($bseRoot);

    $installedMods = $modules->getFilteredModules("module_installed", 1);
    foreach( $installedMods as $module )
    {
        $file = $module->getIncludeFile();
//        echo "module = '$module->module_name'<br />file = '$file'<br />";
        if( file_exists( $file ) )
        {
//            echo "file exists, including file<br />";
            require_once($file);
        }
    }





    
// Return to currently executing script's directory
    chdir($orgDir);

    session_start();
    $_SESSION['modules'] = $modules;
    $_SESSION['installedModules'] = $installedMods;
    if( !$_SESSION['installedModules']->moduleExists('bseUser') )
    {
        if( !isset($_SESSION['bseUser']) )
        {
            $_SESSION['bseUser'] = new bseUser($rootPath);
            $_SESSION['bseUser']->module_name = "bseUser";
        }
        else
        {
            $_SESSION['bseUser']->resetRoot($rootPath);
        }
        $_SESSION['installedModules']->add($_SESSION['bseUser']);
    }







    
    class bse extends Savant3
    {
    
         public $modules,
                $content,
                $config,
                $admin,
                $user,
                $db;


        private $rootDir,
                $installedMods,
                $curPage;


                
        public function __construct($pathToDocRoot="./", $getContent=true)
        {
            parent::__construct();

            $this->rootDir = $pathToDocRoot.(substr($pathToDocRoot, -1) == "/"?"":"/");
            $this->curPage = $this->getPage();
           @$this->retPage = $_SESSION['retPage'];
           @$this->pageRoot = $_SESSION['bsePageRoot'];
            $this->installedMods = array();
            $this->config = array();
            
            include("{$pathToDocRoot}modules/config.inc");
            $this->config['templateDir'] = $templateDir;
            $this->config['useStatistics'] = $useStatistics;
            

            $this->addPath("template", $this->rootDir."modules/templates/default/");


            // Set Module Objects from modulesCollection
            $this->modules = $_SESSION['modules'];
            foreach($_SESSION['installedModules'] as $mod)
            {
                $this->installedMods[$mod->module_name] = $_SESSION[$mod->module_name];
            }

            $this->content = new bseContent($this->rootDir);
            if( $getContent )
                $this->content->getContent($this->curPage);
            
            $this->user = $this->getModule('bseUser');
            
            $this->admin = new bseAdmin($this->rootDir);
            
            $this->db = new bseConnection($this->rootDir);
        }

        
        
        public function &__get($property)
        {
/*            if( ! property_exists($this, $property) )
                $this->$property =& $this->getModule($property);
*/            
            return $this->$property;
        }
        
        

        public function &getModule($name)
        {
            $ret = null;
            if( !isset($_SESSION[$name]) )
            {
                $this->installedMods[$name] = new $name($this->rootDir);
                if( isset($this->installedMods[$name]) )
                    $ret = $this->installedMods[$name];
                    
                $_SESSION[$name] =& $this->installedMods[$name];
            }
            else
            {
                $this->installedMods[$name] = $_SESSION[$name];
                $this->installedMods[$name]->resetRoot($this->rootDir);
                $ret =& $this->installedMods[$name];
            }
                
            return $ret;
        }
        
        
        
        
        public function getFileHref($file, $dirFromRoot=null)
        {
            $ret = null;
            if( !isset($dirFromRoot) )
                $dir = $this->rootDir . "modules/includes/";
            else
                $dir = $dirFromRoot . ( substr($dirFromRoot, -1)=="/" ? "" : "/" );
//    echo "Scanning directory '$dir' for file '$file':<br />";


            
            if ($handle = opendir($dir)) 
            { 
                while( false!== ( $curFile = readdir($handle) ) ) 
                {
//    echo " --- Scanning file '$curFile'<br />";
                    if( $curFile == '.' || $curFile == '..' ) continue; 
                    if( is_dir($dir.$curFile) )
                    {
//    echo "'$dir{$curFile}' is a directory, recursing into it<br />";
                        try
                        {
                            $ret = $this->getFileHref($file, $dir.$curFile);
                        }
                        catch(Exception $e)
                        {
                            continue;
                        }
                    }
                    else if( $curFile == $file )
                    {
                        $ret = $dir.$curFile;
                        break;
                    }
                }
                closedir($handle);
            }

            if( $ret == null )
            {
                throw new Exception("bseMain.php, bse::getFileHref(".__LINE__.") File '$file' not found");
            }
            return $ret;
        }



        public function setReturnPage($page = null)
        {
            if( isset($page) )
                $this->retPage = $_SESSION['retPage'] = $page;
            else
                $this->retPage = $_SESSION['retPage'] = $this->curPage;
        }
        
        
        public function setPageRoot()
        {
            $_SESSION['bsePageRoot'] = $this->rootDir;
        }
        
        
        
        
        public function moduleInstalled($modName)
        {
            return class_exists($modName);
        }

        
        
        
        public function removeArgFromURL($arg, $url = null)
        {
            if( is_null($url) )
                $url = $this->retPage;

            $counter = 0;
            $ret = $url;
            while( strpos($ret, $arg) !== false )
            {
                $start = strpos($ret, $arg) - 1;
                $end = strpos($ret, "&", $start + strlen("$arg=") );
                if( $end === false )
                {
                    $str = substr($ret, (strlen($ret) - $start) * -1 );
                }
                else
                {
                    $str = substr($ret, $start, $end - $start);
                }
                
                $ret = str_replace($str, "", $ret);
                
                $counter++;
                if( $counter == 10 )
                    break;
            }
            
            return $ret;
        }
        
        

        
        
//        private function setInstalled

        private function getPage()
        {
            $ScriptFilename = $_SERVER['SCRIPT_FILENAME'];
            $curDir = dirname($ScriptFilename);
            chdir($curDir);
            chdir($this->rootDir);
            $rootPath = realpath(getcwd())."/";
            $file = str_replace($rootPath, "", $ScriptFilename);
            chdir(dirname($ScriptFilename));
            return $file;
        }
    }



?>