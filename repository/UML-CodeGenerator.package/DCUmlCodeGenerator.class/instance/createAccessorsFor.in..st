generator - accessors
createAccessorsFor: anAttribute in: aClass
	| parameterName prefix isCollection |
	context shouldAddAccessors
		ifFalse: [ ^ self ].
	isCollection := anAttribute multiplicity upper > 1.
	parameterName := isCollection
		ifTrue: [ 'Collection' ]
		ifFalse: [ self typeNameFor: anAttribute ].
	prefix := parameterName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	self createGetter: anAttribute name pragma: (self getterPragmaFor: anAttribute) in: aClass.
	self createSetter: anAttribute name parameter: parameterName in: aClass.
	isCollection
		ifTrue: [ self createCollectionAccessorsFor: anAttribute in: aClass ]