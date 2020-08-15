use Data::Dumper;

my $file="Bdistachyon.edited.annot";
my $evi="ND";

my %hash=();

open(FILE,$file);
print "GO_id	Evidence	Gene_id\n";
while(<FILE>){
	s/\r//;
	chomp;
	my @tmp=split(/\t/,$_);
	my $gene=$tmp[0];
	my @goid=split(",",$tmp[1]);
	foreach my $each_goid(@goid){
		print "$each_goid	$evi	$gene\n";
	}
}
close(FILE);	

