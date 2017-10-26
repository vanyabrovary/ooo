use utf8;
package Schema::Result::Client;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Client

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<client>

=cut

__PACKAGE__->table("client");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'client_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "client_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<client_email>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("client_email", ["email"]);

=head2 C<client_name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("client_name", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-10-19 02:17:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xaBiAEuO3yzaH9C1/kMvbg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
