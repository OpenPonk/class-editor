generator - accessors
createSetter: aName parameter: aParameterName in: aClass
	aClass
		compile:
			('{1}: {2}
	{1} := {2}'
				format:
					{aName.
					((aParameterName first isVowel
						ifTrue: [ 'an' ]
						ifFalse: [ 'a' ]) , aParameterName)})
		classified: 'accessing'