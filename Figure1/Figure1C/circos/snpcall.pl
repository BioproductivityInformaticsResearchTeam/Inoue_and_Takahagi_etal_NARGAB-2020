use strict;

my $mpile="/mnt/hdd2/inoue/tools/samtools-0.1.19/samtools mpileup";
my $bcftools="/mnt/hdd2/inoue/tools/samtools-0.1.19/bcftools/bcftools";
my $bam="/mnt/hdd2/inoue/ALCA/genome-seq/mapping/4xBd21_genome.sort.rmdup.f2.bam";
my $ref="/mnt/hdd2/inoue/ALCA/genome-seq/index/Bdistachyon_314_v3.0.fa";

#for circos
system("$mpile -uf $ref $bam > 4xBd21_genome.sort.rmdup.f2.pileup");
system("cut -f1,2,4 4xBd21_genome.sort.rmdup.f2.pileup > 4xBd21_genome.sort.rmdup.f2.coverage.txt");

#for SNP
system("$mpile -uf $ref $bam | $bcftools view -cg - > 4xBd21_genome.sort.rmdup.f2.uf.vcf");

