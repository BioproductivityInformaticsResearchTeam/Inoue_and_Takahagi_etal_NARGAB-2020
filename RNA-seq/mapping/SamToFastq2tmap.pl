use strict;

my $trimmomatic="/raid/share/ALCA/tools/Trimmomatic-0.32/trimmomatic-0.32.jar";
my $tmap="/raid/share/ALCA/tools/tmap";
my $samtools="/raid/share/ALCA/tools/samtools-0.1.19/samtools";

my $Bdfa="/raid/share/ALCA/ref/Bdistachyon_314_v3.0.edited.fa";
my $Bsfa="/raid/share/ALCA/ref/Bs_like_genome.fa";

my $cpu=0;

my @files=glob("/raid/share/ALCA/Bd21_col_sta_Bd14-1/BGI/*R1.fastq");
foreach my $each_file(@files){
	#print"$each_file\n";
	
	$cpu++;
	my $sys="/raid/share/ALCA/Bd21_col_sta_Bd14-1/pl/SamToFastq2tmap/task.$cpu.sys.call";
	#print"$sys\n";
#	open(SYS,">>$sys");
	
	my @tmp_file=split(/\//,$each_file);
	#print"$tmp_file[6]\n";
	
	my $name="/raid/share/ALCA/Bd21_col_sta_Bd14-1/results/$tmp_file[6]";
	$name=~s/\.R1\.fastq//;
	#print"$name\n";
	
	my $fastq_1=$each_file;
	my $fastq_2=$each_file;
	$fastq_2=~s/R1\.fastq$/R2.fastq/;
	#print"$fastq1\n$fastq2\n";
	
	my $trimlog="$name".".trimlog";
	my $trimmed_fastq_1="$name"."_1.trimmed.fastq";
	my $unpaired_1="$name"."_1.unpaired.reads";
	my $trimmed_fastq_2="$name"."_2.trimmed.fastq";
	my $unpaired_2="$name"."_2.unpaired.reads";
	#print"$trimlog\n$trimmed_fastq_1\n$unpaired_1\n$trimmed_fastq_2\n$unpaired_2\n";
#	print SYS "system(\"java -jar $trimmomatic PE -threads 1 -phred33 -trimlog $trimlog $fastq_1 $fastq_2 $trimmed_fastq_1 $unpaired_1 $trimmed_fastq_2 $unpaired_2 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:36\");\n";
	
	my $grep_out="$name".".grep_out";
	#print"$grep_out\n";
#	print SYS "system(\"grep -c \\\"\\\" $fastq_1 $fastq_2 $trimmed_fastq_1 $trimmed_fastq_2 > $grep_out\");\n";
	
#	print SYS "system(\"rm $trimlog $unpaired_1 $unpaired_2\");\n";
	
	if($tmp_file[6]=~/Bd21|col/){
		#print"$name\n";
		
		my $bam="$name".".Bd.bam";
		#print"$bam\n";
#		print SYS "system(\"$tmap mapall -o 2 -i fastq -Q 2 -n 1 -f $Bdfa -r $trimmed_fastq_1 -r $trimmed_fastq_2 -s $bam -v stage1 map4\");\n";
		
#		print SYS "system(\"rm $trimmed_fastq_1 $trimmed_fastq_2\");\n";
		
		my $sort="$name".".Bd";
		#print"$sort\n";
#		print SYS "system(\"$samtools sort $bam $sort\");\n";
		
	}elsif($tmp_file[6]=~/sta/){
		#print"$name\n";
		
		my $bam="$name".".Bs.bam";
		#print"$bam\n";
#		print SYS "system(\"$tmap mapall -o 2 -i fastq -Q 2 -n 1 -f $Bsfa -r $trimmed_fastq_1 -r $trimmed_fastq_2 -s $bam -v stage1 map4\");\n";
		
#		print SYS "system(\"rm $trimmed_fastq_1 $trimmed_fastq_2\");\n";
		
		my $sort="$name".".Bs";
		#print"$sort\n";
#		print SYS "system(\"$samtools sort $bam $sort\");\n";
		
	}else{
		#print"$name\n";
		my $Bdsam="$name".".Bd.sam";
		#print"$Bdsam\n";
#		print SYS "system(\"$tmap mapall -o 0 -i fastq -Q 2 -n 1 -f $Bdfa -r $trimmed_fastq_1 -r $trimmed_fastq_2 -s $Bdsam -v stage1 map4\");\n";
		
		my $Bssam="$name".".Bs.sam";
		#print"$Bssam\n";
#		print SYS "system(\"$tmap mapall -o 0 -i fastq -Q 2 -n 1 -f $Bsfa -r $trimmed_fastq_1 -r $trimmed_fastq_2 -s $Bssam -v stage1 map4\");\n";
		
#		print SYS "system(\"rm $trimmed_fastq_1 $trimmed_fastq_2\");\n";
		
	}
	
#	close(SYS);
	
	$cpu=0 if $cpu eq 12;
	
}
