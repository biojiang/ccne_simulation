#!/usr/bin/perl -w
use strict;
use warnings;
use Statistics::Descriptive;


my %kpc = ();
my %rpob = ();
my $start = 100;
my $end = 1000;
my $step = 100;
my $bed = $ARGV[0];
my $j = $ARGV[1];
for(my $i=$start;$i<=$end;$i+=$step)
{
	$kpc{$i} = &stat("./$bed/$i.KPC-2.bed");
	$rpob{$i} = &stat("./$bed/$i.rpoB.bed");
	
}
for my $k(keys %kpc)
{
	print $j,"\t",$k,"\t",$kpc{$k},"\t",$rpob{$k},"\t",$kpc{$k}/$rpob{$k},"\t",int($kpc{$k}/$rpob{$k}+0.5),"\n";
}

sub stat()
{
	my $f = shift;
	open BED,"<$f";
	my $sum = 0;
	my $i = 0;
	my @stat = ();
	my $l = 0;
	while(my $line = <BED>)
	{
		chomp $line;
		my @arr = split/\t/,$line;
		#$sum += $arr[-1];
		#$i++;
		push @stat,$arr[-1];
	}
	#@stat = sort{$b<=>$a} @stat;
	#print join("\n",@stat),"\n";
	#exit;
	map{$sum+=$_;$i++;}@stat[$l-1..$#stat-$l];
	return $sum/$i;
}
