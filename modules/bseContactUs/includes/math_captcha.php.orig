<?php

// Math Captcha, Creates a math equation for users to answer as the captcha code
// Randomly chooses numbers between 1 & 5 as the two parts of the equation
// Randomly chooses the name of the input textbox that receives the answer
// Stores the values of the answer and the field name in session variables

class mathCaptcha
{

    public  $msg,
            $fieldName;

    public function __construct()
    {
        if( session_id() == 0 )
            session_start();
    
        $eq1 = mt_rand(1, 5);
        $eq2 = mt_rand(1, 5);
        $operator = "plus";
        $answer = $eq1 + $eq2;
    
        if($eq1 - $eq2 > 0 )
        {
            $operator = "minus";
            $answer = $eq1 - $eq2;
        }
    
        $eq = "$eq1 $operator $eq2";
        $this->msg = "What is $eq";

        $text = hash("md5", mt_rand(10000, 99999) );
        $text = substr($text, mt_rand(0, strlen($text) - 9), 8);
        $this->fieldName = $text;

        $_SESSION['mathCaptcha_answer'] = $answer;
        $_SESSION['mathCaptcha_field'] = $this->fieldName;
    }
}