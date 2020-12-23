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
my (@users, $bid, @ids);
$bid = 0;
while (<FH>) {
    my ($user, $nid) = ($_, 0);
    $user =~ s/\n/ /g;
    my @row = (0, 127);
    my @col = (0, 7);
    foreach my $char (split //, $user) {
        $row[1] -= ceil(($row[1] - $row[0]) / 2) if $char =~ /^F$/;
        $row[0] += ceil(($row[1] - $row[0]) / 2) if $char =~ /^B$/;
        $col[1] -= ceil(($col[1] - $col[0]) / 2) if $char =~ /^L$/;
        $col[0] += ceil(($col[1] - $col[0]) / 2) if $char =~ /^R$/;
    }
    $nid = $row[0] * 8 + $col[0];
    print "$user\tBID=>$bid NID=>$nid\t($row[0])\t($col[0])\n";
    $bid = $nid if $nid > $bid;
    push(@ids, $nid);
}
@ids = sort {$a <=> $b} @ids;
my $set = Set::IntSpan->new(@ids);
print "===RES===\n$bid && $set\n";
