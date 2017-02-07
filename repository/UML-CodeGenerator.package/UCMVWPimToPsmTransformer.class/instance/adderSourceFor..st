transforming - accessors
adderSourceFor: aFamixEntity
	| name typeName prefix |
	name := aFamixEntity name asEnglishSingular.
	typeName := self typeNameFor: aFamixEntity.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	^ OPUmlSingleOpaqueBehavior
		body:
			('add{1}: {2}
	{3} add: {2}'
				format:
					(Array
						with: name capitalized
						with: prefix , typeName
						with: aFamixEntity name))