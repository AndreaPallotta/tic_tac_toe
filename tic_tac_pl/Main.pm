#!/usr/bin/env perl

use strict;
use warnings;
use lib '.';
use Utils qw($O $X get_user_name clear_terminal);
use Player;
use Game;

clear_terminal();
print "Welcome to Tic Tac Pl!\n\n";

my $round_counter = 1;

my $p1_name = get_user_name(1);
my $p2_name = get_user_name(2);

my $p1 = Player->new({
    name => $p1_name,
    mark => $O,
});

my $p2 = Player->new({
    name => $p2_name,
    mark => $X,
});

my $game = Game->new({
    p1 => $p1,
    p2 => $p2,
});

$game->display();

while (1) {
    $game->make_move();

    $round_counter++;
    clear_terminal();
    print "Here's the updated board. Round $round_counter\n";

    $game->display();

    last if $game->is_over();

    $game->switch_current_player();

    if (defined $game->get_curr_player()) {
        print "It is now " . $game->get_curr_player()->get_name() . " turn!\n";
    } else {
        die "Current player not found. Exiting...";
    }
}

print "\n";