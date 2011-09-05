######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::_SpecObj.pm
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
    package P4::OO::_SpecObj;
    our $VERSION = '0.00_02';
    use base 'P4::OO';
    use strict;


######################################################################
# Globals
#
    # Not listed here, but we leverage the P4::OO Class Global
    # P4::OO::PERFORCE_TRANSLATION_TABLE also

    # Subclasses must define SPECOBJ_TYPE
    sub SPECOBJ_TYPE { return( undef ); }


######################################################################
# Methods
#

sub _uniqueID
{
    my $self = shift();

    return( $self->_getSpecID() );
}

sub _getSpecID
{
    my $self = shift();

    my $specID = $self->_getAttr( 'id' );

    if( ! defined( $specID ) )
    {
        $self->__initialize();
        $specID = $self->_getAttr( 'id' );
    }

    # If specID is still undef, oh well.
    return( $specID );
}

sub _getSpecAttr
{
    my $self = shift();
    my( $attrName ) = @_;
    my $subName = ( caller( 0 ) )[3];

    if( ! defined( $attrName ) )
    {
        my $caller = ( caller( 1 ) )[3];
        throw E_P4Fatal "$subName: attrName not specified by $caller.\n";
    }

    # Make sure the spec is loaded
    $self->__initialize();
    my $p4Spec = $self->_getAttr( 'p4Spec' );

    # Allow the caller to use any case for the spec attribute
    my $lcAttrName = lc( $attrName );

    # P4PERL (and all P4::OO::_Connection subclasses) provide the _fields_
    # hash as an index to find the actual attribute key using all lowercase
    if( ! exists( $p4Spec->{'_fields_'}->{$lcAttrName} ) )
    {
        my $specType = $self->SPECOBJ_TYPE();
        throw E_P4Fatal "$subName: Invalid Spec attribute $attrName for type $specType.\n";
    }

    my $p4AttrName = $p4Spec->{'_fields_'}->{$lcAttrName};

    if( exists( $p4Spec->{$p4AttrName} ) )
    {
        # Avoid autovivification against P4::Spec objects
        return( $p4Spec->{$p4AttrName} );
    }

    return( undef );
}

sub _setSpecAttr
{
    my $self = shift();

    # Make sure the spec is loaded
    $self->__initialize();
        
#TODO...
}

######################################################################
# Internal (private) methods
# 
sub __initialize
{
    my $self = shift();

    my $p4Spec = $self->_getAttr( 'p4Spec' );
    if( ! defined( $p4Spec ) )
    {
        # Need to ask our connection to download the spec for us.
        my $specID = $self->_getAttr( 'id' );

        # Need to ask our connection to download spec for us.
        my $p4ConnObj = $self->_getP4Connection();
        my $p4Spec = $p4ConnObj->readSpec( $self );
    }

    return( $p4Spec );
}

######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::_SpecObj is Copyright (c)2010-2011, David L. Armstrong.

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
