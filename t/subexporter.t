use Test::More 0.88;
use lib 't/lib';

{
    package test1;
    use TestSubExporter;
}

{
    package test2;
    use perl5-tsubexp;
}

ok defined(&test1::bar),
    "basic sanity check: TestSubExporter does export when use'd normally";

ok defined(&test2::bar),
    "ExportSubTester exports when use'd via perl5";

done_testing;
