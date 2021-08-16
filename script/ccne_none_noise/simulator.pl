#!/usr/bin/perl -w
use strict;
use warnings;

my $times = 100;

my $start = 100;
my $end = 1000;
my $step = 100;
for(my $j=1;$j<=$times;$j++)
{
	my $genome = 'genome_kpc'.'_'.$j;
	mkdir("$genome");
	my $bed = 'bed_kpc_'.$j;
	mkdir($bed);
	system(" ~/bin/bbmap/randomreads.sh ref=DD01777.chr.fasta out1=DD01777.chr_100.1.fq out2=DD01777.chr_100.2.fq seed=-1 length=150 coverage=100 paired=t addpairnum=t");

	for(my $i= $start;$i<=$end;$i+=$step)
	{
		system("~/bin/bbmap/randomreads.sh ref=DD01777.KPC.fasta out1=DD01777.KPC_$i.1.fq out2=DD01777.KPC_$i.2.fq seed=-1 length=150 coverage=$i paired=t addpairnum=t");
		system("cat DD01777.chr_100.1.fq DD01777.KPC_$i.1.fq > ./$genome/DD01777.genome_$i.1.fq");
		system("cat DD01777.chr_100.2.fq DD01777.KPC_$i.2.fq > ./$genome/DD01777.genome_$i.2.fq");
	}
	chdir("$genome");
	system("pigz *");
	chdir("..");
	system("perl mapping.pl $bed $genome");
	system("rm *.fq");
	system("rm -r genome_kpc_*");
}
