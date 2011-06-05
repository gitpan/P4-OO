######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4-OO-BranchSet.t - test script for P4::OO::BranchSet
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl P4-OO-BranchSet.t'
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
    use_ok( 'P4::OO::BranchSet' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::BranchSet::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $p4BranchSetObj = P4::OO::BranchSet->new();
    isa_ok( $p4BranchSetObj, 'P4::OO::BranchSet' );
    isa_ok( $p4BranchSetObj, 'P4::OO' );

}
runTests();
