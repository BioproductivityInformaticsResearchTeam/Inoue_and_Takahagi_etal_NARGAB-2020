use strict;

my $time=$ARGV[0];
my $RPM_matrix_for_DESeq2="RPM_matrix_for_DESeq2_$time.txt";

my $Ancestor_expressed_genes="Ancestor.$time.expressed_genes.txt";
my $Homoeolog_expressed_genes="Homoeolog.$time.expressed_genes.txt";
open(ANC,">>$Ancestor_expressed_genes");
open(HOM,">>$Homoeolog_expressed_genes");
my %expressed_genes=();
open(A,"$RPM_matrix_for_DESeq2");
while(my $line=<A>){
	$line=~s/\r//;
	chomp($line);
	
	my @tmp=split("\t",$line);
	
	if($line=~/^Gene/){
		#print"$line\n";
		
		print"$tmp[1]\t$tmp[2]\t$tmp[3]\n";
		print"$tmp[4]\t$tmp[5]\t$tmp[6]\n";
		print"$tmp[7]\t$tmp[8]\t$tmp[9]\n";
		print"$tmp[10]\t$tmp[11]\t$tmp[12]\n";
		
	}else{
		
		my $Ancestor="";
		$Ancestor="expressed" if $tmp[1] >= 1 && $tmp[2] >= 1 && $tmp[3] >= 1;
		$Ancestor="expressed" if $tmp[4] >= 1 && $tmp[5] >= 1 && $tmp[6] >= 1;
		print ANC "$tmp[0]\n" if $Ancestor eq "expressed";
		my $Homoeolog="";
		$Homoeolog="expressed" if $tmp[7] >= 1 && $tmp[8] >= 1 && $tmp[9] >= 1;
		$Homoeolog="expressed" if $tmp[10] >= 1 && $tmp[11] >= 1 && $tmp[12] >= 1;
		print HOM "$tmp[0]\n" if $Homoeolog eq "expressed";
		$expressed_genes{$tmp[0]}="" if $Ancestor eq "expressed" && $Homoeolog eq "expressed";
		
	}
	
}
close(A);
my $num_expressed_genes=scalar(keys(%expressed_genes));
print"$num_expressed_genes\n";
close(ANC);
close(HOM);

my %RPM=();
open(B,"$RPM_matrix_for_DESeq2");
while(my $line=<B>){
	$line=~s/\r//;
	chomp($line);
	
	my @tmp=split("\t",$line);
	
	if($line=~/^Gene/){
		#print"$line\n";
		
		#print"$tmp[1]\t$tmp[2]\t$tmp[3]\n";
		#print"$tmp[4]\t$tmp[5]\t$tmp[6]\n";
		#print"$tmp[7]\t$tmp[8]\t$tmp[9]\n";
		#print"$tmp[10]\t$tmp[11]\t$tmp[12]\n";
		
	}else{
		#print"$line\n";
		
		if(exists($expressed_genes{$tmp[0]})){
			
			$RPM{$tmp[0]}[0]=($tmp[1]+$tmp[2]+$tmp[3])/3;   # Bd21
			$RPM{$tmp[0]}[1]=($tmp[4]+$tmp[5]+$tmp[6])/3;   # sta
			$RPM{$tmp[0]}[2]=($tmp[7]+$tmp[8]+$tmp[9])/3;   # BhBd
			$RPM{$tmp[0]}[3]=($tmp[10]+$tmp[11]+$tmp[12])/3;   # BhBs
			
		}
		
	}
	
}
close(B);
my $num_RPM=scalar(keys(%RPM));
print"$num_RPM\n";

my $BdvsBs="Bd_Bs.$time.txt";
my %BdvsBs=();
open(C,"$BdvsBs");
while(my $line=<C>){
	$line=~s/\r//;
	chomp($line);
	
	if($line=~/\"baseMean\"/){
		#print"$line\n";
		
	}else{
		#print"$line\n";
		
		my @tmp=split(" ",$line);
		my $gene=$tmp[0];
		$gene=~s/\"//g;
		my $log2FoldChange=$tmp[2];
		$log2FoldChange=~s/\"//g;
		my $padj=$tmp[6];
		$padj=~s/\"//g;
		#print"$gene\t$log2FoldChange\t$padj\n";
		
		if(exists($expressed_genes{$gene})){
			
			#if($log2FoldChange >= 1 or $log2FoldChange <= -1){
				
				if($padj <= 0.01 && $padj ne "NA"){
					
					$BdvsBs{$gene}="Bd" if $RPM{$gene}[0] > $RPM{$gene}[1];
					$BdvsBs{$gene}="Bs" if $RPM{$gene}[0] < $RPM{$gene}[1];
					
				}
				
			#}
			
		}
		
	}
	
}
close(C);
my $num_BdvsBs=scalar(keys(%BdvsBs));
print"$num_BdvsBs\n";

my $BhBdvsBhBs="BhBd_BhBs.$time.txt";
my %BhBdvsBhBs=();
open(D,"$BhBdvsBhBs");
while(my $line=<D>){
	$line=~s/\r//;
	chomp($line);
	
	if($line=~/\"baseMean\"/){
		#print"$line\n";
		
	}else{
		#print"$line\n";
		
		my @tmp=split(" ",$line);
		my $gene=$tmp[0];
		$gene=~s/\"//g;
		my $log2FoldChange=$tmp[2];
		$log2FoldChange=~s/\"//g;
		my $padj=$tmp[6];
		$padj=~s/\"//g;
		#print"$gene\t$log2FoldChange\t$padj\n";
		
		if(exists($expressed_genes{$gene})){
			
			#if($log2FoldChange >= 1 or $log2FoldChange <= -1){
				
				if($padj <= 0.01 && $padj ne "NA"){
					
					$BhBdvsBhBs{$gene}="BhBd" if $RPM{$gene}[2] > $RPM{$gene}[3];
					$BhBdvsBhBs{$gene}="BhBs" if $RPM{$gene}[2] < $RPM{$gene}[3];
					
				}
				
			#}
			
		}
		
	}
	
}
close(D);
my $num_BhBdvsBhBs=scalar(keys(%BhBdvsBhBs));
print"$num_BhBdvsBhBs\n";

my @sorted=sort{(split "Bradi|g",$a)[1]<=>(split "Bradi|g",$b)[1] or (split "Bradi|g",$a)[2]<=>(split "Bradi|g",$b)[2]}keys(%expressed_genes);
foreach my $each_sorted(@sorted){
	#print"$each_sorted\n";
	
	my $gene=$each_sorted;
	$gene=~s/\.v3\.1$//;
	#print"$gene\n";
	
	my $RPM="$gene\t$RPM{$each_sorted}[0]\tBd\n$gene\t$RPM{$each_sorted}[1]\tBs\n$gene\t$RPM{$each_sorted}[2]\tBhBd\n$gene\t$RPM{$each_sorted}[3]\tBhBs\n";
	#print"$RPM";
	
	if(exists($BhBdvsBhBs{$each_sorted})){
		
		if($BhBdvsBhBs{$each_sorted} eq "BhBd"){
			
			if(exists($BdvsBs{$each_sorted})){
				
				if($BdvsBs{$each_sorted} eq "Bd"){
					
					open(P5,">>P5.$time.genes.txt");
					print P5 "$gene\n";
					close(P5);
					
					open(P5RPM,">>P5.$time.genes.RPM.txt");
					print P5RPM "$RPM";
					close(P5RPM);
					
				}else{
					
					open(P6,">>P6.$time.genes.txt");
					print P6 "$gene\n";
					close(P6);
					
					open(P6RPM,">>P6.$time.genes.RPM.txt");
					print P6RPM "$RPM";
					close(P6RPM);
					
				}
				
			}else{
				
				open(P4,">>P4.$time.genes.txt");
				print P4 "$gene\n";
				close(P4);
				
				open(P4RPM,">>P4.$time.genes.RPM.txt");
				print P4RPM "$RPM";
				close(P4RPM);
				
			}
			
		}else{
			
			if(exists($BdvsBs{$each_sorted})){
				
				if($BdvsBs{$each_sorted} eq "Bd"){
					
					open(P8,">>P8.$time.genes.txt");
					print P8 "$gene\n";
					close(P8);
					
					open(P8RPM,">>P8.$time.genes.RPM.txt");
					print P8RPM "$RPM";
					close(P8RPM);
					
				}else{
					
					open(P9,">>P9.$time.genes.txt");
					print P9 "$gene\n";
					close(P9);
					
					open(P9RPM,">>P9.$time.genes.RPM.txt");
					print P9RPM "$RPM";
					close(P9RPM);
					
				}
				
			}else{
				
				open(P7,">>P7.$time.genes.txt");
				print P7 "$gene\n";
				close(P7);
				
				open(P7RPM,">>P7.$time.genes.RPM.txt");
				print P7RPM "$RPM";
				close(P7RPM);
				
			}
			
		}
		
	}else{
		
		if(exists($BdvsBs{$each_sorted})){
			
			if($BdvsBs{$each_sorted} eq "Bd"){
				
				open(P2,">>P2.$time.genes.txt");
				print P2 "$gene\n";
				close(P2);
				
				open(P2RPM,">>P2.$time.genes.RPM.txt");
				print P2RPM "$RPM";
				close(P2RPM);
				
			}else{
				
				open(P3,">>P3.$time.genes.txt");
				print P3 "$gene\n";
				close(P3);
				
				open(P3RPM,">>P3.$time.genes.RPM.txt");
				print P3RPM "$RPM";
				close(P3RPM);
				
			}
			
		}else{
			
			open(P1,">>P1.$time.genes.txt");
			print P1 "$gene\n";
			close(P1);
			
			open(P1RPM,">>P1.$time.genes.RPM.txt");
			print P1RPM "$RPM";
			close(P1RPM);
			
		}
		
	}
	
}
