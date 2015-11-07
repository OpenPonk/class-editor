generator - accessors
createAccessorsFor: anEntity in: aClass
	"aFamixEntity is FAMIXAttribute or DCFAMIXAssociationEnd"

	| parameterName prefix isCollection |
	generateAccessors
		ifFalse: [ ^ self ].
	isCollection := anEntity multiplicity upper > 1.
	parameterName := isCollection
		ifTrue: [ 'Collection' ]
		ifFalse: [ self typeNameFor: anEntity ].
	prefix := parameterName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	self createGetter: anEntity name pragma: (self getterPragmaFor: anEntity) in: aClass.
	self createSetter: anEntity name parameter: parameterName in: aClass.
	isCollection
		ifTrue: [ self createCollectionAccessorsFor: anEntity in: aClass ]