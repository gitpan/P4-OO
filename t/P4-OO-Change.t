######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4-OO-Change.t - test script for P4::OO::Change
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl P4-OO-Change.t'
#
######################################################################

######################################################################
# Initialization
#   
    use strict;


######################################################################
# Includes
#
    use Test::More tests => 4;
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
    use_ok( 'P4::OO::Change' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::Change::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $p4ChangeObj = P4::OO::Change->new();
    isa_ok( $p4ChangeObj, 'P4::OO::Change' );
    isa_ok( $p4ChangeObj, 'P4::OO' );

}
runTests();
