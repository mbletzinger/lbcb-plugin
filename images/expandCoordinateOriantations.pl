#!/usr/bin/perl -w
use strict;

our @hands = ('RH', 'LH');
our @zOrient = ('ZDown', 'ZUp','ZLeft', 'ZRight', 'ZFront','ZBack');
our @xOrient = ('XLeft', 'XRight','XDown', 'XUp','XFront','XBack');
our $count = 0;
open OUT, ">names.txt";

for my $h(@hands) {
  for my $z (@zOrient) {
    for my $x (@xOrient) {
      my ($zo) = $z =~ m!Z(\w+)!;
      my ($xo) = $x =~ m!X(\w+)!;
      next if $zo eq $xo;
      next if $zo eq 'Down' and $xo eq 'Up';
      next if $zo eq 'Up' and $xo eq 'Down';
      next if $zo eq 'Front' and $xo eq 'Back';
      next if $zo eq 'Back' and $xo eq 'Front';
      next if $zo eq 'Left' and $xo eq 'Right';
      next if $zo eq 'Right' and $xo eq 'Left';
      $count ++;
      print "$count  $h : $z : $x\n";
      my $n = $h . '_' . $z . '_' . $x;
      print OUT "$n\t$n.png\n";
    }
  }
}
close OUT;
