######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::_Connection.pm
#
#  See COPYRIGHT AND LICENSE section in pod text below for usage
#   and distribution rights.
#
######################################################################

=head1 NAME

P4::OO::_Connection - P4::OO interface to P4PERL

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ENVIRONMENT

=head1 SEE ALSO

=cut

######################################################################
# Package Initialization
#
    package P4::OO::_Connection;
    our $VERSION = '0.00_01';
    use strict;
    use base ( 'P4::OO' );


######################################################################
# Includes
#
    use P4::OO::_Error;

######################################################################
# Globals
#

######################################################################
# Methods
#

sub query
{
    throw E_P4Fatal "Connection subclass doesn't support query() method.\n";
    
}

sub readSpec
{
    throw E_P4Fatal "Connection subclass doesn't support readSpec() method.\n";
    
}

sub saveSpec
{
    throw E_P4Fatal "Connection subclass doesn't support saveSpec() method.\n";
}

######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::_Connection is Copyright (c)2010-2011, David L. Armstrong.

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