generator - accessors
createCollectionAccessorsFor: aFamixEntity in: aClass
	| name typeName prefix |
	name := aFamixEntity name asEnglishSingular.
	typeName := self typeNameFor: aFamixEntity.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	aClass
		compile:
			('add{1}: {2}
	{3} add: {2}' format: (Array with: name capitalized with: prefix , typeName with: name))
		classified: 'adding/removing'.
	aClass
		compile:
			('remove{1}: {2}
	{3} remove: {2}' format: (Array with: name capitalized with: prefix , typeName with: name))
		classified: 'adding/removing'