#!/usr/bin/perl -w

# PHP File Uploader with progress bar Version 1.35
# Copyright (C) Raditha Dissanyake 2003
# http://www.raditha.com

# Licence:
# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
# 
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
# 
# The Initial Developer of the Original Code is Raditha Dissanayake.
# Portions created by Raditha are Copyright (C) 2003
# Raditha Dissanayake. All Rights Reserved.
# 

# CHANGES:
# As of version 1.00 cookies were abolished!
# as of version 1.02 stdin is no longer set to non blocking.

use CGI;
use Fcntl qw(:DEFAULT :flock);

#use Carp;     
#uncommment the above line if you want to debug. 

if (length ($ENV{'QUERY_STRING'}) > 0){
      $buffer = $ENV{'QUERY_STRING'};
      @pairs = split(/&/, $buffer);
      foreach $pair (@pairs){
           ($name, $value) = split(/=/, $pair);
           $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
           $in{$name} = $value; 
      }
}
$sessionid = $in{'sid'};
$path = $in{'path'};
$baseDir = $in{'root'};

$content_type = $ENV{'CONTENT_TYPE'};
$len = $ENV{'CONTENT_LENGTH'};
$bRead=0;
$|=1;

sub bye_bye {
    $mes = shift;
    print "Content-type: text/html\n\n";
    print "<br>$mes<br>\n";

    exit;
}

$base_dir=$baseDir . "/tmp";
$user_dir=$base_dir . "/" . $sessionid;

$|=1;                                #unbuffers streams
$php_uploader=$path."saveVideo.php"; # CHANGE THIS TO YOUR PHP SCRIPTS URL

$post_prog = "/usr/bin/POST"; # needs to have LWP module installed - available free from CPAN.

$max_upload = 500000000; # close enough to 500Mb :-) set this to whatever you feel suitable for you
                       # site and bandwidth availability.

1;    # delete this line and you get heap big error message. :-)


# see if we are within the allowd limit.

if($len > $max_upload)
{
    close (STDIN);
    bye_bye("The maximum upload size has been exceeded");
}

#
# see if the directory exists, if it does, go ahead, else try to make it
# if you can't make the directory it's time for bye byes.
#
unless (-d "$user_dir"){
    mkdir ("$user_dir", 0777); # unless the dir exists, make it ( and chmod it on UNIX )
    chmod(0777, "$user_dir");
}


unless (-d "$user_dir"){
    # if there still is no dir, the path entered by the user is wrong and the upload will fail

    bye_bye("sorry could not save file to $user_dir");

}

#
# The thing to watch out for is file locking. Only
# one thread may open a file for writing at any given time.
# 

sysopen(FH, "$user_dir/flength", O_RDWR | O_CREAT)
    or die "can't open numfile: $!";
# autoflush FH
$ofh = select(FH); $| = 1; select ($ofh);
flock(FH, LOCK_EX)
    or die "can't write-lock numfile: $!";
seek(FH, 0, 0)
    or die "can't rewind numfile : $!";
print FH $len;    
close(FH);    
    
sleep(1);

open(TMP,">","$user_dir/postdata") or &bye_bye ("can't open temp file");
open(COMP,">","$user_dir/complete") or &bye_bye ("can't open temp file");

#
# read and store the raw post data on a temporary file so that we can
# pass it though to a CGI instance later on.
#

open (POST,"|$post_prog -c\"$content_type\" $php_uploader ");

my $i=0;

$ofh = select(TMP); $| = 1; select ($ofh);
            
while (read (STDIN ,$LINE, 4096) && $bRead < $len )
{
    $bRead += length $LINE;
    $size = -s "$user_dir/postdata";
    
    $i++;
    $percent = ($size / $len) * 100;
    print TMP $LINE;
    print POST $LINE;
    print COMP $percent."\n"; 
}

#clean up operations.
close (TMP);
close (POST);
print COMP "100\n";
close (COMP);

my $url = $path."done.php";
print "Status: 302 Moved\nLocation: $url\n\n";
#
# We don't want to decode the post data ourselves. That's like
# reinventing the wheel. We also don't want to handle the data
# using the CGI module since the whole purpose of this excercise
# is to support file upload with progress bar for PHP scripts.
#