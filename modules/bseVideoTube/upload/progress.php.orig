<?php
    session_start();
    if( !isset($_SESSION['pcnt']) )
        $_SESSION['pcnt'] = 0;
    
    $sid=$_GET['sid'];
    
    $line = shell_exec("tail -n 1 tmp/$sid/complete");
    $line = number_format(round(floatval($line), 2), 2);
    if( $line > $_SESSION['pcnt'] )
        $_SESSION['pcnt'] = $line;
    
    echo $_SESSION['pcnt'];

?>