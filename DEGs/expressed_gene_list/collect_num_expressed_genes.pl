use strict;

my %expressed_genes=();
my @files=glob("/home/takahagi/ALCA_from_20190726/Bd21_col_sta_Bd14-1/DESeq2_from_20190813/*.expressed_gene_list.txt");
foreach my $each_file(@files){
	#print"$each_file\n";
	
	$each_file=~/DESeq2_from_20190813\/(.+)\.(\d+)\.expressed_gene_list\.txt$/;
	my $sp=$1;
	my $time=$2;
	my $sp_time="$sp.$time";
	
	my $num=`grep -c \"\" $each_file`;
	print"$sp_time\t$num";
	
	open(A,"$each_file");
	while(my $line=<A>){
		$line=~s/\r//;
		chomp($line);
		$expressed_genes{$sp}{$line}="";
	}
	close(A);
	
	if($time == 6){
		
		my $num_all_expressed_genes=scalar(keys($expressed_genes{$sp}));
		print"$sp.all\t$num_all_expressed_genes\n";
		
	}
	
}
