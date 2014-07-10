#!/usr/bin/perl
use utf8;
use Encode::HanConvert ;
use Data::Dumper;

=cut 

my $t_str="斷線";
my $simp = trad_to_simp($t_str);
my $output = utf8::encode($simp);
print "$simp\n";

=cut 

sub words_map {
    my $map_file  = shift;
    die "Can't find map file" unless (-f $map_file);
    my $map = {};
    open (my $fh, "<:encoding(UTF-8)",$map_file) or die "$!";
    while (my $line = <$fh>) {
        next if ($line =~/^\s*$/);
        chomp $line;
        my ($key, $value)= split(/=>/,$line,2);
        $map->{$key} = $value;
        
    } 
     return $map;
}

my $words_map = &words_map("map.txt");
print Dumper($words_map);
my $file= "messages_zh.po";
open (my $fh_in ,"<:encoding(UTF-8)", $file) or die "$!";
open (my $fh_out,">:encoding(UTF-8)","../messages_zh_CN.po");

while (my $line = <$fh_in>){
    if ($line =~/^\s*$/){
     print $fh_out  "$line" ;
     next;
    }
   my $simp = trad_to_simp($line); 
   next unless ($simp);
  # my $output = utf8::encode($simp) ;
   
   # fine the matched words and translate to simple chinese
   for my $key (keys %$words_map) {
       my $value = $words_map->{$key};
     
       $simp =~ s/$key/$value/g;
       
   }
   
   print $fh_out  "$simp";
}
