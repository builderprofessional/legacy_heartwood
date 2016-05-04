
          print "<a href='printcommunitydetail.php?CommunityID=".$CommunityID."&DetailPanel=".$DetailPanel."' border=0 target='_blank'><img border=0 src='images/print_off.gif' /></a><br /><br />";
           $rsCommunity = mysql_query( "SELECT * FROM communities WHERE communityID=".$CommunityID );
          if( $rowCommunity = mysql_fetch_assoc( $rsCommunity ))
          {
              print "<h2>".$rowCommunity['communityName']." Community Specifications</h2>";
              print "<br />";

              $PlatImage = new bseImageContent;
              $PlatImage->SetUpImageContent("communitydetail.php?DetailPanel=5&CommunityID=".$CommunityID,"SpecImage".$CommunityID,"",400,500);
              $PlatImage->WriteCode();

              print "<br /><br />";

			  print "<div class='centered' style='border-style: solid; width: 500px' align='center'>";
			  print "<table class='centered' width='500'><tr><td bgcolor='000000'><span style='color: #ffffff;'>&nbsp;&nbsp;";
			  
			  $PlatTitleText = new bseTextContent;
              $PlatTitleText->SetUpTextContent("communitydetail.php?DetailPanel=5&CommunityID=".$CommunityID,"SpecTitleText".$CommunityID,"",0);
              $PlatTitleText->WriteCode();
			  
			  print "</span></td></tr></table><br />";
              print "<table class='centered' width='400'><tr><td align='center'>";

              $PlatText = new bseTextContent;
              $PlatText->SetUpTextContent("communitydetail.php?DetailPanel=5&CommunityID=".$CommunityID,"SpecText".$CommunityID,"",1);
              $PlatText->WriteCode();

              print "</td></tr></table></div>";

              print "<br /><br />";
          }

