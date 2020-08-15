use strict;

my %gene_P2num=();
my @timepoints=(10,14,18,22,2,6);
foreach my $each_timepoint(@timepoints){
	#print"$each_timepoint\n";
	
	my @files=glob("P*.$each_timepoint.genes.txt");
	foreach my $each_file(@files){
		#print"$each_file\n";
		
		my $P2num="";
		$P2num=1 if $each_file=~/^P1/;
		$P2num=2 if $each_file=~/^P5/;
		$P2num=3 if $each_file=~/^P9/;
		$P2num=4 if $each_file=~/^P2/;
		$P2num=5 if $each_file=~/^P3/;
		$P2num=6 if $each_file=~/^P4/;
		$P2num=7 if $each_file=~/^P7/;
		$P2num=8 if $each_file=~/^P6/;
		$P2num=9 if $each_file=~/^P8/;
		#print"$each_file\t$P2num\n";
		
		open(A,"$each_file");
		while(my $line=<A>){
			$line=~s/\r//;
			chomp($line);
			
			$gene_P2num{$line}{$each_timepoint}=$P2num;
			
		}
		close(A);
		
	}
	
}

print"gene\t10:00\t14:00\t18:00\t22:00\t2:00\t6:00\n";
my @sorted=sort{(split /Bradi|g/,$a)[1]<=>(split /Bradi|g/,$b)[1] or (split /Bradi|g/,$a)[2]<=>(split /Bradi|g/,$b)[2]}keys(%gene_P2num);
foreach my $each_sorted(@sorted){
	#print"$each_sorted\n";
	
	my $num_expressed=scalar(keys($gene_P2num{$each_sorted}));
	if($num_expressed == 6){
		#print"$each_sorted\n";
		
		my $pri="$each_sorted";
		foreach my $each_timepoint2(@timepoints){
			#print"$each_timepoint2\n";
			
			my $P2num=$gene_P2num{$each_sorted}{$each_timepoint2};
			#print"$P2num\n";
			
			$pri.="\t$P2num";
			
		}
		print"$pri\n";
		
	}else{
		
		if($num_expressed <= 5){
			
		}else{
			die();
			
		}
		
	}
	
}
