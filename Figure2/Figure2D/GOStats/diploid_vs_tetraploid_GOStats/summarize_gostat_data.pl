use strict;
use Data::Dumper;

my @files=glob("Bd_col.*_GOHYP_BP_0.001.txt");
#print Dumper @files;
my @time=("10","14","18","22","2","6");
my %hash=();
my $pvalue_cutoff=0.0001;

my $head="";
foreach my $each(@files){
	my $time="";
	my $updown="";
	if($each=~/^(\S+)\.(\d+)\.DEG_list\.(\S+)\.txt_GOHYP_/){
		$head=$1;
		$time=$2;
		$updown=$3;
	}
	open(FILE,$each);
	<FILE>;
	while(<FILE>){
		s/\r//;
		chomp;
		my @tmp=split(/\t/,$_);
		my $goid=$tmp[1];
		my $pvalue=$tmp[2];
		my $goterm=$tmp[7];
		$goid=~s/"//g;
		$pvalue=~s/"//g;
		$goterm=~s/"//g;
		
		if($pvalue<$pvalue_cutoff){
			${${$hash{$updown}}{$time}}{"$goid	$goterm"}=$pvalue;
		}
	}
	close(FILE);
}

#print Dumper %hash;	

foreach my $each(keys(%hash)){
	print "#$head	$each\n";
	open(OUT,"+>$head.$each.p$pvalue_cutoff.log10p.txt");
	open(OUT_T,"+>$head.$each.p$pvalue_cutoff.log10p.goterm.txt");

	my @goid_list=();
	my %hash2=();
	my %hash3=%{$hash{$each}};
	foreach my $each2(sort(keys(%{$hash{$each}}))){
		foreach my $each3(keys(%{${$hash{$each}}{$each2}})){
			#print "$each	$each2	$each3\n";
			push(@{$hash2{$each3}},"$each,$each2");
		}
	}
	#print Dumper %hash2;
	@goid_list=keys(%hash2);
	print "goid	goterm	10	14	18	22	2	6\n";
	print OUT "goid	10	14	18	22	2	6\n";
	print OUT_T "goid	goterm	10	14	18	22	2	6\n";
	foreach my $each_goid(@goid_list){
		print "$each_goid";
		my @tmp=split(/\t/,$each_goid);
		print OUT "$tmp[0]";
		print OUT_T "$tmp[0]	$tmp[1]";
		foreach my $each_time(@time){
			if(${$hash3{$each_time}}{$each_goid}=~/\S+/){
				print "	${$hash3{$each_time}}{$each_goid}";
				my $value=-1*log10(${$hash3{$each_time}}{$each_goid});
				print OUT "	$value";
				print OUT_T "	$value";
			}else{
				print "	1";
				my $value=-1*log10(1);
				print OUT "	$value";
				print OUT_T "	$value";
			}
		}
		print "\n";
		print OUT "\n";
		print OUT_T "\n";
	}
	print "\n";
	print OUT "\n";
	print OUT_T "\n";		
	close(OUT);
	close(OUT_T);
}
 

sub log10 {
  my $x = shift;
  return log($x) / log(10);
}
