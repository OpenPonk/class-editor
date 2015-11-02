generators
createAccessorsFor: aFamixAttribute in: aClass
	| typeName prefix suffix isCollection |
	typeName := self typeNameFor: aFamixAttribute declaredType.
	isCollection := aFamixAttribute multiplicity upper > 1.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	suffix := isCollection
		ifTrue: [ 'Collection' ]
		ifFalse: [ '' ].
	aClass
		compile:
			('{1}
	{2}
	^ {1}'
				format:
					(Array with: aFamixAttribute name with: (self getterPragmaFor: aFamixAttribute)))
		classified: 'accessing'.
	aClass
		compile:
			('{1}: {2}
	{1} := {2}' format: (Array with: aFamixAttribute name with: prefix , typeName , suffix))
		classified: 'accessing'.
	isCollection
		ifTrue: [ self createCollectionAccessorsFor: aFamixAttribute in: aClass ]