#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

(do print "$0: provide file name as argument\n"), (do exit 84) if ($#ARGV + 1 < 1);

my $filename = $ARGV[0];

my @numbers;
my @answers;

open(FH, '<', $filename) or die $!;

while (<FH>) { push @numbers, $_; }
for my $i (@numbers) { for my $j (@numbers) { for my $k (@numbers) { push @answers, $i, $j, $k if ($i + $j + $k == 2020); } } }
print "===Matching===\n";
print Dumper \@answers;
printf "Answer = %d\n", $answers[0] * $answers[1] * $answers[2];