*DynaCASE-ClassEditor-Updating
remove
	self figures select: [ :each | each view isNotNil ] thenDo: #remove.
	self figures removeAll.
	self rtElement view ifNotNil: [ self rtElement remove ].
	view ifNotNil: [ view signalUpdate ].
	view := nil