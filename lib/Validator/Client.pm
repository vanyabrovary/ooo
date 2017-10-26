package Validator::Client;

use warnings;
use strict;

use Validator;
our @ISA = qw/Validator/;

sub name {
    my ( $self, $val ) = @_;
    return 1 if $name;
}

sub email {
    my ( $self, $val ) = @_;
    return $self->isa_email($val);
}

1;

__END__
