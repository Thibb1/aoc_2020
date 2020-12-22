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
    my $valid = 0;
    my $i = substr($a[2], $b[0] - 1, 1);
    my $j = substr($a[2], $b[1] - 1, 1);
    $valid++ if ($letter_pass eq $i);
    $valid++ if ($letter_pass eq $j);
    $nb++ if ($valid == 1);
}
print "===Answer===\n";
print "$nb\n";