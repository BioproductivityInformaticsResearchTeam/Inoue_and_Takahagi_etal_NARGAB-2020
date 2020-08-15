use strict;

my $samtools="/mnt/hdd2/zenbu.raid.share.backup/share/ALCA/tools/samtools-0.1.19/samtools";

my $cpu=0;

my @files=glob("/mnt/hdd2/zenbu.raid.share.backup/share/ALCA/Bd21_col_sta_Bd14-1/results/*Bd14-1*BhB*.sam");
foreach my $each_file(@files){
	#print"$each_file\n";
	
	$cpu++;
	my $sys="/mnt/hdd2/zenbu.raid.share.backup/share/ALCA/Bd21_col_sta_Bd14-1/pl/samtoolsview_for_Bd14-1_new/task.$cpu.sys.call";
	#print"$sys\n";
#	open(SYS,">>$sys");
	
	my $bam=$each_file;
	$bam=~s/sam$/bam/;
	#print"$bam\n";
#	print SYS "system(\"$samtools view -bS $each_file > $bam\");\n";
	
	my $sort=$bam;
	$sort=~s/\.bam$//;
	#print"$sort\n";
#	print SYS "system(\"$samtools sort $bam $sort\");\n";
	
#	print SYS "system(\"rm $each_file\");\n";
	
#	close(SYS);
	
	$cpu=0 if $cpu eq 2;
	
}
