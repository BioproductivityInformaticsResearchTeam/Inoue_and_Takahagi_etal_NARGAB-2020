use strict;

my @files=glob("/home/takahagi/ALCA_from_20190726/Bd21_col_sta_Bd14-1/DESeq2_from_20190813/Homoeolog_expression_bias/*.txt");
foreach my $each_file(@files){
	#print"$each_file\n";
	
	if($each_file=~/Bd_Bs\.\d+\.txt$|BhBd_BhBs\.\d+\.txt$/){
		#print"$each_file\n";
		
		$each_file=~/DESeq2_from_20190813\/Homoeolog_expression_bias\/(.+)_(.+)\.(\d+)\.txt$/;
		my $sp1=$1;
		my $sp2=$2;
		my $time=$3;
		print"$sp1\t$sp2\t$time\n";
		
		my $expressed_gene_list1="";
		$expressed_gene_list1="Bd21.$time.expressed_gene_list.txt" if $sp1 eq "Bd";
		$expressed_gene_list1="BhBd.$time.expressed_gene_list.txt" if $sp1 eq "BhBd";
		my $expressed_gene_list2="";
		$expressed_gene_list2="sta.$time.expressed_gene_list.txt" if $sp2 eq "Bs";
		$expressed_gene_list2="BhBs.$time.expressed_gene_list.txt" if $sp2 eq "BhBs";
		print"$expressed_gene_list1\n$expressed_gene_list2\n";
		
		my %expressed_genes=();
		open(A,"$expressed_gene_list1");
		while(my $line=<A>){
			$line=~s/\r//;
			chomp($line);
			$line=~s/\.v3\.1$//;
			#print"$line\n";
			$expressed_genes{$line}="";
		}
		
		open(B,"$expressed_gene_list2");
		while(my $line=<B>){
			$line=~s/\r//;
			chomp($line);
			$line=~s/\.v3\.1$//;
			#print"$line\n";
			$expressed_genes{$line}="";
		}
		close(B);
		
		my $out="Homoeolog_expression_bias/$sp1"."_$sp2.$time.DEG_list.txt";
		#print"$out\n";
		
		open(OUT,"+>$out");
		
		open(C,"$each_file");
		while(my $line=<C>){
			$line=~s/\r//;
			chomp($line);
			
			$line=~s/\"//g;
			#print"$line\n";
			
			if($line=~/^baseMean/){
				#print"$line\n";
				
			}else{
				
				my @tmp=split(/\s+/,$line);
				#print"$tmp[0]\t$tmp[6]\n";
				
				my $gene=$tmp[0];
				$gene=~s/\.v3\.1$//;
				my $padj=$tmp[6];
				#print"$gene\t$padj\n";
				
				if(exists($expressed_genes{$gene})){
					#print"$line\n";
					
					if($padj ne "NA" && $padj < 0.01){
						#print"$line\n";
						
						print OUT "$gene\n";
						
					}
					
				}
				
			}
			
		}
		close(C);
		
		close(OUT);
		
	}
	
}
