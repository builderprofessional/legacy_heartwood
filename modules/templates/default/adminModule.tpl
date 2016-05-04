<?php

    switch( strtolower($this->adminModule) )
    {
        case "users":
            $this->users = $this->getModule("bseUsers");
            $this->users->setAllUsersData();
            $this->code = $this->fetch($this->user->getUserManagementTemplateHref());
            break;
            



        case "account";
            $this->users = $this->getModule("bseUsers");
            $this->users->setAllUsersData();
            $this->code = $this->fetch($this->user->getUserAccountManagementTemplateHref());
            break;




        case "contacts":
            $this->contactsInfo = $this->getModule("bseContactPage");
            $this->contactsInfo->setPageId(1);
            $this->code = $this->fetch($this->contactsInfo->getContactsAdminTemplateHref() );
            break;




        case "slider":
            include($this->rootDir."modules/bseImageSlider/sliderInc.php");
            $sid = NULL;
            if( isset($_GET['sid']) )
                $_SESSION['slider_edit_id'] = $_GET['sid'];
            if( isset($_SESSION['slider_edit_id']) && trim($_SESSION['slider_edit_id']) != "new" )
                $sid = $_SESSION['slider_edit_id'];
            $this->slider = createSliderObject($this->rootDir, $sid);
            $this->code = $this->fetch($this->slider->getAdminTemplateHref());
            break;
            



        case "homes":
            $this->homesInfo = new bseAvailableHomes($this->rootDir);
            $this->homesInfo->setAllHomes();



            if( isset($_REQUEST['homeid']) && @trim($_REQUEST['homeid']) != "" && @trim( $_REQUEST['homeid']) != "new" )
            {
                $this->selHome = $this->homesInfo->getItemById($_REQUEST['homeid']);
                $_REQUEST['userid'] = $this->selHome->user_id;
            }
            else
            {
                $this->selHome = new bseAvailableHome($this->rootDir);
                $this->selHome->id = "new";
                $this->selHome->gallery_id = $this->selHome->community_id = $this->selHome->contact_id = 0;
                $this->selHome->addr = $this->selHome->city = $this->selHome->state = $this->selHome->zip = $this->selHome->price = $this->selHome->beds = $this->selHome->baths = $this->selHome->partbaths = $this->selHome->floors = $this->selHome->garage = $this->selHome->sqft = $this->selHome->lotsize = $this->selHome->acres = $this->selHome->yr_built = $this->selHome->mls = $this->selHome->fp_pdf = $this->selHome->fp_jpg = $this->selHome->description = $this->selHome->status = "";
            }



            
            if( $this->moduleInstalled("bseContactPage") )
            {
                $this->contacts = $this->getModule("bseContactPage");
                if( !isset($this->contacts->id) || trim($this->contacts->id) == "" )
                    $this->contacts->setPageId(1);
            }
            
            
            
            
            if( $this->moduleInstalled("bseCommunitiesCollection") )
            {
                $this->communities = $this->getModule("bseCommunitiesCollection");
                if( $this->communities->mapid != -1 )
                    $this->communities->setAllCommunitiesList();
            }
            

            $this->code = $this->fetch( $this->homesInfo->getAdminTemplateHref() );
            break;
            
            
            
        case "brochure":
            // Retrieve a brochure object if a brochureid is passed
            require_once($this->rootDir."classes/st_virtualBrochures.inc");
            if( isset($_REQUEST['brochureid']) && @trim( $_REQUEST['brochureid'] ) != "" && @trim( $_REQUEST['brochureid'] ) != "new" )
            {
                $this->brochure = new st_virtualBrochure($this->rootDir);
                $this->brochure->setItemId($_REQUEST['brochureid']);
            }
            else
            {
                $this->brochure = new st_virtualBrochure($this->rootDir);
                $this->brochure->id = "new";
            }



            if( !$this->user->isType("programmers") && !$this->user->isType("admin") )
            {
                $_REQUEST['userid'] = $this->user->id;
            }

            $this->code = $this->fetch( $this->brochure->getAdminTemplateHref() );
            break;
            
            

        case "callnow":
            if( !$this->user->isType("programmers") && !$this->user->isType("admin") )
            {
                $this->builder = $this->user;
            }
            else if( isset($_REQUEST['userid']) && @trim($_REQUEST['userid']) > 0 )
            {
                $this->builder = new bseUser($this->rootDir);
                $this->builder->setItemId($_REQUEST['userid']);
            }

            $this->code = $this->fetch( "callNowAdmin.tpl" );
            break;



        case "events":
            require($this->rootDir . "classes/st_calendar.inc");


            $evid = -1;
            if( isset( $_REQUEST['evid'] ) && @trim( $_REQUEST['evid'] ) != "new" && @trim( $_REQUEST['evid'] ) > 0 )
            {
                $evid = $_REQUEST['evid'];
            }

            $query = $this->db->getQueryResult("SELECT * FROM `st_events` ORDER BY `date` ASC");
            $this->events = new bseCollection($this->rootDir);
            while( $data = mysql_fetch_assoc($query) )
            {
                $ev = new calendarEvent($this->rootDir);
                $ev->setDataFromArray($data);
                $this->events->add($ev);
                if( $ev->id == $evid )
                    $this->event = $ev;
                
                unset($ev);
            }
            
            
            
            if( $evid == -1 )
            {
                $this->event = new calendarEvent($this->rootDir);
                $this->event->id = "new";
                $this->event->name = "";
                $this->event->description = "";
                $this->event->url = "";
                $this->event->date = "0000-00-00";
                $this->event->time = "";
            }
            
            
            $this->code = $this->fetch("eventsAdmin.tpl");
            break;
            
            
            
        case "buildprocess":
            $this->buildProcessItems = $this->getModule("bseBuildProcessItems");
            $this->buildProcessItems->setAllData();

            $this->code = $this->fetch("processAdmin.tpl");
            break;
            
            
            
        case "testimony":
            $this->testimonials = $this->getModule("bseTestimonialItems");
            $this->testimonials->setAllData();
            
            $this->code = $this->fetch($this->testimonials->getAdminTemplateHref());
            break;
            
        
        
        case "sitemap":
            $this->sitemap = $this->getModule("bseSitemap");
            $this->sitemap->setAllData();

            $this->code = $this->fetch($this->sitemap->getAdminTemplateHref());
            break;




        case "dynamicflash":
            $this->dynFlash = $this->getModule("bseDynamicFlash");
            $this->dynFlash->setId(1);
            $this->code = $this->fetch("dynamicFlash_admin.tpl");
            break;
            
            
            
        case "products":
        	$this->products = $this->getModule("bseProducts");
        	$this->products->setAllItems();
        	
            if( isset($_REQUEST['prodid']) && @trim($_REQUEST['prodid']) != "" && @trim( $_REQUEST['prodid']) != "new" )
            {
                $this->tmpProduct = $this->products->getItemById($_REQUEST['prodid']);
//                $_REQUEST['userid'] = $this->tmpProduct->user_id;
            }
            else
            {
                $this->tmpProduct = new bseProduct($this->rootDir);
                $this->tmpProduct->id = "new";
                $this->tmpProduct->gallery_id = $this->tmpProduct->category_id = $this->tmpProduct->contact_id = 0;
                $this->tmpProduct->price = $this->tmpProduct->description = $this->tmpProduct->status = "";
            }
        	
        	
            if( $this->moduleInstalled("bseContactPage") )
            {
                $this->contacts = $this->getModule("bseContactPage");
                if( !isset($this->contacts->id) || trim($this->contacts->id) == "" )
                    $this->contacts->setPageId(1);
            }
            

        	$this->code = $this->fetch($this->products->getAdminTemplateHref());
        	break;
            
            
        
        case "jsslideshow":
        	$this->slideshow = $this->getModule("bseSlideshow");
        	$this->slideshow->setId(1);
            $this->code = $this->fetch("dynamicSlideshow_admin.tpl");
        	break;
        	
        	
        	
        	
        case "process":
        	$this->buildProcessItems = $this->getModule("bseBuildProcessItems");
        	$this->buildProcessItems->setAllData();
        	$this->code = $this->fetch($this->buildProcessItems->getAdminTemplateHref());
        	break;


    }



// Display the code just retrieved
    echo $this->code;
?>
