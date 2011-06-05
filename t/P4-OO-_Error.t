######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4-OO-_Error.t - test script for P4::OO::_Error
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl P4-OO-_Error.t'
#
######################################################################

######################################################################
# Initialization
#   
    use strict;


######################################################################
# Includes
#
    use Test::More tests => 2;
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
    use_ok( 'P4::OO::_Error' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::_Error::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

#    my $p4_ErrorObj = P4::OO::_Error->new();
#    isa_ok( $p4_ErrorObj, 'P4::OO::_Error' );

}
runTests();
