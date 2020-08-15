use strict;

print"Gene";

my %read_counts=();
my @files=glob("/raid/share/ALCA/Bd21_col_sta_Bd14-1/results/*.featureCounts.out");

my @sorted=sort{(split /\/|N_|\.Bd21|\.col|\.sta|\.Bd14-1/,$a)[7]<=>(split /\/|N_|\.Bd21|\.col|\.sta|\.Bd14-1/,$b)[7]}@files;
foreach my $each_sorted(@sorted){
	#print"$each_sorted\n";
	
	my @tmp_each_sorted=split(/\//,$each_sorted);
	my $name=$tmp_each_sorted[6];
	$name=~s/\.B?h?B[ds]\.featureCounts\.out//;
	#print"$name\n";
	
	my $origin="";
	if($name=~/Bd14-1/){
		
		$tmp_each_sorted[6]=~/BhB[ds]/;
		$origin=$&;
		$name="$name.$origin";
		
	}
	#print"$name\n";
	
	print"\t$name";
	
	open(A,"$each_sorted");
	while(my $line=<A>){
		$line=~s/\r//;
		chomp($line);
		
		if($line=~/^\#|^Geneid/){
			#print"$line\n";
			
		}else{
			#print"$line\n";
			
			my @tmp=split("\t",$line);
			#print"$tmp[0]\t$tmp[6]\n";
			
			push(@{$read_counts{$tmp[0]}},$tmp[6]);
			
		}
		
	}
	close(A);
	
}
print"\n";

my @sorted2=sort{(split "Bradi|g",$a)[1]<=>(split "Bradi|g",$b)[1] or (split "Bradi|g",$a)[2]<=>(split "Bradi|g",$b)[2]}keys(%read_counts);
foreach my $each_sorted2(@sorted2){
	#print"$each_sorted2\n";
	
	print"$each_sorted2";
	foreach my $each_read_count(@{$read_counts{$each_sorted2}}){
		
		print"\t$each_read_count";
		
	}
	print"\n";
	
}
