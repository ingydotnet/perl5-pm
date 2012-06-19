use Test::More 0.88;
use Test::Exception;
use lib 't/lib';

use perl5-tlex;


eval '$f = 1';
like $@, qr/requires explicit package name/, 'got strict';

eval '6 + "fred"';
like $@, qr/isn't numeric/, 'got fatal warnings';

#eval 'try {die} catch {};';
#is $@, '', 'try/catch syntax imported';


done_testing;
