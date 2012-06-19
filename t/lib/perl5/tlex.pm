package perl5::tlex;
use base 'perl5';

sub imports
{
    strict => [qw(subs refs vars)],
    warnings => [FATAL => 'all'],         # easier to test
    #TryCatch =>
    # maybe more here later
}

1;
