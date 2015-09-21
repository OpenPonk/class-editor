generators
uniqueNameIn: aCollection baseName: aName
	| i names  |
	names := aCollection collect: #name.
	(names includes: aName)
		ifFalse: [ ^ aName ].
	i := 1.
	[ names includes: aName , i asString ] whileTrue: [ i := i + 1 ].
	^ aName , i asString