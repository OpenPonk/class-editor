accessing
update
	element update.
	element view ifNotNil: [ element view signalUpdate ].
	self updateParent