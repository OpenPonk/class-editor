accessing
context
	^ context ifNil: [ context := DCUmlCodeGeneratorContext new ]