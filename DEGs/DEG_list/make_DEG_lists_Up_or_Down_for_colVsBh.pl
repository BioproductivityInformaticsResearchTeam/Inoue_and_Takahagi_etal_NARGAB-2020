use strict;

my @files=glob("/home/takahagi/ALCA_from_20190726/Bd21_col_sta_Bd14-1/revision_from_20200221/DESeq2/*.txt");
foreach my $each_file(@files){
	#print"$each_file\n";
	
	if($each_file=~/col_Bh\.\d+\.txt$/){
		#print"$each_file\n";
		
		$each_file=~/revision_from_20200221\/DESeq2\/(.+)_(.+)\.(\d+)\.txt$/;
		my $sp1=$1;
		my $sp2=$2;
		my $time=$3;
		print"$sp1\t$sp2\t$time\n";
		
		my $expressed_gene_list1="";
		$expressed_gene_list1="col.$time.expressed_gene_list.txt" if $sp1 eq "col";
		#$expressed_gene_list1="BhBd.$time.expressed_gene_list.txt" if $sp1 eq "BhBd";
		my $expressed_gene_list2="";
		$expressed_gene_list2="Bh.$time.expressed_gene_list.txt" if $sp2 eq "Bh";
		#$expressed_gene_list2="BhBs.$time.expressed_gene_list.txt" if $sp2 eq "BhBs";
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
		
		my $out_up="./$sp1"."_$sp2.$time.DEG_list.up_$sp2.txt";
		my $out_down="./$sp1"."_$sp2.$time.DEG_list.down_$sp2.txt";
		print"$out_up\t$out_down\n";
		
		open(UP,"+>$out_up");
		open(DOWN,"+>$out_down");
		
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
						
						print UP "$gene\n" if $log2FoldChange < 0;
						print DOWN "$gene\n" if $log2FoldChange > 0;
						
					}
					
				}
				
			}
			
		}
		close(C);
		
		close(UP);
		close(DOWN);
		
	}
	
}
