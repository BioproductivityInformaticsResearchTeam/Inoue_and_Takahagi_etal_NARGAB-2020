use strict;

my %header=();
open(A,"RPM_Bd21_col_sta_BhBd_BhBs_Bh.txt");
while(my $line=<A>){
	$line=~s/\r//;
	chomp($line);
	
	my @tmp=split(/\t/,$line);
	
	if($line=~/^Gene/){
		
		my $count_tmp=0;
		foreach my $each_tmp(@tmp){
			#print"$each_tmp\n";
			
			$count_tmp++;
			if($count_tmp >= 2){
				
				my $sp_time=$each_tmp;
				$sp_time=~s/\.\d$//;
				#print"$sp_time\n";
				$header{$count_tmp}=$sp_time;
					
			}
			
		}
		
	}else{
		
		my $gene=$tmp[0];
		my $count_tmp=0;
		my $count_tmp2=0;
		my $count_expressed=0;
		foreach my $each_tmp(@tmp){
			
			$count_tmp++;
			if($count_tmp >= 2){
				
				$count_tmp2++;
				$count_expressed++ if $each_tmp >= 1;
				
				if($count_tmp2 == 3){
					
					if($count_expressed == 3){
						
						my $out="$header{$count_tmp}.expressed_gene_list.txt";
						open(OUT,">>$out");
						print OUT "$gene\n";
						close(OUT);
						
					}
					
					$count_tmp2=0;
					$count_expressed=0;
					
				}
				
			}
			
		}
		
	}
	
}
close(A);
