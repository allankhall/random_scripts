#!/usr/bin/perl

use strict;
use Data::Dumper;

main();

sub main {
    my @events = ();
    push(@events, {id => 1, parent_id => 0});
    push(@events, {id => 2, parent_id => 0});
    push(@events, {id => 3, parent_id => 1});
    push(@events, {id => 4, parent_id => 1});
    push(@events, {id => 5, parent_id => 4});
    my @roots = returnRoots(\@events);
    print Dumper @roots;
}


sub returnRoots {
    #a root is defined as an event whose parent_id is 0
    my $events = shift;
    my @roots = ();
    for my $event(@{$events}) {
        if ($event->{parent_id} == 0) {
             push(@roots, $event->{id});
        }
    }
    return @roots;
}
