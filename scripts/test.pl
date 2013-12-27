#!/usr/bin/perl

my $str='#~ msgstr "列印清单..."';

my $key = '列印';
my $value= '打印';
$str =~  s/$key/$value/g;

print "$str\n";