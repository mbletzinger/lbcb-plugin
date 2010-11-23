#!/usr/bin/perl -w
use strict;
my $filename = shift;
open(inF,$filename);
open(outF, ">" . $filename . ".strpd");
for my $l (<inF>) {
  $l =~ s!\r\n!\n!g;
  $l =~ s!\r!\n!g;
  print outF $l;
}
