<div style="width:<?=$this->mortgageCalc->contentWidth?>px; margin:auto; ">
    <form method="post" action="<?= $this->mortgageCalc->getFormSubmitHref() ?>">
        <div style="width:100%; background-color:#555555; color:#FFFFFF; text-align:center; font-weight:900; margin-bottom:5px;">Purchase & Financing Information</div>
        <div style="float:left; width:275px; "><div style="float:left; width:104px; text-align:right; ">Loan Amout $</div><input style="width:100px; " type="text" name="price" value="<?= $this->mortgageCalc->price ?>" /> (USD)</div>
        <div style="float:right; "><div style="float:left; margin-right:4px; ">Percent Down</div><input style="width:100px; " type="text" name="percentDown" value="<?= $this->mortgageCalc->percentDown ?>" />%</div>
        <div style="float:left; width:275px; "><div style="float:left; width:100px; text-align:right; margin-right:4px; ">Loan Duration</div><input style="width:100px; " type="text" name="termDuration" value="<?= $this->mortgageCalc->termDuration ?>" /> years</div>
        <div style="float:right; "><div style="float:left; margin-right:4px; ">Interest Rate</div><input style="width:100px; " type="text" name="interest" value="<?= $this->mortgageCalc->interest ?>" />%</div>
        <div style="width:100%; clear:both; "></div>
        <div style="clear:both; width:100%; text-align:right; margin-top:4px; "><input type="submit" name="mortgageCalc" value="Calculate" /></div>
    </form>
</div>

<?php
    if( $this->mortgageCalc->calculated )
    { ?>
<div style="width:<?=$this->mortgageCalc->contentWidth?>px; margin:auto; clear:both; margin-top:35px; ">
    <div style="width:100%; background-color:#555555; color:#FFFFFF; text-align:center; font-weight:900; ">Mortgage Payment Information</div>
    <div style="width:100%; border-bottom:solid #000000 3px; font-weight:900; height:25px; "><div style="width:100%; text-align:center; margin-top:4px; ">Down Payment: $<?= number_format($this->mortgageCalc->downPayment, 2) ?></div></div>
    <div style="width:100%; border-bottom:solid #000000 3px; font-weight:900; height:25px; "><div style="width:100%; text-align:center; margin-top:4px; ">Finance Amount: $<?= number_format($this->mortgageCalc->price - $this->mortgageCalc->downPayment, 2) ?></div></div>
    <div style="width:100%; border-bottom:solid #000000 3px; font-weight:900; height:25px; "><div style="width:100%; text-align:center; margin-top:4px; ">Monthly Payment: $<?= number_format($this->mortgageCalc->monthlyPayment, 2) ?></div></div>
    <div style="width:100%; font-weight:900; height:25px; "><div style="width:100%; text-align:center; margin-top:4px; ">PMI: $<?= number_format($this->mortgageCalc->pmi, 2) ?></div></div>
    <div style="width:100%; border-bottom:solid #000000 3px; "><?= $this->mortgageCalc->pmiDesc ?></div>
    <div style="width:100%; font-weight:900; height:25px; "><div style="width:100%; text-align:center; margin-top:4px; ">Property Tax: $<?= number_format($this->mortgageCalc->monthlyPropertyTax, 2) ?></div></div>
    <div style="width:100%; border-bottom:solid #000000 3px; ">
        Property Taxes are a little harder to figure out... The average residential tax rate in this area seems to be around $<?= $this->mortgageCalc->propTaxRate ?> per year for every $1,000 of your property's assessed value.
        <br /><br />
        Let's say that your property's assessed value is 85% of what you actually paid for it - $<?= number_format($this->mortgageCalc->assessedValue, 2) ?>. This would mean that your yearly residential taxes will be around $<?= number_format($this->mortgageCalc->yearlyPropertyTax, 2) ?>.
    </div>
    <div style="width:100%; border-bottom:solid #000000 3px; font-weight:900; height:25px; "><div style="width:100%; text-align:center; margin-top:4px; ">Total Monthly Payment: $<?= number_format($this->mortgageCalc->getTotalMonthlyPayment(), 2) ?></div></div>
</div>


		
<div style="width:<?=$this->mortgageCalc->contentWidth?>px; margin:auto; margin-top:35px; ">
    <div style="width:100%; background-color:#555555; color:#FFFFFF; text-align:center; font-weight:900; ">Calculations & Amortization</div>

    <div style="margin-top:8px; ">
        Down Payment: The price of the home multiplied by the percentage down divided by 100 (for 5% down becomes 5/100 or 0.05)
        <div style="margin-top:4px; font-size:12px; font-weight:900; ">Down Payment = $<?= number_format($this->mortgageCalc->price, 2) ?> X (<?= $this->mortgageCalc->percentDown ?> / 100) = $<?= number_format($this->mortgageCalc->downPayment, 2) ?></div>
        <hr />
    </div>

    <div style="margin-top:15px; ">
        Interest Rate: The annual interest percentage divided by 100
        <div style="margin-top:4px; font-size:12px; font-weight:900; ">Interest Rate = <?= $this->mortgageCalc->interest ?>% / 100 = <?= number_format($this->mortgageCalc->rateAnnualInterest, 4) ?></div>
        <hr />
    </div>

    <div style="margin-top:15px; ">
        Monthly Interest Rate: The annual interest rate divided by 12 (for the 12 months in a year)
        <div style="margin-top:4px; font-size:12px; font-weight:900; ">Monthly Interest Rate = <?= $this->mortgageCalc->rateAnnualInterest ?> / 12 = <?= number_format($this->mortgageCalc->rateMonthlyInterest, 4) ?></div>
        <hr />
    </div>

    <div style="margin-top:15px; ">
        Month Term Duration: The number of years you've taken the loan out for, times 12
        <div style="margin-top:4px; font-size:12px; font-weight:900; ">Month Term Duration = <?= $this->mortgageCalc->termDuration ?> Years X 12 = <?= $this->mortgageCalc->monthTerm ?> Months</div>
        <hr />
    </div>

    <div style="margin-top:15px; ">
        Monthly Payment: The Financing Amount times the Monthly Interest Rate divided by 1 minus the Monthly Interest Rate + 1 raised to the power of the negative of the Month Term Duration.
        <div style="margin-top:4px; font-size:12px; font-weight:900; ">Monthly Payment = <?= ($this->mortgageCalc->price - $this->mortgageCalc->downPayment) ?> * (<?= number_format($this->mortgageCalc->rateMonthlyInterest, 4) ?> / (1 - ((1 + <?php echo number_format($this->mortgageCalc->rateMonthlyInterest, 4) ?>)<sup>-<?= $this->mortgageCalc->monthTerm ?>)</sup>)) = $<?= number_format($this->mortgageCalc->monthlyPayment, 2) ?></div>
        <hr />
    </div>
</div>

<div style="width:<?=$this->mortgageCalc->contentWidth?>px; margin:auto; margin-top:35px;">
<div style="width:100%; text-align:center; font-weight:900; margin-bottom:5px; ">Amortization For Monthly Payments of $<?= number_format($this->mortgageCalc->monthlyPayment, 2) ?> over <?= $this->mortgageCalc->termDuration ?> years</div>

<?php

    $tableHead  = "
<table style=\"width:100%; text-align:right; border-collapse:collapse; \">
    <tr style=\"background-color:#AAA; color:#FFF; \">
        <th style=\"width:16%; border:solid #777 2px; text-align:center; \">Month</th>
        <th style=\"width:28%; border:solid #777 2px; text-align:center; \">Interest Paid</th>
        <th style=\"width:28%; border:solid #777 2px; text-align:center; \">Principal Paid</th>
        <th style=\"width:28%; border:solid #777 2px; text-align:center; \">Remaing Balance</th>
    </tr>
    ";

    $mortgageInfo = $this->mortgageCalc->getMonthlyBreakdownArray();
    for($yI = 1; $yI < count($mortgageInfo); $yI++ )
    {
        $year = $mortgageInfo[$yI];
        echo $tableHead;
        for($mI = 1; $mI < count($year->months); $mI++ )
        {
            $month = $year->months[$mI];
            echo "<tr><td style=\"border:solid #888888 1px; padding-right:5px; \">{$month->monthNum}</td><td style=\"border:solid #888 1px; padding-right:5px; \">$" . number_format($month->interestPaid, 2) . "</td><td style=\"border:solid #888 1px; padding-right:5px; \">$" . number_format($month->principalPaid, 2) . "</td><td style=\"border:solid #888 1px; padding-right:5px; \">$" . number_format($month->remainingBalance, 2) . "</td></tr>\n";
        }
        echo "
</table>
<div style=\"width:{$this->mortgageCalc->contentWidth}px; margin-top:5px; \">
    Totals for Year: {$year->yearNum}
</div>
<div style=\"margin-bottom:30px; \">
    You will spend $" . number_format($year->interestPaid + $year->principalPaid, 2) . " on your house in year {$year->yearNum}.<br />$" . number_format($year->interestPaid, 2) . " will go to Interest,<br />$" . number_format($year->principalPaid, 2) . " will go to Principal.
</div>
";
    }
    echo "</div>";
		
    }
?>
<p>This mortgage calculator can be used to figure out monthly payments of a home mortgage loan, based on the home's sale price, the term of the loan desired, buyer's down payment percentage, and the loan's interest rate. This calculator factors in PMI (Private Mortgage Insurance) for loans where less than 20% is put as a down payment. Also taken into consideration are the town property taxes, and their effect on the total monthly mortgage payment.</p>
