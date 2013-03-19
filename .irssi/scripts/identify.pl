use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

sub cmd_identify {
    my ($data, $server, $witem) = @_;
    my ($password) = split(/\s+/, $data, 1);

    $server->command("QUOTE NickServ identify $password");
}

Irssi::command_bind('identify', 'cmd_identify');
