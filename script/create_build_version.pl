#!/usr/local/bin/perl

#  Ed Fitch
#
#  Script to pull a developer managed base version from a project configuration
#  file and append the Git revision count and SHA hash to create an automated
#  build version.
#  x.y.<number of commits>.r<git-hash>
#  INPUT: working directory
#  INPUT: file containing a version property
#  INPUT: the property name

use strict;


# local working directory
my $dir    = $ARGV[0];

# file with base app version
my $configFile = $ARGV[1];

# property name
my $propertyName = $ARGV[2];

# move to the local working dir so the git command can access the .git repository folder
chdir($dir) or die "Cant chdir to $dir $!\n";

# obtain the base build number(x.y.*) from a config file
# app_version = x.y.*
`grep $propertyName '$dir/$configFile'` =~ m/"(\d+.\d+.*)"/ or die "couldn't find $propertyName in $configFile\n";

my $baseVersion = $1;

# return a count of total revisions formatted as '0001'
my $revCount = `git rev-list HEAD | wc -l | sed -e 's/ *//g' | xargs -n1 printf %04d`;

# return the SHA hash for this revision
my $shaHash = `git rev-parse --short HEAD`;

# create  the new version number
my $newVersion = $baseVersion . "." . $revCount . "." . $shaHash;
MVLog("found $baseVersion in $configFile, created $newVersion");

# save new version number to .property file so that jenkins can use it with envinject plugin
MVLog("Creating package_version.properties file for version $newVersion");
`echo PACKAGE_VERSION="$newVersion" > $dir/../package_version.properties`;

sub MVLog
{
    my $output = $_[0];
    my $stars = "********************************************************************************\n";
    print "$stars $output \n$stars";
}
