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
my $string = join('', @groups);
@groups = split('\n\n', $string);
my $i = 0;
for $string (@groups) {
    my $grp_nb = (0);
    my $ppl_nb = () = $string =~ /\n/gm;
    $ppl_nb++;
    print "======\nPl:$ppl_nb\n======\n";
    for my $c ("a" .. "z") { my $nb = () = $string =~ /(?m)^.*?$c/gm; $grp_nb++ if $nb == $ppl_nb;}
    $nb += $grp_nb;
    print "C:$grp_nb N:$nb I:$i\n\n";
    $i++;
}
print "===RES===\n$nb\n";