use strict;

#2020/04/03
# to select genes listed in get_exprssion_patterns_all_timepoints.pl.stdout from *_RPM.csv

my $file="get_exprssion_patterns_all_timepoints.pl.stdout";
my %gene=();
open(FILE,$file);
while(<FILE>){
	s/\r//;
	chomp;
	my @tmp=split(/\t/,$_);
	if($tmp[0]=~/^Bradi/){
		$gene{"$tmp[0].v3.1"}=$tmp[0];
	}
}
close(FILE);
my $num=scalar(keys(%gene));
print "$num\n";	


my @csv=glob("*_RPM.csv");
foreach my $each(@csv){
	my $count_in=0;
	my $count_out=0;
	my $count_ng=0;

	my $file=$each;
	$file=~s/\.csv$/\_selected\.csv/;
	open(CSV,$each);
	open(OUT,"+>$file");
	my $head=<CSV>;
	print OUT "$head";
	while(<CSV>){
		$count_in++;
		s/\r//;
		chomp;
		my @tmp=split(/,/,$_);
		my $id=$tmp[0];
		if($gene{$id}=~/^Bradi/){
			print OUT "$_\n";
			$count_out++;
		}else{
			$count_ng++;
		}		
	}
	close(CSV);
	close(OUT);
	print "$each ->  $file (in: $count_in, out: $count_out, ng: $count_ng)\n";
}


