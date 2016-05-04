<?php

    $rootPath = "../../";
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);

    $page = $bse->retPage;
    $sitemap = $bse->getModule("bseSitemap");


//  Save sitemap changes

    if( isset( $_POST['sitemapSave'] ) )
    {
        $item =& $sitemap->getItemById($_POST['sm_id']);
        
        
        $item->undirty();
        $item->url = $_POST['sm_url'];
        $item->title = $_POST['sm_title'];
        $item->description = $_POST['sm_desc'];
        $item->commit();
    }
    


//  Add new build process
    
    if( isset( $_POST['sitemapAdd'] ) )
    {
        $newid = $sitemap->insertNew();
        $item =& $sitemap->getItemById($newid);
        
        $item->undirty();
        $item->url = $_POST['sm_url'];
        $item->title = $_POST['sm_title'];
        $item->description = $_POST['sm_desc'];
        $item->commit();
    }
    
    
    
//  Delete Build Process Item

    if( isset( $_REQUEST['delid'] ) )
    {
        $processItems = $bse->getModule("bseSitemap");
        $processItems->deleteItem($_REQUEST['delid']);
    }




    if( isset($_POST['sitemapSorderSubmit']) )
    {
        for( $i = 0; $i < count($_POST['sorder']); $i++ )
        {
//            echo "sorder[$i] = {$_POST['sorder'][$i]}, ";
            $item =& $sitemap->getItemById( $_POST['sorder'][$i] );
            if( $item != null )
            {
                $item->undirty();
                $item->sorder = $i;
                $item->commit();
            }
        }
        $sitemap->sortArray('sorder');
    }




    
    
    header("Location: {$rootPath}$page");
?>