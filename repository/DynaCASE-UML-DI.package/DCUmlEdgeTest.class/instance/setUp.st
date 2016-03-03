running
setUp
	| source target |
	super setUp.
	source := DCUmlLabel new.
	target := DCUmlLabel new.
	element source: source.
	element target: target