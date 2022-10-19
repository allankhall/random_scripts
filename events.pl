#!/usr/bin/perl

use strict;
use Data::Dumper;

main();

sub main {
    my @events = ();
    push(@events, {id => 1,timestamp => 1666208400, state => "started"});
    push(@events, {id => 2,timestamp => 1666208500, state => "started"});
    push(@events, {id => 1,timestamp => 1666208600, state => "ended"});
    push(@events, {id => 3,timestamp => 1666208700, state => "started"});
    push(@events, {id => 2,timestamp => 1666208800, state => "ended"});
    push(@events, {id => 3,timestamp => 1666208900, state => "ended"});
    my $grouped_events =  groupEvents(\@events);
    print Dumper  $grouped_events;
}

sub groupEvents {
     my $events = shift;
     my $grouped_events = {};
     for my $event (@{$events}) {
         my $event_id = $event->{id};
         my $event_state = $event->{state};
         my $event_timestamp = $event->{timestamp};
         if ($event_state eq 'started') {
             $grouped_events->{$event_id} = {started => $event_timestamp};
         } elsif ($event_state eq 'ended') {
             my $duration = $event_timestamp - $grouped_events->{$event_id}{started};
             $grouped_events->{$event_id} = $duration;
         }
    }
    return $grouped_events;
}
