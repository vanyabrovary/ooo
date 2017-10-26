use utf8;
package Schema::Result::Loan;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Loan

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<loan>

=cut

__PACKAGE__->table("loan");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'loan_id_seq'

=head2 type

  data_type: 'enum'
  extra: {custom_type_name => "loan_type",list => ["offer","request"]}
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  is_nullable: 1

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 created_at

  data_type: 'timestamp'
  default_value: timezone('utc'::text, now())
  is_nullable: 0

=head2 opened_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 cancelled_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 state

  data_type: 'enum'
  default_value: 'new'
  extra: {custom_type_name => "loan_state",list => ["new","open","cancelled","success"]}
  is_nullable: 0

=head2 principal_amount

  data_type: 'numeric'
  is_nullable: 1
  size: [16,8]

=head2 principal_currency

  data_type: 'enum'
  extra: {custom_type_name => "currency_code",list => ["BTC","USD","EUR","USDT"]}
  is_nullable: 0

=head2 term_type

  data_type: 'enum'
  extra: {custom_type_name => "loan_term_type",list => ["d","m","y"]}
  is_nullable: 0

=head2 term

  data_type: 'smallint'
  is_nullable: 0

=head2 interest_rate

  data_type: 'numeric'
  is_nullable: 0
  size: [5,2]

=head2 ltv_initial

  data_type: 'numeric'
  is_nullable: 0
  size: [5,2]

=head2 ltv_margin_call

  data_type: 'numeric'
  is_nullable: 0
  size: [5,2]

=head2 ltv_collateral_sale

  data_type: 'numeric'
  is_nullable: 0
  size: [5,2]

=head2 collateral_currency

  data_type: 'enum'
  extra: {custom_type_name => "currency_code",list => ["BTC","USD","EUR","USDT"]}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "loan_id_seq",
  },
  "type",
  {
    data_type => "enum",
    extra => { custom_type_name => "loan_type", list => ["offer", "request"] },
    is_nullable => 0,
  },
  "client_id",
  { data_type => "integer", is_nullable => 1 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"timezone('utc'::text, now())",
    is_nullable   => 0,
  },
  "opened_at",
  { data_type => "timestamp", is_nullable => 1 },
  "cancelled_at",
  { data_type => "timestamp", is_nullable => 1 },
  "state",
  {
    data_type => "enum",
    default_value => "new",
    extra => {
      custom_type_name => "loan_state",
      list => ["new", "open", "cancelled", "success"],
    },
    is_nullable => 0,
  },
  "principal_amount",
  { data_type => "numeric", is_nullable => 1, size => [16, 8] },
  "principal_currency",
  {
    data_type => "enum",
    extra => {
      custom_type_name => "currency_code",
      list => ["BTC", "USD", "EUR", "USDT"],
    },
    is_nullable => 0,
  },
  "term_type",
  {
    data_type => "enum",
    extra => { custom_type_name => "loan_term_type", list => ["d", "m", "y"] },
    is_nullable => 0,
  },
  "term",
  { data_type => "smallint", is_nullable => 0 },
  "interest_rate",
  { data_type => "numeric", is_nullable => 0, size => [5, 2] },
  "ltv_initial",
  { data_type => "numeric", is_nullable => 0, size => [5, 2] },
  "ltv_margin_call",
  { data_type => "numeric", is_nullable => 0, size => [5, 2] },
  "ltv_collateral_sale",
  { data_type => "numeric", is_nullable => 0, size => [5, 2] },
  "collateral_currency",
  {
    data_type => "enum",
    extra => {
      custom_type_name => "currency_code",
      list => ["BTC", "USD", "EUR", "USDT"],
    },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-10-19 02:17:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DyEfNpockPT++ZjoJnSkOA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
