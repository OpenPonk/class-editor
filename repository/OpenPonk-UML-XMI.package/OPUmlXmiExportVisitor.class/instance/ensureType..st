accessing
ensureType: aType
	aType mooseModel ifNil: [ types add: aType ]