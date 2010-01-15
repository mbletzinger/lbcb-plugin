#!/usr/bin/perl -w

use IO::Socket::INET;
use File::Spec;
use Cwd;
use strict;

#my ( $host, $port ) = ( "localhost", "6445" );

my ($host, $port) = ("cee-neesstit1.cee.illinois.edu","6445");
my $cwd     = cwd();
my @dirs    = File::Spec->splitdir($cwd);
my $dropped = pop @dirs;
my $pwd     = File::Spec->catdir(@dirs);

my $socket = new IO::Socket::INET(
	PeerAddr => $host,
	PeerPort => $port,
	Proto    => 'tcp',
);

die "Connection to $host:$port failed because $!" unless defined $socket;

sendCommand("open-session\tdummySession");
receiveCommand();

sendCommand("set-parameter\tdummySetParam\tnstep\t0");
receiveCommand();

my $increment = "0.5";
for my $i ( 1 .. 5 ) {
	my ( $sec, $min, $hour, $mday, $month, $year, $wday, $yday, $isdst ) =
	  localtime(time);
	$year += 1900;
	$month++;
	print "$month/$mday/$year";
	sendCommand( "propose	trans20080206155057.44"
		  . "	MDL-00-01	x	displacement	1.0000000000e-003	y	displacement	2.0000000000e-003	z	rotation	3.0000000000e-003"
	);
	receiveCommand();
	$increment = $increment eq "0.5" ? "-0.5" : "0.5";
	sleep 3;
}

sendCommand("close-session	dummy");
receiveCommand();

close $socket;

sub sendCommand {
	my ($cmd) = @_;
	print "Sending [$cmd]\n";
	print $socket $cmd, "\n";

}

sub receiveCommand {
	my $result = <$socket>;
	chomp $result;
	print "Received [$result]\n";
}
