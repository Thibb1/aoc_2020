#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Data::Dumper;

(do print "$0: provide file name as argument\n"), (do exit 84) if ($#ARGV + 1 < 1);

my ($filename) = $ARGV[0];

open(FH, '<', $filename) or die $!;
my (@users, $res);
$res = 0;
while (<FH>) { push @users, $_; }
my $string = join('', @users);
@users = split('\n\n', $string);

sub check_hgt {
    my $m = $_[0];
    if ($m =~ s/^(\d{2})in$/$1/ && $m >= 59 && $m <= 76) { return 1; }
    if ($m =~ s/^(\d{3})cm$/$1/ && $m >= 150 && $m <= 193) { return 1; }
    return 0;
}

for my $i (@users) {
    $i =~ s/\n/ /g;
    my @y = split(' ', $i);
    $i = join(':', @y);
    @y = split(':', $i);
    my %ID = @y;
    $res++ if (exists($ID{byr}) && $ID{byr} >= 1920 && $ID{byr} <= 2002 &&
        exists($ID{iyr}) && $ID{iyr} >= 2010 && $ID{iyr} <= 2020 &&
        exists($ID{eyr}) && $ID{eyr} >= 2020 && $ID{eyr} <= 2030 &&
        exists($ID{hgt}) && check_hgt($ID{hgt}) == 1 &&
        exists($ID{hcl}) && $ID{hcl} =~ /^#([a-f0-9]{6})$/ &&
        exists($ID{ecl}) && $ID{ecl} =~ m/\b(amb|blu|brn|gry|grn|hzl|oth)\b/ &&
        exists($ID{pid}) && $ID{pid} =~ /^([0-9]{9})$/);
    print "Nb:$res    \t| User = $i\n";
}