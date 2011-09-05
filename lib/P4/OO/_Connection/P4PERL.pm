######################################################################
#  Copyright (c)2011, David L. Armstrong.
#
#  P4::OO::_Connection::P4PERL.pm
#
#  See COPYRIGHT AND LICENSE section in pod text below for usage
#   and distribution rights.
#
######################################################################

=head1 NAME

P4::OO::_Connection::P4PERL - P4::OO interface to P4PERL

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ENVIRONMENT

=head1 SEE ALSO

=cut

######################################################################
# Package Initialization
#
    package P4::OO::_Connection::P4PERL;
    our $VERSION = '0.00_02';
    use strict;
    use base ( 'P4::OO::_Connection' );


######################################################################
# Includes
#
    use Readonly;


######################################################################
# Globals
#
    # P4PERL_SPEC_COMMANDS helps make the somwhat inconsistent
    # Perforce output fall into neatly defined and consistent objects
    Readonly my %P4PERL_SPEC_COMMANDS => {
                'branch' => { 'specCmd'      => 'branch',
                              'singularID'   => 'branch',
                              'queryCmd'     => 'branches',
                              'pluralID'     => 'branch',
                              'idAttr'       => 'branch',
                              'p4ooType'     => 'P4::OO::Branch',
                              'pluralType'   => 'P4::OO::BranchSet',
                              'queryOptions' => { 'user'       => [ '-u', 1 ],
                                                  'nameFilter' => [ '-e', 1 ],
                                                },
                            },
                'change' => { 'specCmd'      => 'change',
                              'singularID'   => 'change',
                              'queryCmd'     => 'changes',
                              'pluralID'     => 'change',
                              'idAttr'       => 'change',
                              'p4ooType'     => 'P4::OO::Change',
                              'pluralType'   => 'P4::OO::ChangeSet',
                              'queryOptions' => { 'client' => [ '-c', 1 ],
                                                  'status' => [ '-s', 1 ],
                                                  'user'   => [ '-u', 1 ],
                                                  'files'  => undef,
                                                },
                            },
                # Changelist is the same as Change
                'changelist' => { 'specCmd'      => 'change',
                                  'singularID'   => 'change',
                                  'queryCmd'     => 'changes',
                                  'pluralID'     => 'change',
                                  'idAttr'       => 'change',
                                  'p4ooType'     => 'P4::OO::Change',
                                  'pluralType'   => 'P4::OO::ChangeSet',
                                  'queryOptions' => { 'client' => [ '-c', 1 ],
                                                      'status' => [ '-s', 1 ],
                                                      'user'   => [ '-u', 1 ],
                                                      'files'  => undef,
                                                    },
                                },
                'client' => { 'specCmd'      => 'client',
                              'singularID'   => 'client',
                              'queryCmd'     => 'clients',
                              'pluralID'     => 'client',
                              'idAttr'       => 'client',
                              'p4ooType'     => 'P4::OO::Client',
                              'pluralType'   => 'P4::OO::ClientSet',
                              'queryOptions' => { 'user'       => [ '-u', 1 ],
                                                  'nameFilter' => [ '-e', 1 ],
                                                },
                            },
                # Workspace is the same as Client
                'workspace' => { 'specCmd'      => 'client',
                                 'singularID'   => 'client',
                                 'queryCmd'     => 'clients',
                                 'pluralID'     => 'client',
                                 'idAttr'       => 'client',
                                 'p4ooType'     => 'P4::OO::Client',
                                 'pluralType'   => 'P4::OO::ClientSet',
                                 'queryOptions' => { 'user'       => [ '-u', 1 ],
                                                     'nameFilter' => [ '-e', 1 ],
                                                   },
                               },
                 'depot' => { 'specCmd'      => 'depot',
                              'singularID'   => 'depot',
                              'queryCmd'     => 'depots',
                              'pluralID'     => 'name',
                              'idAttr'       => 'depot',
                              'p4ooType'     => 'P4::OO::Depot',
                              'pluralType'   => 'P4::OO::DepotSet',
                              'queryOptions' => {},
                            },
                 'group' => { 'specCmd'      => 'group',
                              'singularID'   => 'group',
                              'queryCmd'     => 'groups',
                              'pluralID'     => 'group',
                              'idAttr'       => 'group',
                              'p4ooType'     => 'P4::OO::Group',
                              'pluralType'   => 'P4::OO::GroupSet',
                              'queryOptions' => { 'user'  => undef,
                                                  'group' => undef,
                                                },
                            },
                   'job' => { 'specCmd'      => 'job',
                              'singularID'   => 'job',
                              'queryCmd'     => 'jobs',
                              'pluralID'     => 'job',
                              'idAttr'       => 'job',
                              'p4ooType'     => 'P4::OO::Job',
                              'pluralType'   => 'P4::OO::JobSet',
                              'queryOptions' => { 'jobview' => [ '-e', 1 ],
                                                  'files'   => undef,
                                                },
                            },
                 'label' => { 'specCmd'      => 'label',
                              'singularID'   => 'label',
                              'queryCmd'     => 'labels',
                              'pluralID'     => 'label',
                              'idAttr'       => 'label',
                              'p4ooType'     => 'P4::OO::Label',
                              'pluralType'   => 'P4::OO::LabelSet',
                              'queryOptions' => { 'user'  => [ '-u', 1 ],
                                                  'name'  => [ '-e', 1 ],
                                                  'files' => undef,
                                                },
                            },
                  'user' => { 'specCmd'      => 'user',
                              'singularID'   => 'user',
                              'queryCmd'     => 'users',
                              'pluralID'     => 'User',
                              'idAttr'       => 'user',
                              'p4ooType'     => 'P4::OO::User',
                              'pluralType'   => 'P4::OO::UserSet',
                              'queryOptions' => { 'users'  => undef,
                                                },
                            },
              };


# other p4 commands that don't return specs natively
    Readonly my %P4PERL_OTHER_COMMANDS => {
#                'counter' => { 'specCmd'      => 'counter',
#                               'singularID'   => 'counter',
#                               'queryCmd'     => 'counters',
#                               'pluralID'     => 'counter',
#                               'idAttr'       => 'counter',
##subcommands:
## increment
## delete
## set
#                            },

                # p4 describe [-d<flags> -s -S -f] changelist# ...
                'describe' => { 'queryOptions' => { 'diffOptions' => { 'option' => '-d',
                                                                       'bundledArgs' => 1,
                                                                       'multiplicity' => 1,
                                                                     },
                                                    'changes' => { 'type' => [ 'string',
                                                                               'P4::OO::Change',
                                                                               'P4::OO::ChangeSet',
                                                                             ],
                                                                 },
                                                    'omitDiffs' => { 'option' => '-s',
                                                                     'multiplicity' => 0,
                                                                   },
                                                    'shelved' => { 'option' => '-S',
                                                                   'multiplicity' => 0,
                                                                 },
                                                    'force' => { 'option' => '-f',
                                                                 'multiplicity' => 0,
                                                               },
                                                  },
                              },

                # p4 files [ -a ] [ -A ] [ -m max ] file[revRange] ...
                'files' => { 'queryOptions' => { 'allRevisions' => { 'option' => '-a',
                                                                     'multiplicity' => 0,
                                                                   },
                                                  'archived' => { 'option' => '-A',
                                                                  'multiplicity' => 0,
                                                                },
                                                  'max' => { 'option' => '-m',
                                                             'type' => [ 'string' ],
                                                             'multiplicity' => 1,
                                                           },
                                                  'files' => { 'type' => [ 'string',
                                                                           'P4::OO::File',
                                                                           'P4::OO::FileSet',
                                                                         ],
                                                             },
                                               },
                             'output' => { 'pluralType'   => 'P4::OO::FileSet',
                                           'pluralID'  => 'depotFile',
                                           'singularType' => 'P4::OO::File',
                                           'singularID' => 'depotFile',
                                         },
                           },

                # p4 have [file ...]
                'have' => { 'queryOptions' => { 'files' => { 'type' => [ 'string',
                                                                          'P4::OO::File',
                                                                          'P4::OO::FileSet',
                                                                        ],
                                                            },
                                               },
                            'output' => { 'pluralType'   => 'P4::OO::FileSet',
                                          'pluralID'  => 'depotFile',
                                          'singularType' => 'P4::OO::File',
                                          'singularID' => 'depotFile',
                                        },
                           },

                # p4 info [-s]
                'info' => { 'queryOptions' => { 'shortOutput' => { 'option' => '-s',
                                                                   'multiplicity' => 0,
                                                                 },
                                              },
                              },
                # p4 opened [-a -c changelist# -C client -u user -m max] [file ...]
                'opened' => { 'queryOptions' => { 'allClients' => { 'option' => '-a',
                                                                    'multiplicity' => 0,
                                                                  },
                                                  'change' => { 'option' => '-c',
                                                                'type' => [ 'string',
                                                                            'P4::OO::Change',
                                                                            'P4::OO::ChangeSet',
                                                                          ],
                                                                'multiplicity' => 1,
                                                              },
                                                  'client' => { 'option' => '-C',
                                                                'type' => [ 'string',
                                                                            'P4::OO::Client',
                                                                            'P4::OO::ClientSet',
                                                                          ],
                                                                'multiplicity' => 1,
                                                              },
                                                  'user' => { 'option' => '-u',
                                                              'type' => [ 'string',
                                                                          'P4::OO::User',
                                                                          'P4::OO::UserSet',
                                                                        ],
                                                              'multiplicity' => 1,
                                                            },
                                                  'max' => { 'option' => '-m',
                                                             'type' => [ 'string' ],
                                                             'multiplicity' => 1,
                                                           },
                                                  'files' => { 'type' => [ 'string',
                                                                           'P4::OO::File',
                                                                           'P4::OO::FileSet',
                                                                         ],
                                                             },
                                                },
                              'output' => { 'pluralType'   => 'P4::OO::FileSet',
                                            'pluralID'  => 'clientFile',
                                            'singularType' => 'P4::OO::File',
                                            'singularID' => 'clientFile',
                                          },
                            },
              };


######################################################################
# Methods
#

sub readSpec
{
    my $self = shift();
    my( $specObj ) = @_;

    my $specType = $specObj->SPECOBJ_TYPE();
    my $specID = $specObj->_getAttr( 'id' );

    if( ! exists( $P4PERL_SPEC_COMMANDS{$specType} ) )
    {
        throw E_P4Fatal "Unsupported Spec type '$specType'.\n";
    }

    my $specCmd = $P4PERL_SPEC_COMMANDS{$specType}->{'specCmd'};
    my $p4Output = $self->_execCmd( $specCmd, "-o", $specID );

    # Only care about the first output result (there's only one)
    my $p4Spec = $p4Output->[0];
    $specObj->_setAttr( 'p4Spec', $p4Spec );

    if( ! defined( $specID ) )
    {
        # We'll reset the object's specID if it was not defined.
        my $singularID = $P4PERL_SPEC_COMMANDS{$specType}->{'singularID'};

        # At this point the SpecObj is initialized enough for this to work...
# TODO This is REALLY awkward... a paradox???  Chicken, meet egg.
        $specObj->_setAttr( 'id', $specObj->_getSpecAttr( $singularID ) );
    }

    return( 1 );
}

sub saveSpec
{
    my $self = shift();
    my( $specType, $specID ) = @_;

    if( ! exists( $P4PERL_SPEC_COMMANDS{$specType} ) )
    {
        throw E_P4Fatal "Unsupported Spec type '$specType'.\n";
    }

    my $p4Out = $self->_execCmd( 'clients' );
#TODO...

}

sub query
{
    my $self = shift();
    my( $specType, @inputFilter ) = @_;
    my $subName = ( caller( 0 ) )[3];

    if( ! exists( $P4PERL_SPEC_COMMANDS{$specType} ) )
    {   
        throw E_P4Fatal "$subName: Invalid query type.\n";
    }

    my $inputFilterHash = $self->_argsToHash( $subName, @inputFilter );

    my $allowedFilters = $P4PERL_SPEC_COMMANDS{$specType}->{'queryOptions'};

    my @execArgs;
    foreach my $origFilterKey ( keys( %{$inputFilterHash} ) )
    {
        my $lcFilterKey = lc( $origFilterKey );
        if( ! exists( $allowedFilters->{$lcFilterKey} ) )
        {
            throw E_P4Fatal "$subName: Invalid filter key: $origFilterKey.\n";
        }

        if( ! defined( $allowedFilters->{$lcFilterKey} ) )
        {
            # For undef filter options, we'll push them onto the end of the command.
            push( @execArgs, $inputFilterHash->{$origFilterKey} );
        }
        else
        {
            # defined cmdline options go at the front
            if( $allowedFilters->{$lcFilterKey}->[1]
             && ! defined( $inputFilterHash->{$origFilterKey} ) )
            {
                throw E_P4Fatal "$subName: Filter key: $origFilterKey requires argument.\n";
            }
            unshift( @execArgs, $allowedFilters->{$lcFilterKey}->[0], $inputFilterHash->{$origFilterKey} );
        }
    }

    my $queryCmd = $P4PERL_SPEC_COMMANDS{$specType}->{'queryCmd'};
    my $pluralSpecID = $P4PERL_SPEC_COMMANDS{$specType}->{'pluralID'};
    my $p4ooType = $P4PERL_SPEC_COMMANDS{$specType}->{'p4ooType'};
    my $pluralType = $P4PERL_SPEC_COMMANDS{$specType}->{'pluralType'};
    my $idAttr = $P4PERL_SPEC_COMMANDS{$specType}->{'idAttr'};

    my $p4Out = $self->_execCmd( $queryCmd, @execArgs );

    # Make sure the caller is properly equipped to use any objects
    # we bless here.
    require P4::OO::_Set;
    require P4::OO::_SpecObj;
    eval "require $p4ooType;";
    eval "require $pluralType;";

    my $objectList = [];

    # Don't really care about the content of the output, just the specIDs.
    foreach my $p4OutHash ( @{$p4Out} )
    {   
        if( ! exists( $p4OutHash->{$pluralSpecID} ) )
        {   
            throw E_P4Fatal "Unexpected output from Perforce.\n";
        }

        # Copy the pluralID output value to the id attribute
        #  if they aren't one and the same already
        if( $idAttr ne $pluralSpecID )
        {   
            $p4OutHash->{$idAttr} = $p4OutHash->{$pluralSpecID};
        }

        # HACK - Instead of eval'ing this through the type's
        # constructor, we'll just use the base class and bless
        my $specObj = P4::OO::_SpecObj->new( 'p4Spec'  => $p4OutHash,
                                             'id'      => $p4OutHash->{$pluralSpecID},
                                             '_p4Conn' => $self, # Make sure each of these objects can reuse this conection too
                                           );
        bless( $specObj, $p4ooType );
        push( @{$objectList}, $specObj );
    }

    # Wrap it with a bow
    my $setObj = P4::OO::_Set->new( '_p4Conn', $self );
    bless( $setObj, $pluralType );
    $setObj->addObjects( @{$objectList} );

    return( $setObj );
}

sub runCommand
{
    my $self = shift();
    my( $cmdName, @inputFilter ) = @_;
    my $subName = ( caller( 0 ) )[3];

    if( ! exists( $P4PERL_OTHER_COMMANDS{$cmdName} ) )
    {   
        throw E_P4Fatal "$subName: Invalid command.\n";
    }

    my $inputFilterHash = $self->_argsToHash( $subName, @inputFilter );

    my $allowedFilters = $P4PERL_OTHER_COMMANDS{$cmdName}->{'queryOptions'};

    my @execArgs;
    foreach my $origFilterKey ( keys( %{$inputFilterHash} ) )
    {
        my $lcFilterKey = lc( $origFilterKey );
        if( ! exists( $allowedFilters->{$lcFilterKey} ) )
        {
            throw E_P4Fatal "$subName: Invalid filter key: $origFilterKey.\n";
        }

        my @optionArgs;
        if( defined( $inputFilterHash->{$origFilterKey} ) )
        {
            if( ref( $inputFilterHash->{$origFilterKey} ) eq "ARRAY" )
            {
                push( @optionArgs, @{$inputFilterHash->{$origFilterKey}} );
            }
            else
            {
                push( @optionArgs, $inputFilterHash->{$origFilterKey} );
            }
        }

        # Check option argument types, and replace option args with IDs for P4::OO objects passed in
        # Take the opportunity to expand any Set objects we find.
        my @cmdOptionArgs;
        if( defined( $allowedFilters->{$lcFilterKey}->{'type'} ) )
        {
            # Check type on each argument
            ARG: foreach my $optionArg ( @optionArgs )
            {
                foreach my $checkType ( @{$allowedFilters->{$lcFilterKey}->{'type'}} )
                {
                    if( $checkType eq "string"
                     && ref( $optionArg ) eq "" )
                    {
                        push( @cmdOptionArgs, $optionArg );
                        next ARG;
                    }
                    elsif( UNIVERSAL::isa( $optionArg, $checkType ) )
                    {
                        # Special Set expansion...this gets weird, eh?
                        if( UNIVERSAL::isa( $optionArg, "P4::OO::_Set" ) )
                        {
                            # Here we assume the set contents are kosher.
                            push( @cmdOptionArgs, $optionArg->listObjectIDs() );
                        }
                        else
                        {
                            push( @cmdOptionArgs, $optionArg->_uniqueID() );
                        }
                        next ARG;
                    }
                }

                # Looped through all types, didn't find a match
                throw E_P4Fatal "$subName: Filter key: $origFilterKey accepts arguments of only these types: " . join( ", ", @{$allowedFilters->{$lcFilterKey}->{'type'}} ) . ".\n";
            }
        }

        # defined cmdline options go at the front
        if( $allowedFilters->{$lcFilterKey}->{'multiplicity'} == 0 )
        {
            if( scalar( @cmdOptionArgs ) != 0 )
            {
                throw E_P4Fatal "$subName: Filter key: $origFilterKey accepts no arguments.\n";
            }

            unshift( @execArgs, $allowedFilters->{$lcFilterKey}->{'option'} );
        }
        elsif( $allowedFilters->{$lcFilterKey}->{'multiplicity'} == 1 )
        {
            if( scalar( @cmdOptionArgs ) != 1 )
            {
                throw E_P4Fatal "$subName: Filter key: $origFilterKey accepts exactly 1 argument.\n";
            }

            if( $allowedFilters->{$lcFilterKey}->{'bundledArgs'} )
            {
                unshift( @execArgs, join( "", $allowedFilters->{$lcFilterKey}->{'option'}, @cmdOptionArgs ) );
            }
            else
            {
                unshift( @execArgs, $allowedFilters->{$lcFilterKey}->{'option'}, @cmdOptionArgs );
            }
        }
        else
        {
            if( defined( $allowedFilters->{$lcFilterKey}->{'option'} ) )
            {
                push( @execArgs, $allowedFilters->{$lcFilterKey}->{'option'} );
            }
            push( @execArgs, @cmdOptionArgs );
        }
    }

    my $p4Out = $self->_execCmd( $cmdName, @execArgs );


# TODO... subcommands?
#                'counter' => { 'specCmd'      => 'counter',
#                               'singularID'   => 'counter',
#                               'queryCmd'     => 'counters',
#                               'pluralID'     => 'counter',
#                               'idAttr'       => 'counter',
#     p4 counter name
#     p4 counter [-f] name value
#     p4 counter [-f] -d name
#     p4 counter [-i] name
#
##subcommands:
## increment
## delete
## set
#                            },

    # If no special output massaging is needed, we're done!
    if( ! $P4PERL_OTHER_COMMANDS{$cmdName}->{'output'} )
    {
        return( $p4Out );
    }

    my $pluralType = $P4PERL_OTHER_COMMANDS{$cmdName}->{'output'}->{'pluralType'};
    my $pluralID = $P4PERL_OTHER_COMMANDS{$cmdName}->{'output'}->{'pluralID'};
    my $singularType = $P4PERL_OTHER_COMMANDS{$cmdName}->{'output'}->{'singularType'};
    my $singularID = $P4PERL_OTHER_COMMANDS{$cmdName}->{'output'}->{'singularID'};


    # Make sure the caller is properly equipped to use any objects
    # we bless here.
    require P4::OO::_Set;
    require P4::OO::_SpecObj;
    eval "require $singularType;";
    eval "require $pluralType;";

    my $objectList = [];

    # Don't really care about the content of the output, just the specIDs.
    foreach my $p4OutHash ( @{$p4Out} )
    {   
        if( ! exists( $p4OutHash->{$pluralID} ) )
        {   
            throw E_P4Fatal "Unexpected output from Perforce.\n";
        }

        # Copy the pluralID output value to the id attribute
        #  if they aren't one and the same already
        if( $singularID ne $pluralID )
        {   
            $p4OutHash->{$singularID} = $p4OutHash->{$pluralID};
        }

        # HACK - Instead of eval'ing this through the type's
        # constructor, we'll just use the base class and bless
        my $specObj = P4::OO::_SpecObj->new( 'p4Spec'  => $p4OutHash,
                                             'id'      => $p4OutHash->{$pluralID},
                                             '_p4Conn' => $self, # Make sure each of these objects can reuse this conection too
                                           );
        bless( $specObj, $singularType );
        push( @{$objectList}, $specObj );
    }

    # Wrap it with a bow
    my $setObj = P4::OO::_Set->new( '_p4Conn', $self );
    bless( $setObj, $pluralType );
    $setObj->addObjects( @{$objectList} );

    return( $setObj );
}

######################################################################
# Internal Methods
#

# _execCmd() 
sub _execCmd
{
    my $self = shift();
    my( $p4SubCmd, @args ) = @_;
    my $subName = ( caller( 0 ) )[3];

#    $self->_printDebug( "$subName entered.\n" ); 

    my $p4PerlObj = $self->_connect();

    if( ! defined( $p4SubCmd ) )
    {
        throw E_P4Fatal( "$subName: called with invalid subcommand!" );
    }

    # strip undef args from the tail, P4PERL don't like them
    while( ! defined( $args[$#args] ) )
    {
        # maybe there aren't any args
        if( $#args == -1 )
        {
            last;
        }
        pop( @args );
    }

    $self->_printDebug( "$subName: Executing: " . join( " ", $p4SubCmd, @args ) );

#TODO ping server before each command?
    my $p4Out = $p4PerlObj->Run( $p4SubCmd, @args );

#TODO Should do something to detect disconnects, etc.
    # If we have errors and warnings, we want to give both to caller

    if( $p4PerlObj->ErrorCount() > 0 )
    {
        my $errMsg = "ERROR: " . join( "", $p4PerlObj->Errors() );

        if( $p4PerlObj->WarningCount() > 0 )
        {   
            $errMsg .= "WARNING: " . join( "", $p4PerlObj->Warnings() );
        }

        throw E_P4Fatal( "${subName}: $errMsg" );
    }
    elsif( $p4PerlObj->WarningCount() > 0 )
    {
        my $warnMsg = "WARNING: " . join( "", $p4PerlObj->Warnings() );
        throw E_P4Warning( "${subName}: $warnMsg" );
    }

    return( $p4Out );
}


sub _connect
{
    my $self = shift();

    my $p4PerlObj = $self->_getAttr( 'p4PerlObj' );

    if( ! defined( $p4PerlObj ) )
    {   
        require P4;
        $p4PerlObj = P4->new();

        if( ! $p4PerlObj->Connect() )
        {   
            my $subName = ( caller( 0 ) )[3];
            throw E_P4Fatal ( "${subName}: Failed to connect to Perforce Server" );
        }

        $self->_setAttr( 'p4PerlObj', $p4PerlObj );
        $self->_setAttr( '_ownP4PerlObj', 1 );
    }

    return( $p4PerlObj );
}


sub _disconnect
{
    my $self = shift();

    my $ownP4PerlObj = $self->_getAttr( '_ownP4PerlObj' );

    if( $ownP4PerlObj )
    {
        # We instantiated the connection, so we'll tear it down too
        my $p4PerlObj = $self->_getAttr( 'p4PerlObj' );

        if( defined( $p4PerlObj ) )
        {   
            $p4PerlObj->Disconnect();
        }
    }

    # In any case we'll dereference the P4 object, maybe we're the last reference.
    $self->_setAttr( 'p4PerlObj', undef );

    return( 1 );
}


sub DESTROY
{   
    my $self = shift();

    # Call _disconnect, it'll do the right thing
    $self->_disconnect();

    return( 1 );
}


######################################################################
# Standard authorship and copyright for documentation
#

=head1 AUTHOR

David L. Armstrong <armstd@cpan.org>

=head1 COPYRIGHT AND LICENSE

P4::OO::_Connection::P4PERL is Copyright (c)2011, David L. Armstrong.

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
