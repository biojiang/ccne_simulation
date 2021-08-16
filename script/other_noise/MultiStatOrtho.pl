#!/usr/bin/perl -w
use strict;
use warnings;

for(my $i=1;$i<=100;$i++)
{
	for(my $j=100;$j<=1000;$j+=100)
	{
		system("perl statCNVOrtho.pl bed_kpc_$i/$j.DD01777_norm.bed OneCopyGene.bed");
	}
}
