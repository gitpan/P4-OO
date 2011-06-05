######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO.t - test script for P4::OO.pm
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl P4::OO.t'
#
######################################################################

######################################################################
# Initialization
#   
    use strict;
    use warnings;


######################################################################
# Includes
#
    use Test::More tests => 9;
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
    use_ok( 'P4::OO' );
}

sub runTests
{
    my $p4ooObj = P4::OO->new();
    isa_ok( $p4ooObj, 'P4::OO' );

    # test _getAttr/_setAttr accessors
    is( $p4ooObj->_getAttr( 'attrFoo' ), undef, "_getAttr() returns undef for non-existing attr" );
    is( $p4ooObj->_setAttr( 'attrFoo', "bar" ), "bar", "_setAttr() returns new attr value" );
    is( $p4ooObj->_getAttr( 'attrFoo' ), "bar", "_getAttr() returns value for existing attr" );

    # Set up mock P4::OO subclass for the next series of tests
    eval {
        package P4::OO::Test::P4OOMock;
        use base 'P4::OO';

        sub throwFatal { throw E_Fatal "throwing E_Fatal exception"; };
        sub throwWarning { throw E_Warning "throwing E_Warning exception"; };
    };

    my $p4ooMockObj = P4::OO::Test::P4OOMock->new();

    # subclassed objects should have both P4::OO and subclass types
    isa_ok( $p4ooMockObj, 'P4::OO' );
    isa_ok( $p4ooMockObj, 'P4::OO::Test::P4OOMock' );

    # test exception throwing
    throws_ok sub { $p4ooMockObj->throwFatal(); }, 'E_Fatal';
    throws_ok sub { $p4ooMockObj->throwWarning(); }, 'E_Warning';


    # Test raw P4 functionality

#    my $p4ConnObj = $p4ooObj->_getP4Connection();
#    my $p4Out = $p4ConnObj->execCmd( 'clients' );

#require Data::Dumper;
##print Data::Dumper::Dumper( $p4Out );
#
#require P4::OO::Change;
#my $userDave = P4::OO::Change->new( 'id' => 'dave' );
#print Data::Dumper::Dumper( $userDave->_readPlural( '-u', 'dave' ) );
##print Data::Dumper::Dumper( $userDave );
}
runTests();
