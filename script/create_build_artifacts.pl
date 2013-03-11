#!/usr/local/bin/perl

#  Ed Fitch
#
#  Script to zip up the build's distribution folders.
#  INPUT: working directory

use File::Basename;
use strict;
use warnings;


# local working directory
my $dir    = $ARGV[0];

# move to the local working dir
chdir($dir) or die "Cant chdir to $dir $!\n";

my $conf;
my @folders;
my $path = $ARGV[0];

# Save the folder name for each conf-* configuration folder in the jenkins working folder
opendir(DIR, $path) or die "cant find $path: $!";
while (defined(my $file = readdir(DIR)))
{
    if ($file =~ m/^conf-.*/)
    {
        if (-d "$path/$file")
        {
            push @folders,"$path/$file";
        }
    }
}
closedir(DIR);

# Create the dist package
MVLog ("Create tar.gz for: dist\n");
system ( "tar -zcpvf dist.tar.gz dist" );

# Create conf packages for each configuration
foreach my $path (@folders)
{
    $conf = basename($path);
    MVLog ("Create tar.gz for: $conf\n");
    system ( "tar -zcpvf $conf.tar.gz $conf" );
}



sub MVLog
{
    my $output = $_[0];
    my $stars = "********************************************************************************\n";
    print "$stars $output \n$stars";
}
