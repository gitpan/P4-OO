######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4-OO-WorkspaceSet.t - test script for P4::OO::WorkspaceSet
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl P4-OO-WorkspaceSet.t'
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
    use_ok( 'P4::OO::WorkspaceSet' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::WorkspaceSet::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $p4WorkspaceSetObj = P4::OO::WorkspaceSet->new();
    isa_ok( $p4WorkspaceSetObj, 'P4::OO::WorkspaceSet' );
    isa_ok( $p4WorkspaceSetObj, 'P4::OO' );

}
runTests();
