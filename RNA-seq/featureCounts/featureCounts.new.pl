use strict;

my $featureCounts="/mnt/hdd2/zenbu.raid.share.backup/share/ALCA/tools/subread-1.4.6-source/bin/featureCounts";

my $gtf="/mnt/hdd2/zenbu.raid.share.backup/share/ALCA/ref/Bdistachyon_314_v3.1.gene_exons.edited.gtf";

my @files=glob("/mnt/hdd2/zenbu.raid.share.backup/share/ALCA/Bd21_col_sta_Bd14-1/results/*BhB*.bam");
foreach my $each_file(@files){
	#print"$each_file\n";
	
	my $out=$each_file;
	$out=~s/bam$/featureCounts.out/;
	#print"$out\n";
	
	#system("$featureCounts -t exon -g gene_id -a $gtf -o $out $each_file");
	
}
