#!/usr/local/bin/perl

use strict;
use Getopt::Long;
use Cwd;
use Cwd 'abs_path';
use File::Path qw(make_path remove_tree);
use File::Basename qw(dirname);

my $help;
my $srcDir = cwd();
my $destDir = undef;
my $debug = undef;
my $fileName = undef;

if($#ARGV < -1){
  print "Syntax: hierarchical_copy.pl --help for al options\n";
  exit 0;
}

GetOptions ("help"        =>  \$help,
            "src=s"       =>  \$srcDir,
            "dest=s"      =>  \$destDir,
            "debug"       =>  \$debug,
            "f=s"         =>  \$fileName,
            );



if($help){
  print "Syntax: hierarchical_copy.pl [--debug] --src=<input_directory> --dest=<output_directory> -f=<file_to_be_copied>\n";
  exit 0;
}

$srcDir = abs_path($srcDir);
$destDir = abs_path($destDir);
my @allFiles = split("\n",`find $srcDir -name $fileName|grep $fileName`);

foreach my $file (@allFiles){
  my $srcPath = abs_path($file);
  my $destPath = $srcPath;
  $destPath =~ s/$srcDir/$destDir/;
  print "$srcPath -> $destPath\n";
  my $destPathDir = dirname($destPath);
  make_path($destPathDir);
  system("cp -au $srcPath $destPath");
}


print "hierarchical_copy.pl completed successfully\n";
