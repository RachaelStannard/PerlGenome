# Rachael Stannard
# CIS 280

# Perl Project: perlGenome
# Client.pl

#!/usr/bin/perl -w

use strict;

print "\n#########################################\n";
print "#  Welcome to the Perl Genome Project!  #\n";
print "#########################################\n";

print "\n0: Create a new DNA/RNA sequence project\n";
print "q: Quit\n";
print "\nWhat would you like to do? ";

# Options for the user -------------------------------------------------------
while ((my $ui = <>) ne "q\n") {
    if ($ui eq "0\n"){
		print"\n\nCreate Project\n\n";
		&createProject;
	} else {
        print "Not an option!";
    }

	print "\nWhat would you like to do? ";
}

# Creates a new project using input from the user for name and 
# sequence length  -----------------------------------------------------------
sub createProject {
    print "Project Name: ";
	
	my $projectname = "";

	while(($projectname = <>) !~ /^[a-zA-z]+\w*/){
		print "Must begin with a letter, then followed by a word character"
		. " (Letter, numbers, and underscore).\nTry again: ";
	}

	chomp($projectname);

	print "DNA/RNA Sequence Size: ";

	my $size = 0;

	while(($size = <>) !~ /^\d+$/){
		print "Must be a digit.\nTry again: ";
	}

	chomp($size);

	print "Creating project $projectname, with sample size $size.\n";

	system("perl ./src/SeqGen.pl $projectname $size");

}
