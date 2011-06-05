######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::_Error.pm
#
#  See COPYRIGHT AND LICENSE section in pod text below for usage
#   and distribution rights.
#
######################################################################


=head1 NAME

P4::OO::_Error - Exception hierarchy and handling decorator class

=head1 SYNOPSIS

 use P4::OO::_Error;

=head1 DESCRIPTION

 P4::OO::_Error is not intended to be used directly.  It is only
inteded to be used by P4::OO subclasses that inherit this
functionality from P4::OO.

=cut


######################################################################
# Package Initialization
#
    package P4::OO::_Error;
    our $VERSION = '0.00_01';

    use Error::Simple;
    use base qw( Exporter Error::Simple );

    # We'll re-export the try/catch/ignore/otherwise methods so
    # none of the subclasses need to worry about them.
    use Error qw( :try );
    use vars qw( @EXPORT @EXPORT_OK %EXPORT_TAGS );
    @EXPORT      = qw( try otherwise with finally except );
    @EXPORT_OK   = @EXPORT;
    %EXPORT_TAGS = ( try => \@EXPORT_OK );

    # This gets us the simpler Error::Simple style exceptions
    BEGIN { $Exception::Class::BASE_EXC_CLASS = 'P4::OO::_Error' }

    # Set up our exception hierarchy
    use Exception::Class
        ( 'E_Exception',
          'E_Fatal'        =>  { 'isa'         => 'E_Exception',
                                 'description' => 'Generic Error - Fatal',
                               },
          'E_Warning'      =>  { 'isa'         => 'E_Exception',
                                 'description' => 'Generic Error - Warning',
                               },
          'E_BadSubClass'   => { 'isa'         => 'E_Fatal',
                                 'description' => 'Subclass does not comform to interface spec or cannot be found',
                               },
          'E_P4Exception'   => { 'isa'         => 'E_Exception'
                               },
          'E_P4Fatal'       => { 'isa'         => 'E_Fatal',
                                 'description' => 'Generic Internal Error.',
                               },
          'E_P4Warning'     => { 'isa'         => 'E_Warning',
                                 'description' => 'Generic Internal Warning.',
                               },
        );


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::_Error is Copyright (c)2010-2011, David L. Armstrong.

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
