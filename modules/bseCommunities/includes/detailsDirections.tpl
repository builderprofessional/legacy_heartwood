          $rsCommunity = mysql_query( "SELECT * FROM communities WHERE communityID=".$CommunityID );
          if( $rowCommunity = mysql_fetch_assoc( $rsCommunity ))
          {
              print "<h2>".$rowCommunity['communityName']." Community Directions</h2>";
              print "<a href='printcommunitydetail.php?CommunityID=".$CommunityID."&DetailPanel=".$DetailPanel."' target='_blank'><img border=0 src='images/print_off.gif' /></a><br /><br />";
              print "<br />";

              print "<table class='centered' width='400' border=1><tr><td align='center'>";
              print "<h3>Directions</h3>";

              $PlatText = new bseTextContent;
              $PlatText->SetUpTextContent("communitydetail.php?DetailPanel=6&CommunityID=".$CommunityID,"DirectionText".$CommunityID,"",1);
              $PlatText->WriteCode();

              print "</td></tr></table>";

              print "<br />";
          }

