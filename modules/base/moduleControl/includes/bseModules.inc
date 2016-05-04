<?php

class bseModule extends dbData
{

    private $rootPath,
            $storeDir,
            $childDbData,
            $fileData;




    public function __construct($pathToDocRoot="./", $pathToModuleRoot=null, $dataArray=null, $childDataArray=null)
    {
        // Set standard variables
        if( isset($pathToModuleRoot) ) { $this->storeDir = $pathToModuleRoot.(substr($pathToModuleRoot, -1)=="/"?"":"/"); }
        $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");


        // If data from the database has been supplied, fill the class' variables
        if( isset($dataArray) )
        {
            try
            {
                parent::__construct($this->rootPath, $dataArray['module_id'], "bseModules");
            }
            catch(Exception $e)
            {
                throw new Exception("bseModule::__construct(): Failed to create dbData object in subclass of ". get_class($this) );
                return false;
            }
            foreach( $dataArray as $key => $value )
            {
                $this->$key = $value;
            }
            
            $this->fileData = new moduleFile($this->rootPath);
            $this->fileData->setFileId($this->file_id);

            // Set variable(s) for child class
            if( isset($childDataArray) )
            {
                foreach( $childDataArray as $key => $value )
                    $this->childDbData->set($key, $value);
    
                $this->childDbData = new dbData($this->rootPath, $childDataArray['id'], $this->db_table_name);
            }
        }
        
        else
        {
            try
            {
                parent::__construct($this->rootPath);
            }
            catch(Exception $e)
            {
                throw new Exception("bseModule::__construct(): Failed to create dbData object in subclass of ". get_class($this) );
                return false;
            }
        }

    }
    
    
    
    public function setItemId($idnum)
    {
        $id = $this->getEscapedString($idnum);
        
        $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$id'");
        $this->setDataFromArray($data);
    }
    
    


    public function __get($property)
    {
        if( isset($this->$property) )
            return $this->$property;
        else if( parent::__get($property) != null )
            return parent::__get($property);
        else if( isset($this->childDbData) )
            return $this->childDbData->$property;
        else
            return null;
    }



    protected function setModuleValue($property, $value)
    {
        $this->setValue($property, $value);
    }



    public function getIncludeFile()
    {
        return $this->rootPath."modules/".$this->fileData->module_directory."/includes/".$this->fileData->file_name;
    }
    


    
    public function resetRoot($newRoot)
    {
        $this->rootPath = $newRoot.(substr($newRoot, -1)=="/"?"":"/");
    }
    
    
    
    public function getMediaDirHref($includeRoot = null, $variableName = null)
    {
    
        if( is_null( $includeRoot ) )
            $includeRoot = true;
            
        if( is_null( $variableName ) )
            $variableName = "imageDir";
    
    
        $ret = "";
        
        if( $includeRoot )
            $ret = $this->rootPath;
        
        $ret .= $this->storeDir;
        if( file_exists($this->rootPath . $this->storeDir . "includes/config.inc") )
        {
            include($this->rootPath . $this->storeDir . "includes/config.inc");
            $ret .= $$variableName;
        }
            
        return $ret;
    }
    
    
}













class bseModules extends bseCollection
{
    private $rootPath;

    public function __construct($pathToDocRoot="./", $getData = true)
    {
        $this->rootPath = $pathToDocRoot . (substr($pathToDocRoot, -1)=="/"?"":"/");
        parent::__construct($this->rootPath);
        if( $getData )
            $this->initData();
    }



    public function initData()
    {
        $query = $this->getQueryResult("SELECT * FROM `bseModules`");
        while( $data = mysql_fetch_assoc($query) )
        {
            $tmp = new bseModule($this->rootPath, "modules/".$data['module_name'], $data);
//            $tmp->setItemId($data['module_id']);
            $this->add( $tmp );
        }
    }



    public function &getFilteredModules($filter, $value)
    {
/*        if( !property_exists('bseModule', $filter) )
        {
            throw new Exception(get_class($this)."::getFilteredModules(): Filter value '$filter' does not exist, on line ".__LINE__);
            return false;
        }
*/
        $ret = new bseModules($this->rootPath, false);
        foreach($this->ary as $module)
        {
            if( $module->$filter == $value )
            {
                $ret->add($module);
            }
        }

        return $ret;
    }

    
    public function moduleExists($mod_name)
    {
        $ret = false;
        foreach($this->ary as $mod)
        {
//        echo "Checking for '$mod_name': module name = '{$mod->module_name}'<br />";
            if( $mod->module_name == $mod_name )
            {
                $ret = true;
                break;
            }
        }
        
        return $ret;
    }   
}





class moduleFile extends dbData
{

    private $rootPath,
            $storeDir,
            $childDbData;




    public function __construct($pathToDocRoot="./")
    {

        // Set standard variables
        if( isset($pathToModuleRoot) ) { $this->storeDir = $pathToModuleRoot.(substr($pathToModuleRoot, -1)=="/"?"":"/"); }
        $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");

        parent::__construct($this->rootPath);

    }





    public function setFileId($fileid)
    {
        $fileid = $this->getEscapedString($fileid);
        
        $data = $this->getQueryData("SELECT * FROM `bseModuleFiles` WHERE `file_id`='{$fileid}'");
        $this->setDataFromArray($data);
    }


}
?>