use strict;

my @row_names=();
my %biological_replicates=();
my %header=();
my %read_counts=();
open(A,"featureCounts.out.matrix.txt");
while(my $line=<A>){
	$line=~s/\r//;
	chomp($line);
	
	my @tmp=split("\t",$line);
	push(@row_names,$tmp[0]);
	
	if($line=~/^Gene/){
		#print"$line\n";
		
		my $count_tmp=0;
		foreach my $each_tmp(@tmp){
			#print"$each_tmp\n";
			
			if($count_tmp >= 1){
				#print"$each_tmp\n";
				
				my $name=$each_tmp;
				#print"$name\n";
				$name=~s/N_\d\d\d\.//;
				#print"$name\n";
				
				$name=~/^Bd21|^col|^sta|^Bd14-1/;
				my $sp=$&;
				$name=~/Exp[-_]\d\d/;
				my $Exp=$&;
				$Exp=~s/^Exp[-_]//;
				$name=~/No[-_]\d\d/;
				my $No=$&;
				$No=~s/^No[-_]//;
				#print"$sp\t$Exp\t$No\n";
				
				if($sp eq "Bd14-1"){
					
					$name=~/BhB[ds]$/;
					$sp=$&;
					
				}
				#print"$sp\t$Exp\t$No\n";
				
				my $key_biological_replicates="$sp.$No";
				push(@{$biological_replicates{$key_biological_replicates}},$Exp);
				
				my $youso_header="$sp.$No.$Exp";
				$header{$count_tmp}=$youso_header;
				
			}
			
			$count_tmp++;
			
		}
		
	}else{
		
		my $count_tmp=0;
		foreach my $each_tmp(@tmp){
			
			if($count_tmp >= 1){
				
				$read_counts{$header{$count_tmp}}{$tmp[0]}=$each_tmp;
				
			}
			
			$count_tmp++;
			
		}
		
	}
	
}
close(A);

foreach my $each_row_name(@row_names){
	#print"$each_row_name\n";
	
	my $pri=$each_row_name;
	my $sampling_time="";
	my @order=("Bd21","col","sta","BhBd","BhBs");
	foreach my $each_order(@order){
		#print"$each_order\n";
		
		$sampling_time=10;
		
		my @sorted=sort{(split /\./,$a)[1]<=>(split /\./,$b)[1]}keys(%biological_replicates);
		foreach my $each_sorted(@sorted){
			#print"$each_sorted\n";
			
			my @tmp_each_sorted=split(/\./,$each_sorted);
			if($tmp_each_sorted[0] eq $each_order){
				#print"$each_sorted\n";
				
				my $num_biological_replicates=scalar(@{$biological_replicates{$each_sorted}});
				if($num_biological_replicates ne 3){
					die();
				}
				
				my @sorted2=sort{$a <=> $b}@{$biological_replicates{$each_sorted}};
				my $biological_replicates=1;
				foreach my $each_sorted2(@sorted2){
					
					my $sample="$each_sorted.$each_sorted2";
					#print"$sample\n";
					
					my $pri_sample="";
					$sample=~/^Bd21|^col|^sta|^BhBd|^BhBs/;
					$pri_sample="$&.$sampling_time.$biological_replicates";
					
					if($each_row_name eq "Gene"){
						#print"$sample\t$pri_sample\n";
						
						$pri.="\t$pri_sample";
						
					}else{
						
						$pri.="\t$read_counts{$sample}{$each_row_name}";
						
					}
					
					$biological_replicates++;
					
				}
				
				$sampling_time+=4;
				$sampling_time-=24 if $sampling_time > 24;
				
			}
			
		}
		
	}
	
	print"$pri\n";
	
}
