use strict;
use warnings;

open IN,"<$ARGV[0]";
my $Tratio = $ARGV[1];
my $Pratio = $ARGV[2];

my $count = 0;

my $error = 0;

while(my $line = <IN>)
{
	chomp $line;
	my @arr = split/\t/,$line;
	if((($arr[$Tratio-1]/100) - int($arr[$Pratio-1]+0.5)) != 0)
	{
		$error++;
	}
	$count ++;
	
}
print 1-$error/$count; 
