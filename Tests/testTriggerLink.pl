#!/usr/bin/perl -w

use IO::Socket::INET;
use File::Spec;
use Cwd;
use strict;

my ($host, $port) = ("127.0.0.1",6446);
my $cwd =cwd();
my @dirs = File::Spec->splitdir($cwd);
my $dropped = pop @dirs;
my $pwd = File::Spec->catdir(@dirs);
my $sysname = shift;

die "System Description missing.\n\t./testTriggerLink.pl \"SystemDescription\"\n" 
	unless defined $sysname;


my $socket = new IO::Socket::INET(
	Proto     => "tcp",
	PeerAddr => $host,
	PeerPort => $port,
                                  );

die "Connection to $host:$port failed because $!" unless defined $socket;

my $running = 1;
while ($running) {
  my($keyword, $trans, $mdl) = receiveCommand();
	unless (defined $keyword) {
		close $socket;
		die "Aborting Connection\n";
	}
  if ($keyword eq 'open-session') {
    sendResponse("OK 0\t[$sysname] Open Session Succeeded");
    next;
  }
  if ($keyword eq 'trigger') {
    sleep 10;
    sendResponse("OK\t0\t$trans\t[$sysname] done");
    next;
  }
  if ($keyword eq 'close-session') {
    $running = 0;
    next;
  }
	print " Could not understand [ $keyword	$trans	$mdl]\n";
}

close $socket;

sub sendResponse {
	my ($cmd) = @_;
	print "Sending [$cmd]\n";
	print $socket $cmd, "\015\012";

}

sub receiveCommand {
	my $result = <$socket>;
	chomp $result;
	print "Received [$result]\n";
        my ($keyword) = $result =~ m!([^\t]+)!;
        my ($trans) = $result =~ m!(trans[^\t]+)!;
        my ($mdl) = $result =~ m!(MDL-[^\t]+)!;
        print "[$keyword|" . (defined $trans ? $trans : "undef") . "|" 
          .(defined $mdl ? $mdl : "undef") . "]\n";
        return ($keyword, $trans, $mdl);
}
