######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::_Set.t - test script for P4::OO::_Set.pm
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
    use Test::More tests => 13;
    use Test::Exception;


######################################################################
# Tests
#
BEGIN
{
    # test compilation
    use_ok( 'P4::OO::_Set' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::_Set::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $infraSet = P4::OO::_Set->new();
    isa_ok( $infraSet, 'P4::OO::_Set' );
    isa_ok( $infraSet, 'P4::OO' );

    my $infraObj1 = P4::OO->new( 'foo' => 'bar' );
    my $infraObj2 = P4::OO->new( 'abc' => 'def' );
    my $infraObj3 = P4::OO->new( '123' => '456' );
    my $infraObj4 = P4::OO->new( '_-_' => '-_-' );

    my $testList = [ $infraObj1, $infraObj2, $infraObj3 ];

    is_deeply( [ $infraSet->listObjects() ], [], "list is empty" ); 

    throws_ok( sub { $infraSet->addObjects( { 'foo' => 'bar' } ) }, 'E_Fatal', "add non-P4::OO object" );

    is( $infraSet->addObjects( $infraObj1, $infraObj2, $infraObj3 ), 3, "add three objects" );

    is( $infraSet->addObjects( $infraObj2 ), 0, "add duplicate object" );

    is( $infraSet->addObjects( $infraObj4 ), 1, "add new object" );

    is_deeply( [ $infraSet->listObjects() ], [ $infraObj1, $infraObj2, $infraObj3, $infraObj4 ], "list has 4 objects in same order" ); 

    my $infraSet2 = P4::OO::_Set->new();
    my $infraSet3 = P4::OO::_Set->new();
    $infraSet2->addObjects( $infraObj3, $infraObj2, $infraObj4, $infraObj1 );

    # Test adding and removing of Sets
    is( $infraSet3->addObjects( $infraSet2 ), 4, "add set of 4 objects" );

    # Set up mock P4::OO::_Set subclass for the next series of tests
    eval {
        package P4::OO::_Set::Test::SetMock;
        use base 'P4::OO::_Set';

        sub throwFatal { throw E_Fatal "throwing E_Fatal exception"; };
        sub throwWarning { throw E_Warning "throwing E_Warning exception"; };
    };

    my $infraSetMockObj = P4::OO::_Set::Test::SetMock->new();

    # subclassed objects should have both P4::OO and subclass types
    isa_ok( $infraSetMockObj, 'P4::OO' );
    isa_ok( $infraSetMockObj, 'P4::OO::_Set::Test::SetMock' );

#TODO - test subclassed methods
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
