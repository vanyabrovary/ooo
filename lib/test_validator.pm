use warnings;
use strict;

use DB;
use Data::Dumper;

my $params = {
    "client_id"           => '2', #1
    "email"               => 'vanyabrovaru@gmail.com',
    "state"               => 'open',
    "type"                => 'offer',
    "term_type"           => 'm',
    "term"                => '5',
    "principal_currency"  => 'USD',
    "collateral_currency" => 'EUR',
    "principal_amount"    => 1.121227,
    "interest_rate"       => undef,
    "ltv_initial"         => 11.00,
    "ltv_margin_call"     => 7.00,
    "ltv_collateral_sale" => 10.00,
};

my $skip_params = [ 'ltv_initial', 'ltv_margin_call' ];

my $ferrors = DB->model('Loan')->validate( $params, $skip_params );

unless ($ferrors) {
    $db->resultset('Loan')->create($params)
} else {
    print Dumper($ferrors);
}

1;
