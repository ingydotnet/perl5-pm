use Test::More 0.88;
use lib 't/lib';


eval q{ use perl5-tver; 1 };
like $@, qr/version 1.\d+ required/i, "dies on trying to import bad version";


done_testing;
