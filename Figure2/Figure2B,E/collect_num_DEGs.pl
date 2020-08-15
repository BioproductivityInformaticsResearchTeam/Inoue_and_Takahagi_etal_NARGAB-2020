use strict;

print"Species1\tSpecies2\tTime point\tSpecies1 Up\tSpecies1 Down\n";

my @files=glob("/home/takahagi/ALCA_from_20190726/Bd21_col_sta_Bd14-1/revision_from_20200221/DESeq2/*.txt");
foreach my $each_file(@files){
	#print"$each_file\n";
	
	if($each_file=~/Bd_col\.\d+\.txt$|Bd_Bh\.\d+\.txt$|Bd_Bs\.\d+\.txt$|col_Bs\.\d+\.txt$|col_Bh\.\d+\.txt$|Bs_Bh\.\d+\.txt$|BhBd_BhBs\.\d+\.txt$/){
		#print"$each_file\n";
		
		$each_file=~/revision_from_20200221\/DESeq2\/(.+)_(.+)\.(\d+)\.txt$/;
		my $sp1=$1;
		my $sp2=$2;
		my $time=$3;
#		print"$sp1\t$sp2\t$time\n";
		
		my $expressed_gene_list1="";
		$expressed_gene_list1="Bd21.$time.expressed_gene_list.txt" if $sp1 eq "Bd";
		$expressed_gene_list1="col.$time.expressed_gene_list.txt" if $sp1 eq "col";
		$expressed_gene_list1="sta.$time.expressed_gene_list.txt" if $sp1 eq "Bs";
		$expressed_gene_list1="BhBd.$time.expressed_gene_list.txt" if $sp1 eq "BhBd";
		my $expressed_gene_list2="";
		$expressed_gene_list2="col.$time.expressed_gene_list.txt" if $sp2 eq "col";
		$expressed_gene_list2="sta.$time.expressed_gene_list.txt" if $sp2 eq "Bs";
		$expressed_gene_list2="Bh.$time.expressed_gene_list.txt" if $sp2 eq "Bh";
		$expressed_gene_list2="BhBs.$time.expressed_gene_list.txt" if $sp2 eq "BhBs";
#		print"$expressed_gene_list1\n$expressed_gene_list2\n";
		
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
		
		my $count_sp1_up=0;
		my $count_sp1_down=0;
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
				my $log2FoldChange=$tmp[2];
				#print"$gene\t$padj\t$log2FoldChange\n";
				
				if(exists($expressed_genes{$gene})){
					#print"$line\n";
					
					if($padj ne "NA" && $padj < 0.01){
						#print"$line\n";
						
						$count_sp1_up++ if $log2FoldChange > 0;
						$count_sp1_down++ if $log2FoldChange < 0;
						die() if $log2FoldChange == 0;
						
					}
					
				}
				
			}
			
		}
		close(C);
		
		print"$sp1\t$sp2\t$time\t$count_sp1_up\t$count_sp1_down\n";
		
	}
	
}
