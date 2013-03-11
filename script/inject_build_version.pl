#!/usr/local/bin/perl

#  Ed Fitch
#
#  Script to set the configuration files before running build
#  INPUT: build version number

use strict;

my $configFile = $ARGV[0];
my $appVersion = $ARGV[1];
my $newVersion = $ARGV[2];

# obtain the base build number(x.y.*) from $configFile
# app_version = x.y.*
`grep $appVersion '$configFile'` =~ m/"(\d+.\d+.*)"/ or die "couldn't find $appVersion in $configFile\n";

my $baseVersion = $1;

# replace $appVersion in $configFile with new values in temp config file
MVLog("Replacing $baseVersion with $newVersion");
`sed '/$appVersion/s/$baseVersion/$newVersion/g' '$configFile' > '$configFile.temp'`;

`mv '$configFile.temp' '$configFile'`;

sub MVLog
{
    my $output = $_[0];
    my $stars = "********************************************************************************\n";
    print "$stars $output \n$stars";
}

