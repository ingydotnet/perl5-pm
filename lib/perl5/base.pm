##
# name:      perl5::base
# abstract:  Base class for perl5 plugins
# author:    Ingy döt Net <ingy@ingy.net>
# license:   perl
# copyright: 2010
# see:
# - perl5

package perl5::base;
use 5.010_000;
use strict;
use warnings;
use feature ();

our $VERSION = '0.03';

sub import {
    my $class = shift;
    my $package = caller;
    strict->import;
    warnings->import;
    feature->import(':5.10');
    
    # XXX This seems a bit brute force.
    if ($class->can('use_module_code_section')) { 
        my $code = $class->use_module_code_section();
        eval "package $package;\n$code;1;\n" or die $@;
    }
}

1;

=head1 SYNOPSIS

    use perl5;

Same as:

    use perl5-base;

Same as:

    use 5.010;
    use strict;
    use warnings;

=head1 DESCRIPTION

C<perl5::base> is both a C<perl5> plugin and a base class for C<perl5>
plugins.

=head1 API

This API is new, unstable, shite, and will change once I talk to some smart
people about how to do it right.

To create a plugin called C<perl5::foo> that gets called like this:

    use perl5-foo;

Write some code like this:

    package perl5::foo;
    use perl5::base 0.01 ();
    our $VERSION = 0.12;
    our @ISA = qw(perl5::base);

    use SomeModule 0.22 ();
    use OtherModule 0.33 ();

    sub import {
        # you can do stuff here, but then:
        goto perl5::base::import;
    }

    # These is the code that will be run when people use your module:
    sub use_module_code_section {
        return <<"...";
    use SomeModule;
    use OtherModule option1 => 2;
    ...
    }

    1;

The name C<use_module_code_section> is meant to be ugly, because it feels like
an ugly way to do it.
