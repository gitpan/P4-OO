######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::_Base.pm
#
#  See COPYRIGHT AND LICENSE section in pod text below for usage
#   and distribution rights.
#
######################################################################

=head1 NAME

P4::OO::_Base - Base class for all P4::OO objects

=head1 SYNOPSIS

 use base 'P4::OO::_Base';

=head1 DESCRIPTION

 P4::OO::_Base functions only as a base class, providing the following:

=head2 Attribute Handling

 _getAttr(), _setAttr(), _delAttr(), _listAttrs()

=head2 Option Handling

 _argsToHash()

=head2 Exception handling and basic hierarchy

 Exceptions are provided by the P4::OO::_Error decorator.

=cut


######################################################################
# Package Initialization
#
    package P4::OO::_Base;
    our $VERSION = '0.00_01';

    # Import exception methods and hierarchy
    use P4::OO::_Error;

    # Standard Stuff
    use strict;
    use warnings;

    # For _uniqueID()
    require Scalar::Util;


######################################################################
# Methods
#
sub new
{
    my $proto = shift;
    my $class = ref( $proto ) || $proto;
 
    my $self = {};
    bless( $self, $class );
 
    my $subName = ( caller( 0 ) )[3];
    $self->{'_objAttrs'} = $self->_argsToHash( $subName, @_ );
    
    return( $self );
}



sub _uniqueID
{
    my $self = shift();

    return( Scalar::Util::refaddr( $self ) );
}


sub _printDebug
{
    my $self = shift();

    if( ( $self->_getAttr( 'debugFlag' ) )
     || ( $ENV{'P4OO_DEBUG'} ) )
    {
        foreach my $debugLine ( @_ )
        {
            chomp( $debugLine );
            print "DEBUG: $debugLine\n";
        }
    }
}


sub _getAttr
{
    return( $_[0]->{'_objAttrs'}->{$_[1]} );
}


sub _setAttr
{
    return( $_[0]->{'_objAttrs'}->{$_[1]} = $_[2] );
}

sub _setAttrs
{
    my $self = shift();
    my $subName = ( caller( 0 ) )[3];
    my $argsHash = $self->_argsToHash( $subName, @_ );

    return( map { $self->{'_objAttrs'}->{$_} = $argsHash->{$_} } ( keys( %{$argsHash} ) ) );
}

sub _delAttr
{
    return( delete( $_[0]->{'_objAttrs'}->{$_[1]} ) );
}


sub _listAttrs
{
    return( keys( %{$_[0]->{'_objAttrs'}} ) );
}


######################################################################
# _argsToHash
#
# _argsToHash takes the arguments passed in and constructs a hash
# of name/value pairs from them, returning a reference to the hash.
#
# This is a helper method intended to make it simple for functions
# to accept name/value pair arguments in a consistent and easy way.
#
# If the same name is specified more than once when called in a list
# or ARRAYref form, the resulting value will be an ARRAYref of the
# values.
#
# Values are preserved as-is, so any reference values are simply
# copied, not dereferenced in any way.
#
# This method expects to be called on an object, not a class, and
# may try to recurse on itself, so an object inheriting this method
# must be used.  No object state is changed in this method.
#
# For more helpful exceptions, the first argument required is the
# name of the caller, and will be used in the exception text.
#
# Each of these will return the same result:
#   $self->_argsToHash( $callerName, 'name1', 'value1', 'name2', 'value2' );
#   $self->_argsToHash( $callerName, [ 'name1', 'value1', 'name2', 'value2' ] );
#   $self->_argsToHash( $callerName, { 'name1' => 'value1', 'name2' => 'value2' } );
#
######################################################################
sub _argsToHash
{
    my $self = shift();
    my( $caller, @argsIn ) = @_;

    my $argsHashOut = {};

    if( scalar( @argsIn ) == 0 )
    {
        # Nothing to see here...
        return( $argsHashOut );
    }
    elsif( scalar( @argsIn ) % 2 == 0 )
    {
        # Even number of args, so must be a list call - process duplicates

        # Keep track of args first seen as ARRAYrefs so we do break them down
        my $arrayRefsSeen = {};

        while( scalar( @argsIn ) )
        {
            my $name = shift( @argsIn );
            my $value = shift( @argsIn );

            if( exists( $argsHashOut->{$name} ) )
            {
                if( exists( $arrayRefsSeen->{$name} ) )
                {
                    # We saw it first as an ARRAYref, so we just make a new ref.
                    $argsHashOut->{$name} = [ $argsHashOut->{$name}, $value ];
                    delete( $arrayRefsSeen->{$name} );
                }
                else
                {
                    # We've seen it before, and maybe more than once!
                    if( UNIVERSAL::isa( $argsHashOut->{$name}, "ARRAY" ) )
                    {
                        push( @{$argsHashOut->{$name}}, $value );
                    }
                    else
                    {
                        $argsHashOut->{$name} = [ $argsHashOut->{$name}, $value ];
                    }
                }
            }
            else
            {
                $argsHashOut->{$name} = $value;

                if( UNIVERSAL::isa( $value, "ARRAY" ) )
                {
                    $arrayRefsSeen->{$name} = 1;
                }
            }
        }
    }
    elsif( scalar( @argsIn ) == 1 )
    {
        if( UNIVERSAL::isa( $argsIn[0], "ARRAY" ) )
        {
            # Called with ARRAYref, so just call self recurively with deref
            return( $self->_argsToHash( $caller, @{$argsIn[0]} ) );
        }
        elsif( UNIVERSAL::isa( $argsIn[0], "HASH" ) )
        {
            # For now we'll copy it, but could be bad for performance...
            %{$argsHashOut} = %{$argsIn[0]};
        }
    }
    else
    {
        throw E_Fatal "$caller: Invalid arguments.\n";
    }

    return( $argsHashOut );
}


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::_Base is Copyright (c)2010-2011, David L. Armstrong.

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
