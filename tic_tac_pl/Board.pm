package Board;

use strict;
use warnings;
use Utils qw($DEF);

sub new{
    my ($class,$args) = @_;
    my $size = 3;
    my @cells;

    for my $row (0..$size-1) {
        for my $col (0..$size-1) {
            $cells[$row][$col] = "";
        }
    }

    my $self = bless {
        size => $size,
        cells => \@cells,
    }, $class;
}

sub is_valid_position{
    my ($self, $row, $col, $args) = @_;
    my $full_check = $args->{full_check} // 1;

    if ($row < 0 or $col < 0 or $row >= $self->{size} or $col >= $self->{size}) {
        return 0;
    }

    if ($full_check) {
        return $self->{cells}[$row][$col] eq "";
    } else {
        return 1;
    }
}

sub get_cell{
    my ($self, $row, $col) = @_;

    if ($self->is_valid_position($row, $col, { full_check => 0 })) {
        return $self->{cells}[$row][$col];
    } else {
        die "Invalid row or column value. Try again";
    }
}

sub set_cell{
    my ($self, $row, $col, $mark) = @_;

    if ($self->is_valid_position($row, $col)) {
        $self->{cells}[$row][$col] = $mark;
    } else {
        die "Invalid row or column value. Try again";
    }
}

sub display{
    print "\n     c1  c2  c3\n";
    print "   -------------\n";

    my $self = shift;
    for my $row (0..$self->{size}-1) {
         print "r" . ($row + 1) . " |";
        for my $col (0..$self->{size}-1) {
            my $cell = sprintf("%2s", $self->{cells}[$row][$col]);
            print "$cell |";
        }
        print "\n   -------------\n";
    }
    print("\n");
}

sub is_full{
    my $self = shift;
    return !grep { $_ eq "" } map { @$_ } @{ $self->{cells} };
}

sub has_horizontal_win{
    my $self = shift;
    for my $row (0..$self->{size}-1) {
        my $first_cell = $self->{cells}[$row][0];
        my $win = 1;

        for my $col (1..$self->{size}-1) {
            my $cell = $self->{cells}[$row][$col];
            if ($cell eq "" || $cell ne $first_cell) {
                $win = 0;
                last;
            }
        }

        return 1 if $win;
    }

    return 0;
}

sub has_vertical_win{
    my $self = shift;
    for my $col (0..$self->{size}-1) {
        my $first_cell = $self->{cells}[0][$col];
        my $win = 1;

        for my $row (1..$self->{size}-1) {
            my $cell = $self->{cells}[$row][$col];
            if ($cell eq "" || $cell ne $first_cell) {
                $win = 0;
                last;
            }
        }

        return 1 if $win;
    }

    return 0;
}

sub has_diagonal_win{
    my $self = shift;
    my @main_diag = map { $self->{cells}[$_][$_] } 0..$self->{size}-1;
    my @sec_diag = map { $self->{cells}[$_][$self->{size}-$_-1] } 0..$self->{size}-1;

    my $main_match = $main_diag[0] ne "" && !grep { $_ ne $main_diag[0] } @main_diag;
    my $sec_match = $sec_diag[0] ne "" && !grep { $_ ne $sec_diag[0] } @sec_diag;

    return 1 if $main_match or $sec_match;
    return 0
}

sub check_winner {
    my $self = shift;
    my $horizontal_win = $self->has_horizontal_win();
    my $vertical_win = $self->has_vertical_win();
    my $diagonal_win = $self->has_diagonal_win();

    return 1 if $self->has_horizontal_win() or $self->has_vertical_win() or $self->has_diagonal_win();
    return 0;
}

sub set_remaining_cells{
    my $self = shift;

    for my $row (0..$self->{size}-1) {
        for my $col (0..$self->{size}-1) {
            if ($self->{cells}[$row][$col] eq "") {
                $self->set_cell($row, $col, $DEF);
            }
        }
    }
}

1;