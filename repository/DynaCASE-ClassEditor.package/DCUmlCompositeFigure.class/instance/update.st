updating
update
	view ifNil: [ ^ self ].
	figures select: [ :each | each view isNil ] thenDo: [ :each | each renderIn: view ].

	self applyLayout.
	self doNest.

	view signalUpdate