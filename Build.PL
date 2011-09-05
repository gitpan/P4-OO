use Module::Build;

my $build = Module::Build->new
    (
     'module_name' => 'P4::OO',
     'author'   => 'David L. Armstrong <armstd@cpan.org>',
     'license'  => 'perl',
     'requires' => {
                     'perl'             => '5.8.8',
                     'Error::Simple'    => 0,
                     'Exception::Class' => 0,
                     'Readonly' => 0,
                     'Scalar::Util' => 0,
                     'P4' => 0,
                   },
     'configure_requires' => {
                               'Module::Build' => 0.38,
                             },
     'build_requires' => {
                           'Test::More' => 0,
                           'Test::Exception' => 0,
                         },
    );
$build->create_build_script;
