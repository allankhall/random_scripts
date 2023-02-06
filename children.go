package main

import (
	"errors"
	"fmt"
	"os"
)

type event struct {
	id int
	parent_id int
}

func main() {
	var events []event
	var e event

	e.id = 1
	e.parent_id = 0
	// append new event via builtin append() function
	events = append(events, e)

	e.id = 2
	e.parent_id = 0
	events = append(events, e)

	e.id = 3
	e.parent_id = 1
	// lets try appending via our custom append method that checks for existing events
	events, err := appendIfNew(events, e)
	errCheck(err)

	e.id = 4
	e.parent_id = 1
	events, err = appendIfNew(events, e)
	errCheck(err)

	e.id = 5
	e.parent_id = 4
	events, err = appendIfNew(events, e)
	errCheck(err)

//      events array in tree form
//   
//           1      2
//          / \
//         3   4
//              \
//               5

        // Try our original returnRoots function lifted from the Perl code
        roots, err := returnRoots(events)
	errCheck(err)
     
	fmt.Println("Found Roots:")
	fmt.Printf("%+v\n\n", roots)

	// Try traversing the tree down from the root nodes we found
	for _, root := range roots {
		fmt.Printf("Traversing down from Root: %+v\n", root)
		err := traverse(events, root)
		errCheck(err)
	}
	fmt.Println()

	// Finally, ensure our appendIfNew catches duplicate entries
	// Note: This type of thing would normally go in a unit test
	events, err = appendIfNew(events, e)
	if err != nil{
		fmt.Printf("Attempted to add duplicate event %+v\n.", e)
	} else {
		fmt.Printf("ERROR: event %+v\n should have been caught as a duplicate!", e)
	}
}

func traverse(events []event, node event) (error) {
	for _, e := range events {
		if e.parent_id == node.id {
			fmt.Printf("%+v\n", e)
			traverse(events, e)
		}
	}
	return nil
}

// Append an event to the events list,
// but only if the new event id does not yet exist in the list
// NOTE: using the word "event" in so many contexts is not ideal
// 
// Returns an error if the given event id already exists in the list
func appendIfNew(events []event, event event) ([]event, error) {
	for _, e := range events {
		if e.id == event.id {
			return events, errors.New("Event id already exists.")
		}
	}
	events = append(events, event)

	return events, nil
}

func returnRoots(events []event) ([]event, error) {
	var roots []event

	for _, event := range events {
		if event.parent_id == 0{
			roots = append(roots, event)
		}
	}
	return roots, nil
}

// Helper function so as to not repeat error checking code.
func errCheck(err error) {
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
