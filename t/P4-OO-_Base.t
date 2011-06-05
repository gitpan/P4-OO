######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4-OO-_Base.t - test script for P4::OO::_Base.pm
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
    use Test::More tests => 17;
    use Test::Exception;


######################################################################
# Tests
#
BEGIN
{
    # test compilation
    use_ok( 'P4::OO::_Base' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::_Base::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $infraObj = P4::OO::_Base->new();
    isa_ok( $infraObj, 'P4::OO::_Base' );

    # test _getAttr/_setAttr accessors
    is( $infraObj->_getAttr( 'attrFoo' ), undef, "_getAttr() returns undef for non-existing attr" );
    is( $infraObj->_setAttr( 'attrFoo', "bar" ), "bar", "_setAttr() returns new attr value" );
    is( $infraObj->_getAttr( 'attrFoo' ), "bar", "_getAttr() returns value for existing attr" );

    # Set up mock P4::OO::_Base subclass for the next series of tests
    eval {
        package P4::OO::_Base::Test::BaseMock;
        use base 'P4::OO::_Base';

        sub throwFatal { throw E_Fatal "throwing E_Fatal exception"; };
        sub throwWarning { throw E_Warning "throwing E_Warning exception"; };
    };

    my $infraMockObj = P4::OO::_Base::Test::BaseMock->new();

    # subclassed objects should have both P4::OO::_Base and subclass types
    isa_ok( $infraMockObj, 'P4::OO::_Base' );
    isa_ok( $infraMockObj, 'P4::OO::_Base::Test::BaseMock' );

    # test exception throwing
    throws_ok sub { $infraMockObj->throwFatal(); }, 'E_Fatal';
    throws_ok sub { $infraMockObj->throwWarning(); }, 'E_Warning';

    my $goldenArgsHash1 = {};
    my $testArgs1 = $infraObj->_argsToHash( "_BaseTest1" );
    is_deeply( $testArgs1, $goldenArgsHash1, "_argsToHash returns empty hashref for no args" );

    my $goldenArgsHash2 = { 'v1' => [ 1, 2, 3 ] };
    my $testArgs2 =  $infraObj->_argsToHash( '_BaseTest2', 'v1', 1, 'v1', 2, 'v1', 3 );
    is_deeply( $testArgs2, $goldenArgsHash2, "_argsToHash( '_BaseTest2', 'v1', 1, 'v1', 2, 'v1', 3 )" );

    my $goldenArgsHash3 = { 'v1' => [ [ 1, 2 ], 3 ] };
    my $testArgs3 = $infraObj->_argsToHash( '_BaseTest3', 'v1', [ 1, 2 ], 'v1', 3 );
    is_deeply( $testArgs3, $goldenArgsHash3, "_argsToHash( '_BaseTest3', 'v1', [ 1, 2 ], 'v1', 3 )" );

    my $goldenArgsHash4 = { 'v1' => 1, 'v2' => 2, 'v3' => 3 };
    my $testArgs4 = $infraObj->_argsToHash( '_BaseTest4', { 'v1' => 1, 'v2' => 2, 'v3' => 3 } );
    is_deeply( $testArgs4, $goldenArgsHash4, "_argsToHash( '_BaseTest4', { 'v1' => 1, 'v2' => 2, 'v3' => 3 } )" );

    my $goldenArgsHash5 = { 'v1' => 1, 'v2' => 2, 'v3' => 3 };
    my $testArgs5 = $infraObj->_argsToHash( '_BaseTest5', [ 'v1' => 1, 'v2' => 2, 'v3' => 3 ] );
    is_deeply( $testArgs5, $goldenArgsHash5, "_argsToHash( '_BaseTest5', [ 'v1' => 1, 'v2' => 2, 'v3' => 3 ] )" );

    my $goldenArgsHash6 = { 'v1' => 1, 'v2' => 2, 'v3' => 3 };
    my $testArgs6 = $infraObj->_argsToHash( '_BaseTest6', 'v1' => 1, 'v2' => 2, 'v3' => 3 );
    is_deeply( $testArgs6, $goldenArgsHash6, "_argsToHash( '_BaseTest6', 'v1' => 1, 'v2' => 2, 'v3' => 3 )" );

    my $goldenArgsHash7 = { 'v1' => [ 1, [ 2, 3 ] ] };
    my $testArgs7 = $infraObj->_argsToHash( '_BaseTest7', 'v1', 1, 'v1', [ 2, 3 ] );
    is_deeply( $testArgs7, $goldenArgsHash7, "_argsToHash( '_BaseTest7', 'v1', 1, 'v1', [ 2, 3 ] )" );
}
runTests();


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

 Written by David L. Armstrong

=head1 COPYRIGHT

 Copyright (c)2010-2011, David L. Armstrong.

=cut
