#!/usr/bin/perl -w

use IO::Socket::INET;
use File::Spec;
use Cwd;
use strict;

my ($host, $port) = ("127.0.0.1",6342);
#my ($host, $port) = ("192.168.1.101","5057");
my $cwd =cwd();
my @dirs = File::Spec->splitdir($cwd);
my $dropped = pop @dirs;
my $pwd = File::Spec->catdir(@dirs);


my $lsocket = new IO::Socket::INET(
                                   LocalAddr => $host,
                                   LocalPort => $port,
                                   Proto     => "tcp",
                                   Listen => 5,
                                   Reuse => 1.
                                  );

die "Connection to $host:$port failed because $!" unless defined $lsocket;

my $running = 1;
my $socket = $lsocket->accept();

while ($running) {
  my($keyword, $trans, $mdl) = receiveCommand();
  if ($keyword eq 'open-session') {
    sendResponse("OK 0\tOpen Session Succeeded");
    next;
  }
  if ($keyword eq 'set-parameter') {
    sendResponse("OK 0\tCommand ignored. Carry on.");
    next;
  }
  if ($keyword eq 'propose') {
    sendResponse("OK\t0\t$trans\tpropose accepted");
    next;
  }
  if ($keyword eq 'execute') {
    sendResponse("OK\t0\t$trans\texecute done");
    next;
  }
  if ($keyword eq 'get-control-point') {
    my ($csp) = $mdl =~ m!:(.+)!;
    if ($csp =~ m!LBCB!) {
      sendResponse("OK   0       dummy   $mdl        x       displacement    5.036049E-1    y       displacement    1.557691E-4     z       displacement    -7.850649E-4    x       rotation        3.829964E-5     y       rotation       -2.747683E-5    z       rotation        1.195688E-3     x       force   6.296413E+0     y       force   1.451685E-1     z       force -1.252275E+0     x       moment  7.296673E-1     y       moment  -2.214440E+0    z       moment  3.522242E-2");
    } else {
      sendResponse("OK 0       dummy   $mdl              Ext.Long.LBCB2     external        2.422813E-1     Ext.Tranv.TopLBCB2  external        2.422813E-1     Ext.Tranv.Bot.LBCB2 external      2.422813E-1      Ext.Long.LBCB1       external        2.422813E-1     Ext.Tranv.LeftLBCB1 external        2.422813E-1     Ext.Tranv.RightLBCB1       external        2.422813E-1     ");
    }
    next;
  }
  if ($keyword eq 'close-session') {
    sendResponse("OK\t0\t$trans\tClose accepted");
    $running = 0;
    next;
  }
}

close $socket;
close $lsocket;

sub sendResponse {
	my ($cmd) = @_;
	print "Sending [$cmd]\n";
	print $socket $cmd, "\n";

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
