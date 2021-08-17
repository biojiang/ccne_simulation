#!/usr/bin/perl -w
use strict;
use warnings;

open IN,"<$ARGV[0]";
my $Tratio = $ARGV[1];
my $Pratio = $ARGV[2];

my $count = 0;
my $se = 0;
while(my $line = <IN>)
{
	chomp $line;
	my @arr = split/\t/,$line;
	$se += ( ($arr[$Tratio-1]/100)-$arr[$Pratio-1])**2;
	$count ++;
	
} 

my $rmse = sqrt($se/$count);

print $rmse;
