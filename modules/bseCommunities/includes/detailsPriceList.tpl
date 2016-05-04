          print "<a href='printcommunitydetail.php?CommunityID=".$CommunityID."&DetailPanel=".$DetailPanel."' border='0' target='_blank'><img border=0 src='images/print_off.gif' /></a><br /><br />";
          $rsCommunity = mysql_query( "SELECT * FROM communities WHERE communityID=".$CommunityID );
          if( $rowCommunity = mysql_fetch_assoc( $rsCommunity ))
          {
              print "<h2>".$rowCommunity['communityName']." Community Price List</h2>";
              print "<br />";

              print "<table class='centered' border=1 width='500' cellspacing=0 cellpadding=0>";
              print "<tr>";
              print "<th width='125'><strong>Plan</strong></th>";
              print "<th width='125'><strong>Size</strong></th>";
              print "<th width='125'><strong>Price</strong></th>";
              print "<th width='125'><strong>Completion</strong></th>";
              print "</tr>";

              $rsHome = mysql_query( "SELECT * FROM plans WHERE CommunityID=".$CommunityID );
              while( $rowHome = mysql_fetch_assoc( $rsHome ))
              {
                  if( $_SESSION['admin_logged_in'] == 1 )
                  {
                      print "<form action='ProcessCommunityLocator.php?code=9' method='POST'>";
                      print "<input type='hidden' name='page' value='communitydetail.php?DetailPanel=4&CommunityID=".$CommunityID."'>";
                      print "<input type='hidden' name='hHomeID' value='".$rowHome['idnum']."'>";
                      print "<tr>";
                      print "<td align='center'><a href='floorplandetail.php?PlanID=".$rowHome['idnum']."'>".$rowHome['PlanName']."</a></td>";
                      print "<td align='center'><input type='text' size='15' name='txtSize' value='".$rowHome['Size']."' /></td>";
                      print "<td align='center'><input type='text' size='15' name='txtPrice' value='".$rowHome['Price']."' /></td>";
                      print "<td align='center'><input type='text' size='15' name='txtCompletion' value='".$rowHome['Completion']."' /></td>";
                      print "</tr>";
                      print "<tr><td>&nbsp;</td>";
                      print "<td colspan='3'><textarea name='txtDescription' rows='3' cols='40'>".$rowHome['Description']."</textarea><br /><br />";
                      print "<input type='submit' value='Update Home'>";
                      print "</td></tr>";
                      print "</form>";
                  }
                  else
                  {
                      print "<tr>";
                      print "<td align='center'><a href='floorplandetail.php?PlanID=".$rowHome['idnum']."'>".$this->CheckSpace($rowHome['PlanName'])."</a></td>";
                      print "<td align='center'>".$this->CheckSpace($rowHome['Size'])."</td>";
                      print "<td align='center'>".$this->CheckSpace($rowHome['Price'])."</td>";
                      print "<td align='center'>".$this->CheckSpace($rowHome['Completion'])."</td>";
                      print "</tr>";
                      print "<tr><td>&nbsp;</td>";
                      print "<td colspan='3' align='center'>".($rowHome['Description']!=""?$rowHome['Description']:"&nbsp;")."</td></tr>";
                  }
              }

              if( $_SESSION['admin_logged_in'] == 1 )
              {
                  print "<tr><td colspan='4'>&nbsp;</td></tr>";
                  print "<form action='ProcessCommunityLocator.php?code=8' method='POST'>";
                  print "<input type='hidden' name='hCommunityID' value='".$CommunityID."'>";
                  print "<input type='hidden' name='page' value='communitydetail.php?DetailPanel=4&CommunityID=".$CommunityID."'>";

                  print "<tr>";
                  print "<td><select name='cmbPlan'>";

                  $rsPlan = mysql_query( "SELECT * FROM plans WHERE CommunityID=".$CommunityID );
                  while( $rowPlan = mysql_fetch_assoc( $rsPlan ))
                  {
                      print "<option value='".$rowPlan['idnum']."'>".$rowPlan['PlanName']."</option>";
                  }

                  print "</select></td>";
                  print "<td><input type='text' name='txtSize' size='15'></td>";
                  print "<td><input type='text' name='txtPrice' size='15'></td>";
                  print "<td><input type='text' name='txtCompletion' size='15'></td>";
                  print "</tr>";

                  print "<tr><td>&nbsp;</td>";
                  print "<td colspan='3'><textarea name='txtDescription' rows='3' cols='40'></textarea><br /><br /><input type='submit' value='Add Home'></td>";
                  print "</tr>";

                  print "</form>";
              }

              print "</table>";
          }


