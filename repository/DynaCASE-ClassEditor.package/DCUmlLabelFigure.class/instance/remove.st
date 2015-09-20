adding/removing
remove
	| view |
	view := element view.
	view ifNil: [ ^ self ].
	element remove.
	view signalUpdate