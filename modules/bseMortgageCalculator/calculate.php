<?php

    $rootPath = "../../";
    
    require("{$rootPath}modules/includes/main/bseMain.php");
    $bse = new bse($rootPath);
    $page = $bse->retPage;


    if( isset($_POST['mortgageCalc']) )
    {
        $calc =& $bse->getModule("bseMortgageCalculator");
        $calc->setCalculatorId(1);
        $calc->setMortgageData($_POST['price'], $_POST['interest'], $_POST['termDuration'], $_POST['percentDown']);
        $calc->calculateSummaryAmounts();
    }

    header("Location: $rootPath{$page}");
?>