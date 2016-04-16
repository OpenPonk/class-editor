generator - accessors
createGetter: aName pragma: aPragma in: aClass
	aClass
		compile:
			('{1}
	{2}
	^ {1}' format: (Array with: aName with: aPragma with: aName))
		classified: 'accessing'