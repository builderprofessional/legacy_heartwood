<?php


if( !class_exists("bseConnection") )
{
class bseConnection
{
    private $host,
            $db,
            $user,
            $pass,
            $dbCon;
    
    public function __construct($pathToDocRoot="./")
    {
        $ocwd = getcwd();
        $cwd = dirname(__FILE__);
        chdir($cwd);

        if( file_exists("../../config.inc") )
            require("../../config.inc");
            
        else
        {
            throw new Exception("bseConnection::__construct(): Failed to include file 'modules/config.inc' in subclass of ". get_class($this) );
            return false;
        }

        $this->host = $dbHost;
        $this->db = $dbSchema;
        $this->user = $dbUser;
        $this->pass = $dbPass;

        chdir($ocwd);
    }

    public function getConn()
    {
        if( trim( (string)$this->dbCon) == "" || $this->dbCon == 0 )
        {
            $conn = mysql_connect( $this->host, $this->user, $this->pass );
            mysql_select_db($this->db, $conn);
            $this->dbCon = $conn;
        }
        
        return $this->dbCon;
    }
    
    public function getQueryResult($sql, $conn=null)
    {
        if( $conn == null )
            $conn = $this->getConn();
        
        $ret = @mysql_query($sql, $conn);
        if( $ret == false )
            throw new Exception("bseConnection::getQueryResult(): Error #".mysql_errno($conn).": ".mysql_error($conn));
        return $ret;
    }
    
    public function getQueryData($sql, $conn=null)
    {
        if( $conn == null )
            $conn = $this->getConn();

        return @mysql_fetch_assoc($this->getQueryResult($sql, $conn));
    }


    public function getEscapedString($string, $conn=null)
    {
        if( $conn == null )
            $conn = $this->getConn();
        
        return mysql_real_escape_string($string, $conn);
    }

    public function getInsertId()
    {
        if( !mysql_ping($this->dbCon) )
            throw( new Exception("Cannot Retrieve Insert Id when the Database Connection is not set") );

        else
            return mysql_insert_id($this->dbCon);
    }


    protected function checkCon($class, $function, $line)
    {
        // We must have a connection to the database, if not, throw an error
        if( !mysql_ping($this->dbCon) )
        {
            throw new Exception("$class::$function(): Invalid Mysql Connection on line $line");
            return false;
        }
        return true;
    }


}

}
    



    
class dbData extends bseConnection
{
    private $values;

  protected $id,
            $table,
            $dirty,
            $dirtyValues;


    public function __construct($pathToDocRoot = "./", $itemID=null, $dbTableName=null)
    {
        $this->values = array();
        $this->dirtyValues = array();
        $this->dirty = false;

//            if( isset($dbCon) ){$this->dbCon=$dbCon;}
        if( isset($itemID) ){$this->id=$itemID;}
        if( isset($dbTableName) ){$this->table=$dbTableName;}
        
        try
        {
            parent::__construct($pathToDocRoot);
        }
        catch(Exception $e)
        {
            throw new Exception("dbData::__construct(): Failed to create bseConnection object in subclass of ". get_class($this) );
        }

    }
        
        
    public function __get($name)
    {
        if( array_key_exists($name, $this->values) )
            return $this->values[$name];
        else
            return @$this->$name;
    }
        

    public function __set($property, $value)
    {
        if( @$this->values[$property] != $value )
        {
            $this->values[$property] = $value;
            $this->dirtyValues[$property] = $value;
            $this->dirty = true;
        }
    }



    public function commit()
    {
        if( count( $this->dirtyValues ) > 0 )
        {
            $sql = "UPDATE `{$this->table}` SET ";
            foreach( $this->dirtyValues as $name => $value )
            {
                $value = $this->getEscapedString($value);
                $sql .= "`$name`='$value',";
            }
            
            $sql = substr($sql, 0, strlen($sql) - 1);    // Remove the last comma
            $sql .= " WHERE `id` = '{$this->id}'";
            $ret = $this->getQueryResult($sql);
            if( $ret !== false )
                $this->undirty();
            else
                die("SQL = '$sql'<br />Mysql Error: ". mysql_error());
            return $ret;
        }
        return true;
    }



    public function undirty()
    {
        $this->dirtyValues = array();
        $this->dirty = false;
    }


    
    
    public function setDataFromArray($dataArray)
    {
        if( !empty($dataArray) )
        {
            foreach( $dataArray as $key => $value )
            {
                $this->$key = $value;
            }
        }
        $this->dirty = false;
    }



        
        
    public function setTableName($table)
    {
        $this->table = $table;
    }


    public function setItemId($id)
    {
        $this->id = $id;
    }




    public function delete()
    {
        return $this->getQueryResult("DELETE FROM `{$this->table}` WHERE `id` = '{$this->id}' LIMIT 1");
    }


    public function insertNew()
    {
        $this->getQueryResult("INSERT INTO `{$this->table}` SET `id`=NULL");
        return $this->getInsertId();
    }



    public function refresh()
    {
        $res = mysql_query("SELECT * FROM `{$this->table}` WHERE `id`='{$this->id}'");
        $data = mysql_fetch_array($res);
        foreach( $data as $key=>$value )
        {
            $this->values[$key]=$value;
        }
    }
    
    
    
    public function getFormatedValue($field, $niceName="", $valueWrap = "%s", $element = "div", $extraStyle = "")
    {
        if( @trim($this->values[$field]) == "" )
            return "";
                
        $value = sprintf( $valueWrap, $this->values[$field] );
        $ret  = "<$element class=\"modValueLine\" style=\"$extraStyle \"><$element class=\"modValueLabel\">";
        $ret .= ( trim($niceName) != "" ? $niceName : $field );
        $ret .= ":</$element><$element class=\"modValueData\">$value</$element></$element>";
            
        return $ret;
    }


    
    


    public function getTable()
    {
        return $this->table;
    }
    
    
/*    
    protected function reset()
    {
        $this->values = array();
    }
This may be an unnecessary function
*/
}








class bseImageManipulator
{

    private $resizeW,
            $resizeH;


    public function __get($prop)
    {
        return $this->$prop;
    }


    public function getResizedImage($storeDir, $thumbDir="", $imgName, $newImagePrefix, &$h=150, &$w=150)
    {
        $maxW = $w;
        $maxH = $h;
        $path = $storeDir;
        $thumbDir = $thumbDir . ( substr($thumbDir, -1)== "/" ? "" : "/" );
        $fullFile = $path.$imgName;

        if(!file_exists($fullFile) && trim($imgName) != "" )
        {
            return "";
        }

        // Get new dimensions
        list($width_orig, $height_orig) = getimagesize($fullFile);

        $ratio_orig = $width_orig/$height_orig;


        if( $maxH != -1 )
            $nwidth=round($maxH*$ratio_orig);
        else
        {
            $nwidth=$maxW;
            $nheight = round($maxW/$ratio_orig);
            $maxH = $nheight + 1;
            $maxW = $nwidth + 1;
        }

        if( $maxW != -1 )
            $nheight=round($maxW/$ratio_orig);
        else
        {
            $nheight=$maxH;
            $nwidth = round($maxH*$ratio_orig);
            $maxH = $nheight + 1;
            $maxW = $nwidth + 1;
        }



        if( $nwidth>=$maxW )
        {
            $width=$maxW;
            $height=$nheight;
        }
        else if( $nheight>$maxH )
        {
            $height=$maxH;
            $width=$nwidth; 
        }
        else
        {
            $width = $nwidth;
            $height= $nheight;
        }

        $this->resizeW = $w = $width;
        $this->resizeH = $h = $height;

        // Check for cached image
        $outFile = $path.$thumbDir.$imgName.$newImagePrefix."_{$width}x{$height}.jpg";

        if( !file_exists($outFile) )
        {
            // Resample
            $image_p = imagecreatetruecolor($width, $height);


            $info = getimagesize($fullFile);
            switch ( $info[2] ) 
            {
                case IMAGETYPE_GIF:
                    $image = imagecreatefromgif($fullFile);
                    break;
                case IMAGETYPE_JPEG:
                    $image = imagecreatefromjpeg($fullFile);
                    break;
                case IMAGETYPE_PNG:
                    $image = imagecreatefrompng($fullFile);
                    break;
                default:
                    return false;
            }

            if ( ($info[2] == IMAGETYPE_GIF) || ($info[2] == IMAGETYPE_PNG) ) 
            {
                $trnprt_indx = imagecolortransparent($image);
   
                // If we have a specific transparent color
                if ($trnprt_indx >= 0) 
                {
   
                    // Get the original image's transparent color's RGB values
                    $trnprt_color    = imagecolorsforindex($image, $trnprt_indx);
   
                    // Allocate the same color in the new image resource
                    $trnprt_indx    = imagecolorallocate($image_p, $trnprt_color['red'], $trnprt_color['green'], $trnprt_color['blue']);
   
                    // Completely fill the background of the new image with allocated color.
                    imagefill($image_p, 0, 0, $trnprt_indx);
   
                    // Set the background color for new image to transparent
                    imagecolortransparent($image_p, $trnprt_indx);
                }


                // Always make a transparent background color for PNGs that don't have one allocated already
                elseif ($info[2] == IMAGETYPE_PNG) 
                {
   
                    // Turn off transparency blending (temporarily)
                    imagealphablending($image_p, false);
       
                    // Create a new transparent color for image
                    $color = imagecolorallocatealpha($image_p, 0, 0, 0, 127);
    
                    // Completely fill the background of the new image with allocated color.
                    imagefill($image_p, 0, 0, $color);
   
                    // Restore transparency blending
                    imagesavealpha($image_p, true);
                }
            }

            imagecopyresampled($image_p, $image, 0, 0, 0, 0, $width, $height, $width_orig, $height_orig);


            // Output
            switch ( $info[2] ) 
            {
                case IMAGETYPE_GIF:
                    imagegif($image_p, $outFile);
                    break;

                case IMAGETYPE_JPEG:
                    imagejpeg($image_p, $outFile, 100);
                    break;

                case IMAGETYPE_PNG:
                    imagepng($image_p, $outFile);
                    break;

                default:
                    return false;
            }

            imagedestroy($image_p);
            imagedestroy($image);
        }
        return $outFile;
    }

}






// ***** Iteration functions ********* //
class bseIterator extends dbData implements Iterator
{

    protected $ary = array();

    public function __construct($pathToDocRoot)
    {
        parent::__construct($pathToDocRoot);
    }


    public function rewind() 
    {
        reset($this->ary);
    }

    public function current() 
    {
        $var = current($this->ary);
        return $var;
    }

    public function key() 
    {
        $var = key($this->ary);
        return $var;
    }

    public function next() 
    {
        $var = next($this->ary);
        return $var;
    }

    public function valid() 
    {
        $var = $this->current() !== false;
        return $var;
    }
        
    public function count()
    {
        return count($this->ary);
    }
}





// ********** Collection Management Functions **************
class bseCollection extends bseIterator
{


    public function sortArray($sortValue, $direction=1)
    {
        $valAdded = false;
        $retAry = array();
        foreach( $this->ary as $value )
        {
            if( count($retAry) == 0 )
            {
                array_push($retAry, $value);
                continue;
            }
            for( $i=0; $i<count($retAry); $i++ )
            {
                $insert = false;
                if( $direction > 0 )     // Ascending order
                {
                    if( $value->$sortValue < $retAry[$i]->$sortValue )
                    {
                        $insert = true;
                    }
                }
                else                     // Descending order
                {
                    if( $value->$sortValue > $retAry[$i]->$sortValue )
                    {
                        $insert = true;
                    }
                }

                if( $insert )
                {
                    for( $j=count($retAry)-1; $j>=$i; $j-- )
                    {
                        $retAry[$j+1]=$retAry[$j];
                    }
                    $retAry[$i] = $value;
                    $valAdded = true;
                    break;
                }
            }
            if( !$valAdded )
                array_push($retAry, $value);
            else
                $valAdded = false;
        }
        $this->ary = array();
        foreach($retAry as $item)
            $this->add($item);

        return $this->ary;
    }


    
    public function randomize()
    {
        $newAry = array();
        $indicies = array();
        $data = $this->ary;
        
        foreach( $this->ary as $item )
            $indicies[] = $item->id;
            
        while( count($indicies) > 0 )
        {
            $index = mt_rand( 0, count($indicies)-1 );
//            echo "Index = '$index'<br />";
            $newAry[$indicies[$index]] = $data[$indicies[$index]];
            unset($indicies[$index]);
            sort($indicies);
        }
/*
        echo "<pre>";
        var_dump($this->ary);
        var_dump($newAry);
        echo "</pre>";
        die();
*/
        $this->ary =& $newAry;
    }
    
    
    


    public function __construct($pathToDocRoot = "./")
    {
        parent::__construct($pathToDocRoot);
    }





    public function add(&$item)
    {
        if( isset($item->id) )
            $this->ary[$item->id] = $item;
    }
    
    
    
    
    public function remove($id)
    {
        unset($this->ary[$id]);
    }





        
    public function refreshInfo()
    {
        foreach( $this->ary as $theItem )
            $theItem->refresh();
    }

    public function deleteItem($id)
    {
        if( isset($id) )
        {
            @$this->ary[$id]->delete();
            unset($this->ary[$id]);
        }
    }

    public function &getItemById($id)
    {
        return $this->ary[$id];
    }


    public function getOrdinalArrayItem($pos)
    {
        $key = $this->keyAtArrayPos($this->ary, $pos);
            
        if( $key !== false )
            return $this->ary[$key];
                
        else
            return null;
    }

    
    
    
    
    
    protected function keyAtArrayPos($ary, $pos)
    {
        reset($ary);
    
        if ( ($pos < 0) || ( $pos >= count($ary) ) )
            return false;  // set this any way you like

        reset($ary);
        for($i = 0;$i < $pos; $i++) next($ary);

        return key($ary);
    }


}
?>