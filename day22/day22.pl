#!/usr/bin/perl
use warnings;
use strict;
use POSIX;
use diagnostics;
use Data::Dumper;
use Set::IntSpan;

(do print "$0: provide file name as argument\n"), (do exit 84) if ($#ARGV + 1 < 1);

my ($filename) = $ARGV[0];

open(FH, '<', $filename) or die $!;
my ($nb, @groups) = (0);
while (<FH>) { push @groups, $_; }

my $string = join("", @groups);
$string =~ s/Player 1:\n|Player 2:\n//mg;
@groups = split("\n\n", $string);
my @player1= split("\n", $groups[0]);
my @player2= split("\n", $groups[1]);

while (@player1 && @player2) {
    my ($c1, $c2) = (shift(@player1), shift(@player2));
    if ($c1 > $c2) {push @player1, $c1, $c2;} else {push @player2, $c2, $c1;}
}
if (@player1) {my $res = 0; for (my $i = 1; @player1; $i++) { my $x = pop @player1; $res += $x * $i;} print "$res \n"; }
if (@player2) {my $res = 0; for (my $i = 1; @player2; $i++) { my $x = pop @player2; $res += $x * $i;} print "$res \n"; }