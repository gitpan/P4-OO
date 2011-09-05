use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'P4::OO',
    VERSION_FROM      => 'lib/P4/OO.pm', # finds $VERSION
    PREREQ_PM         => { 'P4' => undef,
                           'Test::More' => undef,
                           'Test::Exception' => undef,
                           'Error::Simple' => 0,
                           'Exception::Class' => 0,
                           'Readonly' => 0,
                           'Scalar::Util' => 0,
                         }, # e.g., Module::Name => 1.1
    PL_FILES          => {},  # Don't execute any .PL files in module root
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/P4/OO.pm', # retrieve abstract from module
       AUTHOR         => 'David L. Armstrong <armstd@cpan.org>') : ()),
);
