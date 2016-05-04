<?php

    session_start();
    if( !isset($_SESSION['encPcnt']) )
        $_SESSION['encPcnt'] = 0;
    
    $max = $_GET['frames'];
    $id = $_GET['vid'];
    $pcnt = 0;
    $curFrame = "";

    $line = shell_exec("tail -n 1 tmp/progress_$id");

    $startPos = strripos($line, "frame=");
    if( $startPos )
    {
        $curFrame = trim(substr($line, $startPos+6, 6));
        $pcnt = ceil(((int)$curFrame / (int)$max) * 100);
    }
    
    else if( substr($line, 0, 6) == "video:" )  // process complete
        $pcnt = 100;
        
    else if( $_SESSION['encPcnt'] > 20 )
        $pcnt = 100;
        
    if( $pcnt > $_SESSION['encPcnt'] )
        $_SESSION['encPcnt'] = $pcnt;
    
    echo $_SESSION['encPcnt'];
        
?>