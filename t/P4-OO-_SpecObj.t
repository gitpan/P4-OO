######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4-OO-_SpecObj.t - test script for P4::OO::_SpecObj
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl P4-OO-_SpecObj.t'
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
    use_ok( 'P4::OO::_SpecObj' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::_SpecObj::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $p4_SpecObjObj = P4::OO::_SpecObj->new();
    isa_ok( $p4_SpecObjObj, 'P4::OO::_SpecObj' );
    isa_ok( $p4_SpecObjObj, 'P4::OO' );

}
runTests();
