######################################################################
#  Copyright (c)2010-2011, David L. Armstrong.
#
#  P4::OO::File.pm
#
#  See COPYRIGHT AND LICENSE section in pod text below for usage
#   and distribution rights.
#
######################################################################

=head1 NAME

P4::OO::File

=head1 SYNOPSIS

 Represent a versioned Perforce file.

=head1 DESCRIPTION

 P4::OO::File tracks special attributes of files versioned by Perforce,
such as version.

=cut


######################################################################
# Package Initialization
#
    package P4::OO::File;
    our $VERSION = '0.00_02';
    use base 'P4::OO';
    use strict;


######################################################################
# Globals
#


######################################################################
# Methods
#


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::File is Copyright (c)2010-2011, David L. Armstrong.

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
