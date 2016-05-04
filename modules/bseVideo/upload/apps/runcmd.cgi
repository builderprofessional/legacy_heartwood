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

print "Content-type: text/html\n\n";
$cmd = 'ftp -h'; # 2>/dev/null';
print "Running Command: $cmd<br />";
open(CMD, "$cmd |") or die "Can't run '$cmd'\n$!\n";

$i=0;
while(<CMD>)
{ 
    # each line of output is put into $_# this bit just illustrates how each line of output might be processed
    next if /^total/; # because we're only interested in real output    
    print $_."<br />";
}