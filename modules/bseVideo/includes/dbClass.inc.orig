<?php
    if( !isset($GLOBALS['dbData_inc']) )
    {
        class dbData
        {
            private $values = Array();
            private $id,
                    $table,
                    $dbCon;
            
            public function __construct($dbCon, $itemID, $dbTableName)
            {
                $this->dbCon=$dbCon;
                $this->id=$itemID;
                $this->table=$dbTableName;
            }
            
            
            public function __get($name)
            {
                return $this->values[$name];
            }
            
            
            public function setValue($property, $value)
            {
                if( !isset($this->id) )
                    return false;

                else
                {
                    $this->values[$property] = $value;
                    $property = mysql_real_escape_string($property, $this->dbCon);
                    $value = mysql_real_escape_string($value, $this->dbCon);
                    return mysql_query("UPDATE `{$this->table}` SET `$property` = '$value' WHERE `id` = '{$this->id}'", $this->dbCon);
                }
            }
            
            
            public function setDbConn($dbCon)
            {
                $this->dbCon = $dbCon;
            }
            
            
            public function delete()
            {
                return mysql_query("DELETE FROM `{$this->table}` WHERE `id` = '{$this->id}' LIMIT 1;", $this->dbCon);
            }
            
            
            protected function set($name, $value)
            {
                $this->values[$name]=$value;
            }
            
        }
    }
    
    else
    {
        $GLOBALS['dbData_inc'] = true;
    }
?>