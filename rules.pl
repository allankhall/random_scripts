#!/usr/bin/perl


use strict;
use Data::Dumper;


main();

sub main {
    #create a set of rules
    my @rules = ();
    push(@rules,{vehicle_type => 'car', state_registration => 'CA', max_passenger_count => 4, allow => 1});
    push(@rules,{vehicle_type => 'car', state_registration => 'OH', max_passenger_count => 4, allow => 1});
    push(@rules,{vehicle_type => 'truck', state_registration => 'ANY', max_passenger_count => 4, allow => 1});
    push(@rules,{vehicle_type => 'truck', state_registration => 'ANY', max_passenger_count => 4, allow => 1});
    push(@rules,{vehicle_type => 'ANY', state_registration => 'ANY', max_passenger_count => 'ANY', allow => 0});

    #create a vehicle
    my $vehicle = {vehicle_type => 'motorcycle', state_registration => 'CA', passenger_count => 1};

    #check rule for vehicle
    my $allowed = allow(\@rules, $vehicle);
    if ($allowed) {
        print "allowed\n";
    } else {
        print "not allowed\n";
    }
}

sub allow {
    my $rules = shift;
    my $vehicle = shift;
    for my $rule (@{$rules}) {
        if (
              ( $rule->{vehicle_type} eq 'ANY' || $rule->{vehicle_type} eq $vehicle->{vehicle_type}) &&
              ( $rule->{state_registration} eq 'ANY' || $rule->{state_regisatration} eq $vehicle->{state_registration}) &&
              ( $rule->{max_passenger_count} eq 'ANY' || $rule->{max_passenger_count} <= $vehicle->{assenger_count})
        ) {
          return $rule->{allow};
        }
    }
    return 0;
}
