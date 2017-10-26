package Validator;

use warnings;
use strict;

use UNIVERSAL;
use Email::Valid;

sub new() {
    my $class = shift;
    bless { arg => shift, skip => shift }, $class;
}

sub validate {
    my $self = shift;

    ## Create a hash from an array
    if ( ref($self->{skip}) eq 'ARRAY' ) {
	grep { $self->{skip_h}->{$_}++ } @{ $self->{skip} };
    }

    for ( keys %{ $self->{arg} } ) {

        ## Check whether a function exists in a child package. And not exists at skip list.
        if ( $self->can($_) && !exists( $self->{skip_h}->{$_} ) ) {

          ## Call a function to validate current parameter.
          unless ( defined $self->{arg}->{$_} ){
	    $self->{err}->{$_} = { code => 'UNDEF PARAM ' . uc($_) };
	    next;
          }

          if ( !$self->$_( $self->{arg}->{$_} ) ) {
	    ## All errors puts to $self->{err}
	    $self->{err}->{$_} = { code => 'BAD PARAM ' . uc($_) };
          }

        }
    }

    return $self->{err};
}

sub isa_int {
    my ( $self, $val ) = @_;
    return 0 unless defined $val;
    return unless $val =~ /^\d+$/;
}

sub isa_percent {
    my ( $self, $val ) = @_;

    return $val if $val > 0 and $val <= 100;
}

sub isa_email {
    my ( $self, $val ) = @_;
    my $email;
    eval { $email = Email::Valid->address( -address => $val, -mxcheck => 1 ); };
    return $val if $email;
}

sub isa_currency {
    my ( $self, $val ) = @_;
    return $val if $self->isa_any( $val, [ 'BTC', 'USD', 'EUR', 'USDT' ] );
}

sub isa_any {
    my ( $self, $val, $list ) = @_;
    if ( ref($list) eq 'ARRAY' ) {
        return $val if ( grep { $val eq $_ } @$list );
    }
}

sub isa_day {
    my ( $self, $val ) = @_;
    return $val if 1 <= $val && 31 >= $val;
}

sub isa_month {
    my ( $self, $val ) = @_;
    return $val if 1 <= $val && 12 >= $val;
}

sub isa_year {
    my ( $self, $val ) = @_;
    return $val if 1 <= $val && 5 >= $val;    # 5 years maximum
}

1;


=pod

=encoding UTF-8

=head1 NAME

Validator

=head1 VERSION

0.1

=head1 DESCRIPTION

Base class for validate parameters before sending to DBIx

=head1 SYNOPSIS

  my $params = {
      "client_id"          => '2',
      "email"              => 'vanya@gmail.com',
      "name"               => 'Ivan',
      "descr"              => 'web developer',
  };

  my $skip_params = [ 'descr' ];

  my $ferrors = DB->model('Client')->validate( $params, $skip_params );
    unless ($ferrors) {
      $db->resultset('Client')->create($params)
  } else {
      print Dumper($ferrors);
  }

=head1 METHODS

=head2 new

Constructor with two parameters ($params, $skip_params)

=head2 validate

 1. Create a hash from an array of skip params
 2. Check whether a function exists in a child package. And not exists at skip list.
 3. Call a function to validate current parameter.
 4. All errors puts to $self->{err}

=head1 BUGS

 1. Warnings with undef
 2. Warnings with undef

=cut
