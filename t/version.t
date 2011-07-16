use Test::More tests => 16;


test_usage($_) for split "\n", <<'';
use perl5 v90.0;
use perl5 90.0;
use perl5 '90.0';
use perl5-90.0;
use perl5 v90.0 -xyzzy;
use perl5 90.0 -xyzzy;
use perl5 90.0, -xyzzy;
use perl5 90.0-xyzzy;
use perl5 '90.0' -xyzzy;
use perl5 '90.0',-xyzzy;
use perl5 '90.0'-xyzzy;
use perl5-90.0 -xyzzy;
use perl5-90.0,-xyzzy;
use perl5-90.0-xyzzy;

sub test_usage {
    my $usage = shift;
    eval $usage;
    my $error = $@;
    unless ($error) {
        fail "'$usage' failed to fail";
        return;
    }
    like $error, qr/\QPerl v5.90.0.0 required--this is only v5.\E/,
        "'$usage' usage failed appropriately";
}

{
    my $usage = "use perl5 9;";
    eval $usage;
    like $@, qr/^\Qperl5 version 9 required--this is only version\E/,
        "'$usage' usage failed appropriately";
}

{
    my $usage = "use t::subclass 8 ();";
    eval $usage;
    like $@, qr/^\Qt::subclass version 8 required--this is only version 1.23\E/,
        "'$usage' usage failed appropriately";
}


