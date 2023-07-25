package Player;

use strict;

sub new{
    my ($class,$args) = @_;
    my $self = bless {
        name => $args->{name},
        mark => $args->{mark}
    }, $class;
}

sub get_name{
    my $self = shift;
    return $self->{name};
}

sub get_mark{
    my $self = shift;
    return $self->{mark};
}

sub compare_to{
    my ($self, $player) = @_;

    unless (defined $player) {
        print "Current player not found. Skipping...";
        return 0;
    }

    if ($self->get_name() eq $player->get_name() &&
        $self->get_mark() eq $player->get_mark()) {
        return 1;
    } else {
        return 0;
    }
}

1;