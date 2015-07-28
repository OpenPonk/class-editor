adding
remove
	figures select: [ :each | each view isNotNil ] thenDo: #remove.
	figures removeAll.
	element view ifNotNil: [ element remove ].
	view ifNotNil: [ view signalUpdate ].
	view := nil