<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;


    if( !$bse->user->loggedIn )
    {
        header("Location: $rootPath");
        exit();
    }


    

    $products =& $bse->getModule("bseProducts");
    $products->setAllItems();
    $prodid = $_REQUEST['prodid'];


    
    // Add or Update Product
    if( isset($_POST['productEditSubmit']) )
    {
        if(  $_POST['prodid'] == "new" || trim($_POST['prodid']) == ""  )
        {
            $prodid = $products->insertNew();
            $product = $bse->getModule("bseProduct");
            $product->setItemId($prodid);
            $products->add($product);
        }
        
        
        $product =& $products->getItemById($prodid);
        $product->undirty();
//        $product->page_id = $_POST['pageid'];
//        $product->user_id = $_POST['userid'];
        $product->category_id = $_POST['category_id'];
        $product->categoryName = $_POST['categoryName'];
        $product->contact_id = $_POST['contact_id'];
        $product->name = $_POST['name'];
        $product->description = $_POST['description'];
        $product->pitch_blurb = $_POST['blurb'];
        $product->price = $_POST['price'];
        $product->image_file = $_POST['image_file'];
        $product->pdf_file = $_POST['pdf_file'];
        $product->stock = $_POST['stock'];
        $product->status = $_POST['status'];
        $product->featured = ( isset($_POST['featured']) ? $_POST['featured'] : 0 );
        $product->active = ( isset($_POST['active']) ? $_POST['active'] : 0 );
        $product->commit();
    }
    
    
    
    // Delete Product
    if( isset($_REQUEST['delid']) )
    {
        $products->deleteItem($_REQUEST['delid']);
        $products->remove($_REQUEST['delid']);
        $page = $bse->removeArgFromURL("prodid", $page);
        header("Location: $rootPath{$page}");
        exit();
    }
    
    
    
    // Add photo gallery to product
    if( isset($_POST['productAddGallery']) )
    {
        $product =& $products->getItemById($_POST['prodid']);
        $gallery =& $bse->getModule("bsePhotoGallery");
        $galid = $gallery->insertNew();
        $gallery->setGalleryId($galid);
        $product->gallery_id = $galid;
        $product->commit();
    }
    
    
    
    
    // Add or Update Product Feature
    if( isset($_POST['featureUpdateSubmit']) )
    {
        $product =& $products->getItemById($_POST['prodid']);
        $featureid = $_POST['featureid'];
        if(  $_POST['featureid'] == "new" || trim($_POST['featureid']) == ""  )
        {
            $featureid = $product->features->insertNew();
            $feature = $bse->getModule("bseProductFeature");
            $feature->setItemId($featureid);
            $product->features->add($feature);
        }

        $feature =& $product->features->getItemById($featureid);
        $feature->undirty();
        $feature->prodid = $_POST['prodid'];
        $feature->text = $_POST['text'];
        $feature->featured = $_POST['featured'];
        $feature->commit();
    }
    
  
  
    // Delete Feature
    if( isset($_REQUEST['featureDelId']) )
    {
        $product =& $products->getItemById($_REQUEST['prodid']);
        $product->features->deleteItem($_REQUEST['featureDelId']);
        $product->features->remove($_REQUEST['featureDelId']);
    }
    

    
    $pid = urlencode($_REQUEST['prodid']);
    $page = $bse->removeArgFromURL("prodid", $page)."&prodid=$pid";
    header("Location: $rootPath{$page}");
?>