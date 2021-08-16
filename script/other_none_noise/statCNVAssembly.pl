#!/usr/bin/perl -w
use strict;
use warnings;


my $kpc_ctg = 'DD01777_58';
my @kpc_pos = (16539,17420);

my %ctg_len = ();
my %ctg_depth = ();
my $total_len = 0;
open IN,"<$ARGV[0]";

while(my $line = <IN>)
{
	chomp $line;
	$total_len++;
	my @arr = split/\t/,$line;
	if(exists $ctg_len{$arr[0]})
	{
		$ctg_len{$arr[0]}++;
	}
	else
	{
		$ctg_len{$arr[0]} = 1;
	}
	if(exists $ctg_depth{$arr[0]})
	{
		$ctg_depth{$arr[0]} += $arr[-1];
	}
	else
	{
		$ctg_depth{$arr[0]} = $arr[-1];
	}
}
#print $total_len;
#exit;
my $weighted_ave = 0;
for my $k(keys %ctg_depth)
{
	$weighted_ave += ($ctg_depth{$k}/$ctg_len{$k})*($ctg_len{$k}/$total_len);
}

my $kpc_depth = $ctg_depth{$kpc_ctg}/$ctg_len{$kpc_ctg};
$ARGV[0] =~ /bed_kpc_(\d+)\/(\d+)\.DD01777_assembly\.bed/;
print $1,"\t",$2,"\t",$kpc_depth/$weighted_ave,"\n";

