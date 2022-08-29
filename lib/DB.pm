package DB;

use warnings;
use strict;

use Schema;

BEGIN {
    use Exporter();
    our @ISA    = qw(Exporter);
    our @EXPORT = qw($db);

    ## Added die;
    our $db     = Schema->connect( "dbi:Pg:dbname=oo;host=127.0.0.1;database=oo", 'oo', 'ooo' ) or die "CAN'T CONNECT TO DB";

    ## replace shift to @_, die unless table defined
    sub model {
        my ($class, $table) = @_;
	die 'BAD MODEL TABLE!' unless defined $table;
        bless { table => $table }, $class;
    }

    sub validate {
        my $self       = shift;
        my $type       = $self->{table};
        my $location   = "Validator/$type.pm";
        my $this_class = "Validator::$type";

        require $location;

        my $result = $this_class->new(@_);

        return $result->validate();
    }

}

1;
