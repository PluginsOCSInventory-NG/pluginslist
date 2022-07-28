# Plugin "Plugins list" OCSInventory
# Author: Charlene AUGER
# Description: Retrieve the list of installed plugins
# Version: 2.1
# Date: 28/07/2022


# TODO :
# must be a better way to skip lines

package Ocsinventory::Agent::Modules::Pluginslist;

sub new {

    my $name="pluginslist"; # Name of the module

    my (undef,$context) = @_;
    my $self = {};

    #Create a special logger for the module
    $self->{logger} = new Ocsinventory::Logger ({
        config => $context->{config}
    });
    $self->{logger}->{header}="[$name]";
    $self->{context}=$context;
    $self->{structure}= {
        name => $name,
        start_handler => undef,    #or undef if don't use this hook
        prolog_writer => undef,    #or undef if don't use this hook
        prolog_reader => undef,    #or undef if don't use this hook
        inventory_handler => $name."_inventory_handler",    #or undef if don't use this hook
        end_handler => undef       #or undef if don't use this hook
    };
    bless $self;
}

######### Hook methods ############
sub pluginslist_inventory_handler {

    my $self = shift;
    my $logger = $self->{logger};
    my $common = $self->{context}->{common};

    # default values for testing
    $displayName = "plugins script informations";
    $enabled = "TRUE";
    

    $logger->debug("Yeah you are in pluginslist_inventory_handler:)");
    
    
    foreach my $plugin (_getPluginslist()) {

        if($plugin ne "") {
            push @{$common->{xmltags}->{PLUGINSLIST}},
            {
                SCRIPTNAME  => [$plugin],
                LANGUAGE    => ["pm"],
                DESCRIPTION => [""],
                VERSION     => [""],
                CREADATE    => [""],
                MODIDATE    => [""],
                AUTHOR      => [""]
            };
        }
    }
}

sub _getPluginslist {
    # Path conf file
    my $moduleConf = "/etc/ocsinventory/modules.conf";
    my @pluginList = undef;

    # Get the list of plugins
    if (open(my $fh, '<:encoding(UTF-8)', $moduleConf)) {
        while (my $row = <$fh>) {
            chomp $row;
            if($row =~ /use/ && $row !~ /Download/ && $row !~ /SnmpScan/) {
                $row =~ s/use Ocsinventory::Agent::Modules:://;
                chop $row;
                push @pluginList, $row;
            }
        }
    } else {
        $logger->debug("Could not open file '$moduleConf' $!");
    }

    return @pluginList;
}

1;