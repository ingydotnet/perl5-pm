##
# name:      perl5
# abstract:  Use a Bunch of Modules in One Go
# author:    Ingy döt Net <ingy@ingy.net>
# license:   perl
# copyright: 2010
# see:
# - perl5i
# - perl5::i
# - perl5::ingy

package perl5;
use 5.010_000;
use strict;
use warnings;

our $VERSION = '0.02';

# TODO:
# - Provide plugin version number support
#   use perl5-foo => 1.23, ...; # maybe
sub import {
    my ($package, $perl5) = @_;
    $perl5 ||= '-base';
    die "'$perl5' is an invalid first argument to 'use perl5...'"
        unless $perl5 =~ /^-(\w+)$/;
    my $perl5_class = "perl5::$1";
    eval "use $perl5_class (); 1" or die $@;
    splice(@_, 0, 1, $perl5_class);
    no strict 'refs';
    goto &{"${perl5_class}::import"};
}

1;

=head1 SYNOPSIS

    use perl5;
    use perl5-i;
    use perl5-2i;
    use perl5-ingy;
    use perl5-yourShinyPlugin;

=head1 DESCRIPTION

The C<perl5> module lets you C<use> a well known set of modules in one
command.

It allows people to create plugins like C<perl5::foo> and C<perl5::bar> that
are sets of useful modules that have been tested together and are known to
create joy.

=head1 USAGE

This:

    use perl5-foo;

Is equivalent in Perl to:

    use perl5 '-foo';

The C<perl5> module takes the first argument in the C<use> command, and uses
it to find a plugin, like C<perl5::foo> in this case.

C<perl5::foo> is typically just a subclass of L<perl5::base>. It invoke a set
of modules for its caller.

If you use C<perl5> with no arguments, like this:

    use perl5;

It is the same as saying:

    use perl5-base

In other words, it just assumes the perl5 plugin base class. This is actually
useful. It is equivalent to:

    use 5.010;
    use strict;
    use warnings;

=head1 INSPIRATION

This module was inspired by Michael Schwern's L<perl5i>, and the talk he gave
about it at the 2010 OSDC in Melbourne. By "inspired" I mean that I was
perturbed by Schwern's non-TMTOWTDI attitude towards choosing a standard set
of Perl modules for all of us.

    THIS IS PERL! THERE ARE NO STANDARDS!

...and I told him so. I also promised that I would show him my feelings in
code. Schwern, I<this> is how I feel!

For extra credit, I will release perl5::i, that will attempt to be equivalent
to perl5i::latest (except better at golf).

DISCLAIMER: Mr Schwern has my full love and respect, and knows it well. :)
