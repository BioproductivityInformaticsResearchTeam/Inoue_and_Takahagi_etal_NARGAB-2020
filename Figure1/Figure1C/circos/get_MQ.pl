use strict;

open(A,"4xBd21_genome.sort.rmdup.f2.uf.vcf");
while(my $line=<A>){
	
	if($line!~/^#/){

		$line=~s/\r//;
		chomp $line;
		my @tmp=split(/\t/,$line);
		
		my $chr=$tmp[0];
		my $pos=$tmp[1];
		my $ref=$tmp[3];
		my $alt=$tmp[4];
		
		my $ref_len=length($ref);
		#print "$num\n";
		
		my $dp=$tmp[7];
		$dp=~s/;\S+//;
		$dp=~s/^DP=//;

		if($tmp[7]!~/^INDEL/){

			my $dp=$tmp[7];
			$dp=~s/;\S+//;
			$dp=~s/^DP=//;
			my $mq=$tmp[7];
			$mq=~s/\S+MQ=//;
			#print "$mq\n";
			$mq=~s/;\S+//;
			

			if( ($dp >= 3) and ($ref_len == 1 ) and ($alt eq ".") ){
				
				my $for_circos_pos=$pos-1;
				print "$chr\t$for_circos_pos\t$for_circos_pos\t$mq\n";
			
			}
	
		}else{
			my $for_circos_pos=$pos-1;
			my $info=$tmp[7];
			$info=~s/;\S+//;
			#print "$chr\t$for_circos_pos\t$for_circos_pos\t1\t$info\n";

		}

	}

}
close(A);

