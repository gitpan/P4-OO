######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4:OO::_Set.pm
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
    package P4::OO::_Set;
    our $VERSION = '0.00_02';
    use base 'P4::OO';
    use strict;


######################################################################
# Globals
#


######################################################################
# Methods
#


sub addObjects
{
    my $self = shift();
    my( @addObjects ) = @_;

    my $setHash = $self->_getAttr( '_setHash' );
    my $setList = $self->_getAttr( '_setList' );

    if( ! defined( $setHash ) )
    {
        $setHash = $self->_setAttr( '_setHash', {} );
        $setList = $self->_setAttr( '_setList', [] );
    }

    my $addedCount = 0;

    foreach my $object ( @addObjects )
    {
        if( ! UNIVERSAL::isa( $object, "P4::OO" ) )
        {
            throw E_Fatal( __PACKAGE__ . " can only be used to store P4::OO objects.\n" );
        }

        # If the object is a Set, dump the members of the Set onto the list instead
#TODO - what about a Set of Sets?
        if( UNIVERSAL::isa( $object, 'P4::OO::_Set' ) )
        {
            push( @addObjects, $object->listObjects() );
            next;
        }

        my $objectID = $object->_uniqueID();

        if( exists( $setHash->{$objectID} ) )
        {
            # ignore any objects we already have
            next;
        }

        push( @{$setList}, $object );
        $setHash->{$objectID} = $object;
        $addedCount++;
    }

    return( $addedCount );
}


sub listObjects
{
    my $self = shift();

    my $setList = $self->_getAttr( '_setList' );
    if( ! defined( $setList ) )
    {
        $setList = [];
    }

    # Try to provide calling flexibility here... this might not be a good thing.
    return( @{$setList} );
}

sub listObjectIDs
{
    my $self = shift();

    return( map { $_->_uniqueID() } ( $self->listObjects() ) );
}


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::_Set is Copyright (c)2010-2011, David L. Armstrong.

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
