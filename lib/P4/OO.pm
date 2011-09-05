######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO.pm
#
#  See COPYRIGHT AND LICENSE section in pod text below for usage
#   and distribution rights.
#
######################################################################

=head1 NAME

P4::OO - First class objects for Perforce specs

=head1 SYNOPSIS

 # use P4PERL and P4PORT/P4CLIENT environment by default
 my $p4oo = P4::OO->new();

=head1 ENVIRONMENT

 P4::OO requires P4PERL to talk directly to Perforce

 P4::OO uses reasonable defaults, and using the caller's P4PORT
and P4CLIENT environment variables to find the Perforce client to use.

=head1 DESCRIPTION

 P4::OO is distinguished from P4PERL in that P4PERL provides a
handle for talking to Perforce in a manner similar to the 'p4'
command.  P4::OO represents Perforce specs as first class objects
(similar to type-specific versions of P4::Spec objects),
and provides capability for added functionality for each type of
object.

=head2 First Class Objects

 These objects are provided and corresspond directly to the 'p4'
subcommands by the same names:
 P4:OO::Branch
 P4:OO::Change
 P4:OO::Changelist - P4:OO::Change by another name.
 P4:OO::Client
 P4:OO::Depot
 P4:OO::Group
 P4:OO::Job
 P4:OO::Label
 P4:OO::User
 P4:OO::Workspace - P4:OO::Client by another name.

=head2 Connecting P4::OO to your Perforce database

 If you initialize your own P4PERL connection, you can have P4::OO
use it instead of constructing it's own.  You will also have to
disconnect it when you're done.  If P4:OO constructs it's
own P4PERL connection, P4::OO will also attempt to destroy it at
garbage collection time.

 # Connect to P4PERL and have have P4::OO reuse connection
 my $p4PerlObj = P4->new();
 $p4PerlObj->SetClient( $clientname );
 $p4PerlObj->SetPort ( $p4port );
 $p4PerlObj->Connect();

 # Initialize P4::OO with this P4PERL connection
 my $p4ooObj = P4::OO->new( 'p4PerlObj' => $p4PerlObj );

 # When you're done with P4::OO and your P4PERL connection
 $p4PerlObj->Disconnect();


=head1 SEE ALSO

 P4PERL - http://public.perforce.com/guest/tony_smith/perforce/API/Perl/index.html

=cut

######################################################################
# Package Initialization
#
    package P4::OO;
    our $VERSION = '0.00_02';

    # bring in the _getAttr/_setAttr methods for our use
    use base 'P4::OO::_Base';

    # Import exception methods and hierarchy for all of our subclasses
    use P4::OO::_Error;


######################################################################
# Globals
#


######################################################################
# Public Methods
#


######################################################################
# Internal Methods
#

sub _getP4Connection
{
    my $self = shift();

    my $p4Conn = $self->_getAttr( '_p4Conn' );

    if( ! defined( $p4Conn ) )
    {   
        require P4::OO::_Connection;

        my $p4PerlObj = $self->_getAttr( 'p4PerlObj' );

        if( defined( $p4PerlObj ) )
        {
            # P4PERL takes precedence
            require P4::OO::_Connection::P4PERL;
            $p4Conn = P4::OO::_Connection::P4PERL->new( 'p4PerlObj' => $self->_getAttr( 'p4PerlObj' ) );
        }
        else
        {
            # P4PERL is also the default
            require P4::OO::_Connection::P4PERL;
            $p4Conn = P4::OO::_Connection::P4PERL->new();
        }

        $self->_setAttr( '_p4Conn', $p4Conn );
    }

    return( $p4Conn );
}


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO is Copyright (c)2010-2011, David L. Armstrong.

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
