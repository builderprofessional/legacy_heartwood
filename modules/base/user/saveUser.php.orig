<?php


    $rootPath = "../../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    if( !$bse->user->loggedIn )
    {
        header("Location: $rootPath");
        exit();
    }

    $users =& $bse->getModule("bseUsers");
    $users->setAllUsersData();

    

    if( isset($_POST['siteUsersSubmit']) )
    {
/*    echo "<pre";
    var_dump($_POST);
    echo "</pre>";
//    die();
*/

        $userid = $_POST['userid'];
        
        if( strtolower($userid) == "new" )
        {
            $userid = $users->insertNewUser();
            $user = new bseUser($bse->rootDir);
            $user->setUserId($userid);
            $users->add($user);
        }
        
        $user =& $users->getItemById($userid);
        $user->undirty();
        $user->firstName = $_POST['fname'];
        $user->lastName  = $_POST['lname'];
        $user->uName     = $_POST['uname'];
        $user->active    = 1;
        if( trim($_POST['pword1']) != "" )
            $user->changePassword($_POST['pword1']);



            $user->typeId = 2;



        $user->commit();
        
        header("Location: {$rootPath}$page");
        exit();
    }
    
    
    
    
    if( isset($_POST['userDataSubmit']) )
    {
        $userid = $_POST['userid'];
        $userDataId = $_POST['userDataId'];
        
        $user =& $users->getItemById($userid);

        if( strtolower($userDataId) == "new" )
        {
            $userDataId = $user->userData->insertNew();
            $user->userData->setUserDataId($userDataId);
        }
        
        $userData =& $user->userData;
        $userData->undirty();
        $userData->userid = $userid;
        $userData->name = $_POST['name'];
        $userData->address1 = $_POST['address1'];
        $userData->address2 = $_POST['address2'];
        $userData->city = $_POST['city'];
        $userData->state = $_POST['state'];
        $userData->zip = $_POST['zip'];
        $userData->email = $_POST['email'];
        $userData->phone = $_POST['phone'];
        $userData->cell = $_POST['cell'];
        $userData->fax = $_POST['fax'];
        $userData->website = $_POST['website'];
        $userData->community = $_POST['community'];
        $userData->useVideo = ( isset( $_POST['useVideo'] ) ? $_POST['useVideo'] : 0 );
        $userData->useBrochure = ( isset( $_POST['useBrochure'] ) ? $_POST['useBrochure'] : 0 );
        $userData->commit();
        
        
        if( $bse->user->id == $userid )
            $bse->user->userData =& $userData;

        header("Location: {$rootPath}$page");
        exit();
    }




    if( isset($_POST['actvid']) )
    {
        $user =& $users->getItemById($_POST['actvid']);
        $user->active = 1;
        $user->commit();
        header("Location: {$rootPath}$page");
        exit();
    }




    if( isset($_POST['deacid']) )
    {
        $user =& $users->getItemById($_POST['deacid']);
        $user->active = 0;
        $user->commit();
        header("Location: {$rootPath}$page");
        exit();
    }




    if( isset($_POST['delid']) )
    {
        $users->deleteItem($_POST['delid']);
        header("Location: {$rootPath}$page");      //{$bse->pageName}?module=users");
        exit();
    }

?>