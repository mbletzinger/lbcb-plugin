#!/usr/bin/perl -w

use IO::Socket::INET;
use File::Spec;
use Cwd;
use strict;

my ($host, $port) = ("localhost","6342");
#my ($host, $port) = ("192.168.1.101","5057");
my $cwd =cwd();
my @dirs = File::Spec->splitdir($cwd);
my $dropped = pop @dirs;
my $pwd = File::Spec->catdir(@dirs);


my $socket = new IO::Socket::INET(
		PeerAddr => $host,
		PeerPort => $port,
		Proto     => 'tcp',
	);

die "Connection to $host:$port failed because $!" unless defined $socket;

sendCommand("open-session\tdummySession");
receiveCommand();

sendCommand("set-parameter\tdummySetParam\tnstep\t0");
receiveCommand();

my $increment = "0.5";
for my $i (1..500) {
	my ($sec,$min,$hour,$mday,$month,$year,$wday,$yday,$isdst)=localtime(time);
	$year += 1900;
	$month++;
	print "$month/$mday/$year";
	sendCommand("propose\ttrans$year$month$mday$hour$min$sec.320\tMDL-00-01:LBCB 1\tx\tdisplacement\t$increment\ty\tdisplacement\t0.0");
	receiveCommand();
	sendCommand("propose\ttrans$year$month$mday$hour$min$sec.320\tMDL-00-01:LBCB 2\tx\tdisplacement\t$increment\ty\tdisplacement\t0.0");
	receiveCommand();
	sendCommand("execute\ttrans$year$month$mday$hour$min$sec.320");
	receiveCommand();
	sendCommand("get-control-point\tdummy\tMDL-00-01:LBCB 1");
	receiveCommand();
	sendCommand("get-control-point\tdummy\tMDL-00-01:LBCB 2");
	receiveCommand();
	sendCommand("get-control-point\tdummy\tMDL-00-01:External Sensors");
	receiveCommand();
	$increment = $increment eq "0.5" ? "-0.5" : "0.5";
	sleep 3;
}

sendCommand("close-session	dummy");
receiveCommand();

close $socket;

sub sendCommand {
	my ($cmd) = @_;
	print "Sending [$cmd]";
	print $socket $cmd, "\n";

}

sub receiveCommand {
	my $result = <$socket>;
	chomp $result;
	print "Received [$result]\n";
}
