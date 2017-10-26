package Validator::Loan;

use warnings;
use strict;

use DB;
use Validator;

our @ISA = qw/Validator/;

sub principal_amount {
    my ( $self, $val ) = @_;

    my ( $MIN, $MAX ) = ( 27, 19000 );

    return 1 if $MIN <= $val && $MAX >= $val;
}

sub ltv_initial {
    my ( $self, $val ) = @_;

    return 1 if $self->isa_percent($val) && $val < $self->{arg}->{ltv_margin_call};
}

sub ltv_margin_call {
    my ( $self, $val ) = @_;

    return $self->isa_percent($val) && $val < $self->{arg}->{ltv_collateral_sale};
}

sub ltv_collateral_sale {
    my ( $self, $val ) = @_;

    return $self->isa_percent($val);
}

sub interest_rate {
    my ( $self, $val ) = @_;

    return $self->isa_percent($val);
}

sub principal_currency {
    my ( $self, $val ) = @_;

    return $self->isa_currency($val);
}

sub collateral_currency {
    my ( $self, $val ) = @_;

    return $self->isa_currency($val);
}

sub client_id {
    my ( $self, $val ) = @_;

    return 1 if $db->resultset('Client')->find($val);
}

sub email {
    my ( $self, $val ) = @_;

    return $self->isa_email($val);
}

sub type {
    my ( $self, $val ) = @_;

    return $self->isa_any( $val, [ 'offer', 'request' ] );
}

sub state {
    my ( $self, $val ) = @_;

    return $self->isa_any( $val, [ 'new', 'open', 'cancelled', 'success' ] );
}

sub term {
    my ( $self, $val ) = @_;

    if ( $self->{arg}->{term_type} eq 'y' ) {
        return 1 if $self->isa_year($val);
    }
    if ( $self->{arg}->{term_type} eq 'd' ) {
        return 1 if $self->isa_day($val);
    }
    if ( $self->{arg}->{term_type} eq 'm' ) {
        return 1 if $self->isa_month($val);
    }
}

sub term_type {
    my ( $self, $val ) = @_;

    return $self->isa_any( $val, [ 'd', 'm', 'y' ] );
}

1;

__END__
