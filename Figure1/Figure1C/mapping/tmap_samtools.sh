/mnt/hdd2/inoue/tools/tmap mapall -o 2 -i fastq -Q 2 -n 20 -f /mnt/hdd2/inoue/ALCA/genome-seq/index/Bdistachyon_314_v3.0.fa -r /mnt/hdd2/inoue/ALCA/genome-seq/fastq/4xBd21_trimmed_R1.fastq -r /mnt/hdd2/inoue/ALCA/genome-seq/fastq/4xBd21_trimmed_R2.fastq -s 4xBd21_genome.bam -o 2 stage1 map4
samtools sort -@ 20 4xBd21_genome.bam 4xBd21_genome.sort
samtools rmdup -S 4xBd21_genome.sort.bam 4xBd21_genome.sort.rmdup.bam
samtools view -bh -f 2 4xBd21_genome.sort.rmdup.bam -@ 20 > 4xBd21_genome.sort.rmdup.f2.bam
samtools index 4xBd21_genome.sort.rmdup.f2.bam

