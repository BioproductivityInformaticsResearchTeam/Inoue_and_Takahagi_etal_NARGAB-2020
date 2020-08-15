use strict;
use Data::Dumper;

my @Bd=(75071544,59130574,59640144,48594893,28630135); #-1 0start
my @genome=();
my %genome=&get_genome(@Bd);

#print Dumper %genome;

sub get_genome{
	my %re_hash=();
	my $count=0;
	foreach my $each(@_){	#@_=@Bd
		$count++;
		my $Bd="Bd".$count; #for Aja
		#my $Bd="Aan";	#for Anguilla.anguilla
		
		for(my $rep=0;$rep<=$each;$rep+=100000){	#100kb
		#for(my $rep=0;$rep<=$each;$rep+=1000000){	#1mb
			my $end=$rep+99999;
			#my $end=$rep+999999;
			my $key="";
			if($end <= $each){
				$key="$Bd\t$rep\t$end";
			}elsif($end > $each){
				$key="$Bd\t$rep\t$end";
			}else{
				#print"NO\n";
			}
			push(@genome,$key);
			$re_hash{$key}=0;
		}
	}
	return %re_hash;
}

my $num=scalar(@genome);
my $num_key=scalar(keys(%genome));

#print"@genome\n";
#die();

#my $count_gene=0;
my $chr="Bd1";
my $start=0;
my $end=99999;
#my $end=999999;

my $key="";
my $genome_count=0;

open(A,"../get_same_pos.pl.stdout");

while(my $line=<A>){
	$line=~s/\r//;
	chomp $line;
	my @tmp=split(/\t/,$line);
	my $pos=$tmp[1];

	if($chr ne $tmp[0]){
		
		$genome_count++;
		$chr=$tmp[0];
		$start=0;
		#$end=999999; #1mb
		$end=99999; #100kb
	}

	if(($pos >= $start ) and ($pos <= $end)){

		$key="$chr\t$start\t$end";

	}else{

		while($pos > $end){
	
			$start+=100000;
			$end+=100000;

			#$start+=1000000;
			#$end+=1000000;
		}
		if($end > $Bd[$genome_count]){
			
			$end=$Bd[$genome_count];
		}
		$key="$chr\t$start\t$end";

	}
	#print "$line\t$key\n";

	if(($pos >= $start ) and ($pos <= $end)){
	
		$genome{$key}++;
	}else{

		die();
	}

	#print "$Bd[$genome_count]\n";

}
close(A);


#print Dumper %genome;
#die();
 
foreach my $each_genome(@genome){
	
	my @tmp=split(/\t/,$each_genome);
	my $diff=$tmp[2]-$tmp[1]+1;
	my $average=$genome{$each_genome}/$diff;
        print "$each_genome\t$average\n";
}

close(OUT);
=cut
