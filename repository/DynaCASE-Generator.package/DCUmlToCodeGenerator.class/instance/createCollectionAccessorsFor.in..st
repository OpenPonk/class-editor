generators
createCollectionAccessorsFor: aFamixAttribute in: aClass
	| typeName prefix isCollection |
	typeName := self typeNameFor: aFamixAttribute declaredType.
	isCollection := aFamixAttribute multiplicity upper > 1.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	aClass
		compile:
			('add{1}: {2}
	{1} add: {2}'
				format:
					(Array with: aFamixAttribute name capitalized asEnglishSingular with: prefix , typeName))
		classified: 'adding/removing'.
	aClass
		compile:
			('remove{1}: {2}
	{1} remove: {2}'
				format:
					(Array with: aFamixAttribute name capitalized asEnglishSingular with: prefix , typeName))
		classified: 'adding/removing'