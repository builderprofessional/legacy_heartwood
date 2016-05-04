<?php
    class bseConnection
    {
        private $host,
                $db,
                $user,
                $pass,
                $dbCon;
        
        public function __construct($pathToDocRoot="./")
        {
            $root = $pathToDocRoot . ( substr($pathToDocRoot, -1) == "/" ? "" : "/" );
            include($root."modules/config.inc");

            $this->host = $dbHost;
            $this->db = $dbSchema;
            $this->user = $dbUser;
            $this->pass = $dbPass;
        }

        public function getConn()
        {
            if( trim( (string)$this->dbCon) == "" )
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
            return $ret;
        }
        
        public function getQueryData($sql, $conn=null)
        {
            if( $conn == null )
                $conn = $this->getConn();

            return @mysql_fetch_array($this->getQueryResult($sql, $conn));
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


        private function checkCon($class, $function, $line)
        {
            // We must have a connection to the database, if not, throw an error
            if( !mysql_ping($this->dbCon) )
            {
                throw new Exception("$class::__$function(): Invalid Mysql Connection on line $line");
                return false;
            }
            return true;
        }


    }
?>