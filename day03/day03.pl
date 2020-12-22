#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Data::Dumper;

(do print "$0: provide file name, x and y as argument\n"), (do exit 84) if ($#ARGV + 1 < 3);
my ($filename, $stepx, $stepy) = ($ARGV[0], $ARGV[1], $ARGV[2]);
open(FH, '<', $filename) or die $!;
my @map;
while (<FH>) { push @map, $_; }
my ($res, $x, $y) = (0, length($map[0]) - 1, scalar @map);
for (my ($d, $c) = (0) x 2; $d < $y; $d += $stepy) {
    my $char = substr($map[$d], $c, 1);
    if ($char eq '#') { substr($map[$d], $c, 1) = "X"; } else { substr($map[$d], $c, 1) = "O"; }
    printf "|$c=>$char|$res   \t%s", $map[$d];
    $res++ if $char eq '#';
    $c = ($c + $stepx) % $x;
}
print "x:$x y:$y res:$res\n";

