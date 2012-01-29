use Test::More 0.88;
use lib 't/lib';


{
    package test1;
    use TestExporter;
    use TestSubExporter;
    use Test::Exception;

    lives_ok { foo() } "basic sanity check: TestExporter does export when use'd normally";
    lives_ok { bar() } "basic sanity check: TestSubExporter does export when use'd normally";
}

{
    package test2;
    use perl5-texp;
    use Test::Exception;

    lives_ok { foo() } "ExportTester exports when use'd via perl5";
    lives_ok { bar() } "ExportSubTester exports when use'd via perl5";
}


done_testing;
