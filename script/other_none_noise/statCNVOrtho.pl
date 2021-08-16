#!/usr/bin/perl -w
use strict;
use warnings;

my $kpc_ctg = 'DD01777_58';
my @kpc_pos = (16539,17420);

my %bed = ();

open IN,"<$ARGV[0]";
while(my $line = <IN>)
{
	chomp $line;
	my @arr = split/\t/,$line;
	if(exists $bed{$arr[0]})
	{
		push @{$bed{$arr[0]}},$arr[-1];
	}
	else
	{
		@{$bed{$arr[0]}} = ($arr[-1]);
	}
}

my $total = ();

open IN,"<$ARGV[1]";
my $num = 0;
while(my $line = <IN>)
{
	chomp $line;
	$num ++;
	my @arr = split/\t/,$line;
	my $len = $arr[3]-$arr[2]+1;
	my $cov = 0;
	for(my $i=$arr[2]-1;$i<=$arr[3]-1;$i++)
	{
		$cov += ${$bed{$arr[1]}}[$i];
	}
	$total += $cov/$len;
	
}
my $ave = $total/$num;
my $kpc_cov = 0;
my $kpc_len = $kpc_pos[1] - $kpc_pos[0] +1;
for(my $i=$kpc_pos[0]-1;$i<=$kpc_pos[1]-1;$i++)
{
	$kpc_cov += ${$bed{$kpc_ctg}}[$i];
}

$kpc_cov = $kpc_cov/$kpc_len;

$ARGV[0] =~ /bed_kpc_(\d+)\/(\d+)\.DD01777_norm\.bed/;

print $1,"\t",$2,"\t",$kpc_cov/$ave,"\n";







