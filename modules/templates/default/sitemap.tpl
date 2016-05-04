<?php

    $this->display("header.tpl");


// Page Heading
    if( !isset( $this->pageTitle ) )
        echo "<h1>Sitemap</h1>";
    else
        echo "<h1>{$this->pageTitle}</h1>";


// Content
    echo '
    <div id="content">
        <ul id="site_map">
';



// Site map object output

    foreach( $this->sitemap as $sitemapItem )
    {

        echo "
            <li><a href=\"{$sitemapItem->url}\" title=\"{$sitemapItem->title}\">{$sitemapItem->title}</a> - {$sitemapItem->description}</li>
";
    }


    echo '
        </ul>
    </div>
';


    $this->display("footer.tpl");
?>