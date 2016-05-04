<?php

global $mcTbl;

$mcTbl = "bseMortgageCalc";

class mortgageYear
{

        public $yearNum,
               $interestPaid,
               $principalPaid,
               $months;

        public function __construct($yearNum)
        {
            $this->months = array(12);
            $this->yearNum = $yearNum;
            $this->interestPaid = $this->principalPaid = 0;
        }


        public function addMonth($monthNum)
        {
            $retIndex = count($this->months);
            if( $retIndex < 13 )
            {
                $this->months[$retIndex] = new mortgageMonth($monthNum);
                return $retIndex;
            }
            else
                return -1;
        }
}




class mortgageMonth
{
        public $monthNum,
               $interestPaid,
               $principalPaid,
               $remainingBalance;

        public function __construct($monthNum)
        {
            $this->monthNum = $monthNum;
            $this->interestPaid = $this->principalPaid = 0;
        }
}




class bseMortgageCalculator extends bseModule
{

    protected $price,
              $interest,
              $percentDown,
              $termDuration,
              $monthTerm,
              $curYearInterestPaid,
              $curYearPrincipalPaid,
              $downPayment,
              $pmi,
              $monthlyPropertyTax,
              $yearlyPropertyTax,
              $assessedValue,
              $monthlyPayment,
              $calculated,
              $rateAnnualInterest,
              $rateMonthlyInterest,
              $years,
              $contentWidth;


        public function __construct($rootPath)
        {
            parent::__construct($rootPath, "modules/bseMortgageCalculator/");
            $this->setTableName($GLOBALS['mcTbl']);

            include("{$this->rootPath}{$this->storeDir}includes/config.inc");
            $this->contentWidth = $contentWidth;

            $this->curYearInterestPaid = 0;
            $this->curYearPrincipalPaid = 0;
            $this->pmi = 0;
            $this->monthTerm = 0;
            $this->monthlyPayment = 0;
            $this->calculated - false;
            $this->years = array();
        }
        
        
        
        public function setMortgageData($salePrice = null, $annualInterestPercentage = null, $termLength = null, $downPercentage = null)
        {
            if( is_null($salePrice) )
                $salePrice = "300000";
                
            if( is_null($annualInterestPercentage) )
                $annualInterestPercentage = "6.5";
                
            if( is_null($termLength) )
                $termLength = "30";
                
            if( is_null($downPercentage) )
                $downPercentage = "10";
                
            $this->price = ereg_replace( "[^0-9.]", "", $salePrice);
            $this->interest = ereg_replace( "[^0-9.]", "", $annualInterestPercentage);
            $this->termDuration = ereg_replace( "[^0-9.]", "", $termLength);
            $this->percentDown = ereg_replace( "[^0-9.]", "", $downPercentage);
        }
        
        
        
        public function setCalculatorId($id)
        {
            $calcid = $this->getEscapedString($id);
            
            $data = $this->getQueryData("SELECT * FROM `{$this->table}` WHERE `id` = '$calcid'");
            $this->setDataFromArray($data);
        }





        private function getFactor() 
        {
            $factor = 0;
            $baseRate = 1 + $this->rateMonthlyInterest;
            $denominator = $baseRate;
            for ($i=0; $i < ($this->termDuration * 12); $i++) 
            {
                $factor += (1 / $denominator);
                $denominator *= $baseRate;
            }
            return $factor;
        }



        public function calculateSummaryAmounts()
        {
            $this->monthTerm = $this->termDuration * 12;
            $this->downPayment = $this->price * ($this->percentDown / 100);
            $this->rateAnnualInterest = $this->interest / 100;
            $this->rateMonthlyInterest = $this->rateAnnualInterest / 12;
            $this->financingPrice = $this->price - $this->downPayment;
            $this->monthlyFactor = $this->getFactor();
            $this->monthlyPayment = $this->financingPrice / $this->monthlyFactor;

            if ($this->percentDown< 20)
            {
                $this->pmiDesc = "Since you are putting less than 20% down, you will need to pay PMI (Private Mortgage Insurance), which tends to be about $55 per month for every $100,000 financed (until you have paid off 20% of your loan).";
                $this->pmi = 55 * ($this->financingPrice / 100000);
            }

            $this->assessedValue = ($this->price * .85);
            $this->yearlyPropertyTax = ($this->assessedValue / 1000) * (int)$this->propTaxRate;
            $this->monthlyPropertyTax = $this->yearlyPropertyTax / 12;
            $this->calculated = true;
        }




        public function getMonthlyBreakdownArray()
        {
            // Variables
            $principal = $this->financingPrice ;
            $curMonth = 1;
            $curYear  = 1;

            // Calculations
            $power = -($this->monthTerm);
            $denom = pow((1 + $this->rateMonthlyInterest), $power);
            $this->monthlyPayment = $principal * ($this->rateMonthlyInterest / (1 - $denom));
                
            // For each month of the term, get payment values
            $this->years[$curYear] = new mortgageYear($curYear);
            while ($curMonth <= $this->monthTerm)
            {
                $paidInterest = $principal * $this->rateMonthlyInterest;
                $paidPrincipal = $this->monthlyPayment - $paidInterest;
                $balance = $principal - $paidPrincipal;
                
                $monthIndex = $this->years[$curYear]->addMonth($curMonth);
                if( $monthIndex == -1 )  // Something has gone wrong because we should have started a new year with new months. We'll fix this.
                {
                    $curYear++;
                    $this->years[$curYear] = new mortgageYear($curYear);
                    $monthIndex = $this->years[$curYear]->addMonth($curMonth);
                }

                $this->years[$curYear]->months[$monthIndex]->interestPaid = $paidInterest;
                $this->years[$curYear]->months[$monthIndex]->principalPaid = $paidPrincipal;
                $this->years[$curYear]->months[$monthIndex]->remainingBalance = ($balance < 0 ? 0 : $balance);

                $this->years[$curYear]->interestPaid += $paidInterest;
                $this->years[$curYear]->principalPaid += $paidPrincipal;
                        
                if( ($curMonth % 12) == 0 )    // Should go to another year
                {
                    $this->years[$curYear+1] = new mortgageYear($curYear);
                }

                $principal = $balance;
                $curMonth++;
            }
            return $this->years;
        }


        public function getFormSubmitHref()
        {
            return $this->rootPath.$this->storeDir."calculate.php";
        }



        public function getTotalMonthlyPayment()
        {
            return (float) $this->monthlyPayment + $this->pmi + $this->monthlyPropertyTax;
        }

}
?>