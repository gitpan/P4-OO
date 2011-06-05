######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::FileSet.pl - test script for P4::OO::FileSet.pm
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl P4::OO.t'
#
######################################################################

######################################################################
# Initialization
#   
    use strict;


######################################################################
# Includes
#
    use Test::More tests => 6;
    use Test::Exception;


######################################################################
# Globals
#


######################################################################
# Tests
#
BEGIN
{
    # test compilation
    use_ok( 'P4::OO::FileSet' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::FileSet::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $p4FileSetObj = P4::OO::FileSet->new();
    isa_ok( $p4FileSetObj, 'P4::OO::FileSet' );
    isa_ok( $p4FileSetObj, 'P4::OO' );

    use_ok( 'P4::OO::File' );
    my $p4FileObj = P4::OO::File->new( 'depotFile' => '//depot/testContent/p4oo/main/' );

    isa_ok( $p4FileObj, 'P4::OO::File' );

    $p4FileSetObj->addObjects( $p4FileObj );
# TODO...
}
runTests();
