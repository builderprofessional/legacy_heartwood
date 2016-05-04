<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;

    $community =& $bse->getModule("bseCommunity");
    if( $community->id != $_POST['commid'] )
        $community->setCommunityId($_POST['commid']);



// **************  Update Processing ************** //
    if( isset($_POST['fpUpdateSubmit']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);
        $plan->undirty();
        $plan->name = $_POST['planName'];
        $plan->price = $_POST['planPrice'];
        $plan->size = $_POST['planSize'];
        $plan->completion = $_POST['planComp'];
        $plan->shortDesc = $_POST['planDesc'];
        $plan->photo = $_POST['fpImage'];
        $plan->pdf = $_POST['fpDoc'];
        $plan->commit();
    }


    if( isset($_POST['planImageUpdate']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);
        $img =& $plan->imgs[$_POST['imgid']];

        $id = $bse->db->getEscapedString($_POST['imgid']);
        $imgFile = $bse->db->getEscapedString($_POST['fpImage']);
        $docFile = $bse->db->getEscapedString($_POST['fpDoc']);

        $args = "";
        $cmd = "UPDATE `bseCommFloorplanImages` SET ";
        $where = " WHERE `id`='$id' LIMIT 1";

        if( trim($imgFile) != "" )
            $args = "`imageFile`='$imgFile'";

        if( trim($docFile) != "" )
            $args .= ($args!=""?",":"")."`pdfFile`='$docFile'";

        if( trim($args) != "" )
        {
            $img->imageFile = $_POST['fpImage'];
            $img->pdfFile = $_POST['fpDoc'];
            $query = $bse->db->getQueryResult($cmd.$args.$where);
        }
    }


    if( isset($_POST['planTextUpdate']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);
        $txt =& $plan->texts[$_POST['textid']];
        $txt->label = $_POST['fpTextLabel'];
        $txt->text = $_POST['fpText'];

        $id = $bse->db->getEscapedString($_POST['textid']);
        $txtLabel = $bse->db->getEscapedString($_POST['fpTextLabel']);
        $txtText = $bse->db->getEscapedString($_POST['fpText']);

        $args = "";
        $cmd = "UPDATE `bseCommFloorplanTexts` SET ";
        $where = "`sorder`='100' WHERE `id`='$id' LIMIT 1";

        $args = "`label`='$txtLabel',`text`='$txtText',";

        $query = $bse->db->getQueryResult($cmd.$args.$where);
    }

    if( isset($_POST['planUpdatePriceList']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);

        $plan->size = $_POST['fpSize'];
        $plan->price = $_POST['fpPrice'];
        $plan->completion = $_POST['fpComp'];
    }


    if( isset($_POST['panelImageUpdate']) )
    {
        $cmd = "INSERT INTO `bseCommDetail` ";
        $where = "";

        if( trim($_POST['imgid']) != "" )
        {
            $imgid = $bse->db->getEscapedString($_POST['imgid']);
            $cmd = "UPDATE `bseCommDetail` ";
            $where = "WHERE `id` = '$imgid'";
        }

        $com = $bse->db->getEscapedString($_POST['commid']);
        $panel = $bse->db->getEscapedString($_POST['panel']);
        $imgFile = $bse->db->getEscapedString($_POST['fpImage']);
        $pdfFile = $bse->db->getEscapedString($_POST['fpDoc']);
        $bse->db->getQueryResult("$cmd SET `imageFile`='$imgFile',`pdfFile`='$pdfFile',`comm_id`='$com',`panel`='$panel' $where");
    }






// **************** Addition Processing ************** //


    if( isset($_POST['newFloorplanSubmit']) )
    {
        $plans =& $community->floorPlans;
        $planid = $plans->insertNew();
        $newplan =& $bse->getModule("bseCommunityFloorPlan");
        $newplan->setPlanId($planid);

        if( is_object($newplan) )
        {
            $newplan->undirty();
            $newplan->comm_id = $_POST['commid'];
            $newplan->name = $_POST['fpName'];
            $newplan->price = $_POST['fpPrice'];
            $newplan->size = $_POST['fpSize'];
            $newplan->completion = $_POST['fpComp'];
            $newplan->photo = $_POST['fpImage'];
            $newplan->pdf = $_POST['fpDoc'];
            $newplan->shortDesc = $_POST['shortDesc'];
            $newplan->commit();
            $plans->add($newplan);
        }
        else
        {
            echo "<pre>";
            var_dump($newplan);
            die("</pre>");
        }
    }



    if( isset($_POST['planImageAdd']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);
        $imgFile = $bse->db->getEscapedString($_POST['fpImage']);
        $docFile = $bse->db->getEscapedString($_POST['fpDoc']);

        $query = $bse->db->getQueryResult("INSERT INTO `bseCommFloorplanImages` SET `planid`='{$plan->id}', `imageFile`='$imgFile',`pdfFile`='$docFile',`sorder`='100'");
        $id = $bse->db->getInsertId();
        $plan->addDetailImageToArray($id);
    }



    if( isset($_POST['planTextAdd']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);
        $label = $bse->db->getEscapedString($_POST['fpTextLabel']);
        $text = $bse->db->getEscapedString($_POST['fpText']);

        $query = $bse->db->getQueryResult("INSERT INTO `bseCommFloorplanTexts` SET `planid`='{$plan->id}', `label`='$label',`text`='$text'");
        $id = $bse->db->getInsertId();
        $plan->addDetailTextToArray($id);
    }







// *************** Deletion Processing **************** //


    if( isset($_POST['delFloorPlanSubmit']) )
    {
        $community->floorPlans->deleteItem($_POST['planid']);
    }



    if( isset($_POST['planImageDelete']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);

        $plan->deleteDetailImageFromArray($_POST['imgid']);
    }


    if( isset($_POST['planTextDelete']) )
    {
        $plan =& $community->floorPlans->getItemById($_POST['planid']);

        $plan->deleteDetailTextFromArray($_POST['textid']);
    }        


    header("Location: $rootPath{$bse->retPage}");
?>