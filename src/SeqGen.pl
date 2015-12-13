# Rachael Stannard
# CIS 280

# Perl Project: perlGenome
# SeqGen.pl

#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../modules/String-ProgressBar/lib/";
use String::ProgressBar;

use strict;

# Project name and sequence size from client ---------------------------------
my $projectname = @ARGV[0];
my $size = @ARGV[1];

# Creates folders and files for new projects ---------------------------------
if (not -d "./projects") {
    mkdir "./projects";
}

my $pdir = "./projects/project$projectname/";

if (-d "$pdir") {
    print "$projectname already exists.\n" . 
	"Would you like to clobber it? (yes/no) ";
    if (<STDIN> eq "no\n") {
        warn "Aborting due to project name already existing";
        exit;
    }
}

mkdir "$pdir";
mkdir "$pdir/DNA/";

my $partcount = 0;

open FILE, "> ./$pdir/DNA/$filename-$partcount.ds" 
or die "Could not open '$filename'!";

# Generates the DNA sequence -------------------------------------------------

my $buffer = "";
my $filesize = 0;
my $pr = String::ProgressBar->new(max => $size);

for (my $i = 1; $i <= $size; $i++) {
    
    $pr->update($i);
    if ($i % 1000 == 0) {
        $pr->write;
    }
	
    my $rand = int(rand(4));

    if ($rand == 0) {
        $buffer .= "a";
    } elsif ($rand == 1) {
        $buffer .= "t";
    } elsif ($rand == 2) {
        $buffer .= "g";
    } else {
        $buffer .= "c";
    }

    if ($filesize >= 150000000) {
        if ($buffer =~ m/(taa|tag|tga)$/) {
            print FILE "$buffer";
            $filesize = 0;
            close FILE;
            $partcount++;
            open FILE, "> ./$pdir/DNA/$filename-$partcount.ds" or die "Could not create next partition";
        }
    } elsif (length($buffer) >= 1000) {
        print FILE "$buffer";
        $buffer = "";
        $filesize += 1000;
    }
}

$pr->write;
print FILE "$buffer";
print "\nDNA completed\n";