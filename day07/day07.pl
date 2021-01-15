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
$string =~ s/ contain /\n/gm;
$string =~ s/\d |\.| bags| bag//gm;
my @g_bag = split(/\n/, $string);
my %bags = @g_bag;


sub check_color {
    my $color = $_[0];
    return 0 if $color =~ m/no other/;
    return 1 if $color =~ m/shiny gold/;
    my @bag_content = split(/, /, $bags{$color});
    foreach my $subbag (@bag_content) {
        return 1 if check_color($subbag);
    }
}


foreach my $bag (sort keys %bags) {
    my @bag_content = split(/, /, $bags{$bag});
    foreach my $subbag (@bag_content) {
        (do $nb++), (do last) if check_color($subbag);
    }
}



$string = join("", @groups);
$string =~ s/ contain /\n/gm;
$string =~ s/\.| bags| bag//gm;
@g_bag = split(/\n/, $string);
%bags = @g_bag;
my $yellow_nb = 0;

sub count_bags {
    my $color = $_[0];
    my $nb = $color;
    $nb =~ s/\D//gm;
    $color =~ s/\d //gm;
    return 0 if $color =~ m/no other/;
    $yellow_nb++;
    my @bag_yellow = split(/, /, $bags{$color});
    if ($nb =~ m/\d/gm) { for (my $x = 0; $x < $nb; $x++) {
        foreach my $subbag (@bag_yellow) {
            count_bags($subbag);
        }
    } } else { foreach my $subbag (@bag_yellow) {
            count_bags($subbag);
        } }
}

count_bags("shiny gold");
print "===RES===\nP1:$nb P2:$yellow_nb\n";