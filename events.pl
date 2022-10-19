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
     #group events
     # assumes array is ordered by timestamp
     # assumes each event id has exactly one started and one ended entry

     my $events = shift;
     my $grouped_events = {};
     for my $event (@{$events}) {

         #pull attributes out into local variables for convenience
         my $event_id = $event->{id};
         my $event_state = $event->{state};
         my $event_timestamp = $event->{timestamp};
 
         #if this is the start event log it for later calculation whne end event is encountered
         if ($event_state eq 'started') {
             $grouped_events->{$event_id} = {started => $event_timestamp};

         #if this is the end event, overwrite the start timestamp with a duration calculation
         } elsif ($event_state eq 'ended') {
             my $duration = $event_timestamp - $grouped_events->{$event_id}{started};
             $grouped_events->{$event_id} = $duration;
         }
    }
    return $grouped_events;
}
