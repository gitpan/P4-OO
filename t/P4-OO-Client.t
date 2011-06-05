######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::Client.pl - test script for P4::OO::Client.pm
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
    use_ok( 'P4::OO::Client' );
}

sub runTests
{
    # Version consistency
    require P4::OO;
    is( $P4::OO::Client::VERSION, $P4::OO::VERSION, "Version is consistent with P4::OO" );

    my $p4ClientObj = P4::OO::Client->new();
    isa_ok( $p4ClientObj, 'P4::OO::Client' );
    isa_ok( $p4ClientObj, 'P4::OO' );

#    my $p4ChangeSet = $p4ClientObj->getChanges();
#    isa_ok( $p4ChangeSet, 'P4::OO::ChangeSet' );
#
#    my $p4FileSet = $p4ClientObj->getOpenedFiles();
#    isa_ok( $p4FileSet, 'P4::OO::FileSet' );
}
runTests();
