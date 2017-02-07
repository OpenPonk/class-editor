accessing
model
	self assemble.
	^ elements values detect: [ :each | each isKindOf: MooseModel ]