#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Data::Dumper;

(do print "$0: provide file name as argument\n"), (do exit 84) if ($#ARGV + 1 < 1);

my $filename = $ARGV[0];

my @strings;
my $nb = 0;

open(FH, '<', $filename) or die $!;

while (<FH>) { push @strings, $_; }
for my $i (@strings) {
    my @a = split(' ', $i);
    my @b = split('-', $a[0]);
    my $letter_pass = substr($a[1], 0, 1);
    my $letter_count = 0;
    foreach my $char (split ('', $a[2])) { $letter_count++ if ($char eq $letter_pass); }
    $nb++ if ($letter_count >= $b[0] && $letter_count <= $b[1]);
}
print "===Answer===\n";
print "$nb\n";