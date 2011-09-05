######################################################################
#  Copyright (c)2011, David L. Armstrong.
#
#  P4::OO::Changelist.pm
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
    package P4::OO::Changelist;
    our $VERSION = '0.00_02';
    use base 'P4::OO::Change';
    use strict;


######################################################################
# Globals
#
    # Subclasses must define SPECOBJ_TYPE
    sub SPECOBJ_TYPE { return( 'changelist' ); }


######################################################################
#
# P4::OO::Changelist is just a stub, P4::OO::Change does all the work
#
######################################################################

######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::Changelist is Copyright (c)2011, David L. Armstrong.

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
