package Game;

use strict;
use warnings;

use Player;
use Board;
use Utils qw(clear_terminal get_user_coords);

sub new{
    my ($class,$args) = @_;

    my $self = bless {
        player1 => $args->{p1},
        player2 => $args->{p2},
        current_player => $args->{p1},
        winner => undef,
        board => Board->new(),
    }
}

sub get_curr_player{
    my $self = shift;
    return $self->{current_player};
}

sub switch_current_player{
    my $self = shift;

    if ($self->{current_player}->compare_to($self->{player1})) {
        $self->{current_player} = $self->{player2};
    } elsif ($self->{current_player}->compare_to($self->{player2})) {
        $self->{current_player} = $self->{player1};
    }
}

sub display{
    my $self = shift;
    $self->{board}->display();
}

sub is_winner{
    my $self = shift;
    return $self->{board}->check_winner();
}

sub is_draw{
    my $self = shift;
    return $self->{board}->is_full();
}

sub is_over{
    my $self = shift;

    print $self->is_winner() . "\n";
    
    if ($self->is_winner()) {
        $self->{winner} = $self->{current_player};
        $self->{board}->set_remaining_cells();
        clear_terminal();
        $self->display();
        print "Game over! " . $self->{current_player}->get_name() . " is the winner!\n";
        return 1;
    } elsif ($self->is_draw()) {
        $self->{winner} = undef;
        $self->{current_player} = undef;
        print "Game over! It is a draw!\n";
        return 1;
    }

    return 0;
}

sub make_move{
    my $self = shift;

    unless (defined $self->{current_player}) {
        die "Current player not found";
    }

    while (1) {
        my $result = eval {
            my ($row, $col) = get_user_coords("Test 1");
            $self->{board}->set_cell($row, $col, $self->{current_player}->get_mark());
            return 1;
        };

        if ($@) {
            print "$@\n";
        } else {
            last;
        }
    }
}

1;