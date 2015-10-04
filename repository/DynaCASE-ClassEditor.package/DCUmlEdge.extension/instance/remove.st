*DynaCASE-ClassEditor-Manipulation
remove
	self view ifNil: [ ^ self ].
	self rtEdge remove.
	view signalUpdate