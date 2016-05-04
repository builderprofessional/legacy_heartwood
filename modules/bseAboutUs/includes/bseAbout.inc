<?php

    class bseAbout extends dbData
    {
        public  $storeDir,
                $imageDir;


        public function __construct($dbConnection, $dataArray, $pathToModuleRoot)
        {
            if( !empty($dataArray) )
            {
                foreach( $dataArray as $key => $value )
                {
                    $this->set($key, $value);
                }
            }

            $this->storeDir = $pathToModuleRoot.(substr($pathToModuleRoot, strlen($pathToModuleRoot), -1)=="/"?"":"/");;
            include("{$this->storeDir}includes/config.inc");

            $this->imageDir = $imageDir.(substr($imageDir, strlen($imageDir), -1)=="/"?"":"/");
            parent::__construct($dbConnection, $dataArray['id'], "bseAbout");

        }



        public function delete()
        {
            $this->setValue("active", "0");
        }



	public function getContent($type, $name)
	{
		
	}


	public function addContent($type, $name, $top, $left, $height, $width)
	{

	}


    }
?>