#!/usr/bin/perl -w
use strict;
use warnings;

my $start = 100;
my $end = 1000;
my $step = 100;
my $bed = $ARGV[0];
my $genome = $ARGV[1];
open IN,"<index_list";
my %indexList = ();
while(my $line = <IN>)
{
        chomp $line;
        $line =~ /index\/(.+)\.fa/;
        $indexList{$1} = $line;
}


for(my $i=$start;$i<=$end;$i+=$step)
{
	for my $k(keys %indexList)
	{
		if(-e "./$bed/$i.$k.bed")
		{
			next;
		}
		else
		{
			system("bwa mem $indexList{$k} ./$genome/DD01777.genome_$i.1.fq.gz ./$genome/DD01777.genome_$i.2.fq.gz -t 80 |samtools view -b -F 4 - | samtools sort - | bedtools genomecov -ibam - -dz > ./$bed/$i.$k.bed");
		}
	}
}
