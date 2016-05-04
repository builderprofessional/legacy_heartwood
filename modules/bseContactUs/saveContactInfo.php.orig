<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    if( isset($_POST['contactSubmit']) )
    {
        $contact = new bseContact($rootPath);
        if( @trim($_POST['conId']) != "-1" && @trim( $_POST['conId'] ) != "new" )
        {
            $contact->setContactId($_POST['conId']);
        }
        else
        {
            $contact->insertNewContact();
        }

        $contact->undirty();
        $contact->name = $_POST['name'];
        $contact->title = $_POST['title'];
        $contact->department = $_POST['department'];
        $contact->description = $_POST['description'];
        $contact->phone = $_POST['phone'];
        $contact->cell = $_POST['cell'];
        $contact->email = $_POST['email'];
        $contact->image_file = $_POST['image'];
        $contact->commit();
        $conPage =& $bse->getModule("bseContactPage");
        $conPage->add($contact);
    }

    if( isset($_POST['contactOptsSubmit']) )
    {

        $conPage =& $bse->getModule("bseContactPage");
        if( trim($_POST['pageId']) != "" )
        {
            $conPage->setPageId($_POST['pageId']);
        }
        else
        {
            $conPage->insertNewPage();
        }

        $conPage->undirty();
        $conPage->company = $_POST['company'];
        $conPage->address1 = $_POST['address1'];
        $conPage->address2 = $_POST['address2'];
        $conPage->city = $_POST['city'];
        $conPage->state = $_POST['state'];
        $conPage->zip = $_POST['zip'];
        $conPage->phone = $_POST['phone'];
        $conPage->fax = $_POST['fax'];
        $conPage->email = $_POST['email'];
        $conPage->useContactForm = ( isset($_POST['useContactForm'])? $_POST['useContactForm'] : "0" );
        $conPage->useWarrantyForm = ( isset($_POST['useWarrantyForm'])? $_POST['useWarrantyForm'] : "0" );
        $conPage->useContactsList = ( isset($_POST['useContactsList'])? $_POST['useContactsList'] : "0" );
        $conPage->commit();
    }

    if( isset($_GET['delid']) )
    {
        $conPage = $bse->getModule("bseContactPage");
        $conPage->deleteItem($_REQUEST['delid']);
    }

    header("Location: $rootPath" . $bse->removeArgFromURL("contactid", $page) );
?>