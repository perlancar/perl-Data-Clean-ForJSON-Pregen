package Data::Clean::ForJSON::Pregen;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(
                       clean_for_json_in_place
                       clone_and_clean_for_json
               );

sub _clone {
    if (eval { require Data::Clone; 1 }) {
        Data::Clone::clone(@_);
    } else {
        require Clone::PP;
        Clone::PP::clone(@_);
    }
}

# CODE: require Data::Clean::JSON; my $cleanser = Data::Clean::JSON->new(-obj=>['unbless_ffc_inlined'], '!clone_func' => '_clone'); my $src = $cleanser->{src}; $src =~ s/\A\s*sub\s*\{//s; $src =~ s/\}(\s*;)?\s*\z//; $src; "# generated with Data::Clean version $Data::Clean::VERSION, Data::Clean::JSON version $Data::Clean::JSON::VERSION\nsub clean_for_json_in_place { $src }\n";

sub clone_and_clean_for_json {
    my $data = _clone(shift);
    clean_for_json_in_place($data);
}

1;
# ABSTRACT: Clean data so it is safe to output to JSON

=head1 SYNOPSIS

 use Data::Clean::ForJSON::Pregen qw(clean_for_json_in_place clone_and_clean_for_json);

 clean_for_json_in_place($data);
 $cleaned = clone_and_clean_for_json($data);


=head1 DESCRIPTION

This has the same functionality as L<Data::Clean::ForJSON> except that the code
to perform the cleaning is pre-generated, so we no longer need L<Data::Clean> or
L<Data::Clean::ForJSON> during runtime.


=head1 FUNCTIONS

None of the functions are exported by default.

=head2 clean_for_json_in_place($data)

=head2 clone_and_clean_for_json($data) => $cleaned


=head1 SEE ALSO

L<Data::Clean::ForJSON>

=cut
