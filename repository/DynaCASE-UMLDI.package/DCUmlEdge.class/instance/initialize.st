initialization
initialize
	super initialize.
	source := nil.
	target := nil.
	waypoints := OrderedCollection new.
	(localStyle := DCUmlStyle new)
		strokeColor: Color black;
		strokeWidth: 1