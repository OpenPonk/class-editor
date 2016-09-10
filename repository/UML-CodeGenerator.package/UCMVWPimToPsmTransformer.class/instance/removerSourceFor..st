transforming - accessors
removerSourceFor: aFamixEntity
	| name typeName prefix |
	name := aFamixEntity name asEnglishSingular.
	typeName := self typeNameFor: aFamixEntity.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	^ DCUmlSingleOpaqueBehavior
		body:
			('remove{1}: {2}
	{3} remove: {2}'
				format:
					(Array
						with: name capitalized
						with: prefix , typeName
						with: aFamixEntity name))