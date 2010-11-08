#!/usr/bin/perl -w
use strict;

our @hands = ('RH', 'LH');
our @zOrient = ('Z_Down', 'Z_Up','Z_Left', 'Z_Right', 'Z_Front','Z_Back');
our @xOrient = ('X_Left', 'X_Right','X_Down', 'X_Up','X_Front','X_Back');
our $count = 0;
for my $h(@hands) {
  for my $z (@zOrient) {
    for my $x (@xOrient) {
      my ($zo) = $z =~ m!Z_(\w+)!;
      my ($xo) = $x =~ m!X_(\w+)!;
      next if $zo eq $xo;
      next if $zo eq 'Down' and $xo eq 'Up';
      next if $zo eq 'Up' and $xo eq 'Down';
      next if $zo eq 'Front' and $xo eq 'Back';
      next if $zo eq 'Back' and $xo eq 'Front';
      next if $zo eq 'Left' and $xo eq 'Right';
      next if $zo eq 'Right' and $xo eq 'Left';
      $count ++;
      print "$count  $h : $z : $x\n";
      
    }
  }
}
