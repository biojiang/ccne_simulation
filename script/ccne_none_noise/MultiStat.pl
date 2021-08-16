#!/usr/bin/perl -w
use strict;
use warnings;

for(my $i=1;$i<=100;$i++)
{
	system("perl statCNV.pl bed_kpc_$i $i");
}
