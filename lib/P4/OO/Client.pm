######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::Client.pm
#
#  See COPYRIGHT AND LICENSE section in pod text below for usage
#   and distribution rights.
#
######################################################################

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut


######################################################################
# Package Initialization
#
    package P4::OO::Client;
    our $VERSION = '0.00_01';
    use base 'P4::OO::_SpecObj';
    use strict;


######################################################################
# Globals
#
    # Subclasses must define SPECOBJ_TYPE
    sub SPECOBJ_TYPE { return( 'client' ); }


######################################################################
# Methods
#

sub getChanges
{
    my $self = shift();

    # Asking a Client for its changes is implemented as querying Changes filtered by Client
    my $p4Conn = $self->_getP4Connection();
    my $p4ChangeSet = $p4Conn->query( 'change', { 'client' => $self->_getSpecID() } );

    return( $p4ChangeSet );
}


sub getOpenedFiles
{
    my $self = shift();

    my $specID = $self->_getSpecID();
    my $p4Conn = $self->_getP4Connection();

    my @openedCmd = ( 'opened' );
    if( defined( $specID ) )
    {
        push( @openedCmd, '-C', $specID );
    }

    my $p4Output = $p4Conn->_execCmd( @openedCmd );

    require P4::OO::File;
    require P4::OO::FileSet;

    # Iterate through the 'p4 opened' output, creating File objects
    my $fileList = [];
    foreach my $openedFile ( @{$p4Output} )
    {
        # Perforce is a little inconsistent in its use of depotPath/depotFile/etc
#        my $fileObj = P4::OO::File->new( 'depotPath'  => $openedFile->{'depotFile'},
#                                       'clientPath' => $openedFile->{'clientFile'},
#                                       'rev'        => $openedFile->{'rev'},
#                                     );
        my $fileObj = P4::OO::File->new( $openedFile );

        push( @{$fileList}, $fileObj );
    }

    my $p4FileSet = P4::OO::FileSet->new();
    $p4FileSet->addObjects( @{$fileList} );

    return( $p4FileSet );
}


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::Client is Copyright (c)2010-2011, David L. Armstrong.

 This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself, either Perl
version 5.8.8 or, at your option, any later version of Perl 5
you may have available.

=head1 SUPPORT AND WARRANTY

 This program is distributed in the hope that it will be
useful, but it is provided "as is" and without any expressed
or implied warranties.

=cut

1;
