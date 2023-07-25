package Utils;

use strict;
use Exporter qw(import);

use Readonly;
use constant;

Readonly our $O   => "O";
Readonly our $X   => "X";
Readonly our $DEF => "-";

sub trim { my $str = shift; $str =~ s/^\s+|\s+$//g; return $str }

sub clear_terminal { system $^O eq 'MSWin32' ? 'cls' : 'clear' }

sub is_integer { defined $_[0] && $_[0] =~ /^[+-]?\d+$/; }

sub get_user_name{
    my $player_num = shift;
    my $def_name = "Player $player_num";

    print "Insert player $player_num name (default '$def_name'): ";
    my $input = <>;
    chomp($input);
    my $trimmed_input = trim($input);

    if ($trimmed_input eq "") {
        return $def_name;
    } else {
        return $trimmed_input;
    }

    return $trimmed_input eq "" ? $def_name : $trimmed_input;
}

sub get_user_coords{
    my $player_name = shift;

    print "Player $player_name, enter row and column (e.g. '1 2'): ";
    my $input = <>;
    chomp($input);
    my @input_arr = split(/ /, trim($input));
    
    my $row = $input_arr[0];
    my $col = $input_arr[1];

    unless(is_integer($row) && is_integer($col)) {
        die "Invalid row or column. Try again\n";
    }

    return ($row - 1, $col - 1);
}

our @EXPORT_OK = qw($O $X $DEF get_user_name get_user_coords clear_terminal);

