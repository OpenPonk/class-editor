accessing
context
	^ context ifNil: [ context := UPGGeneratorContext new ]