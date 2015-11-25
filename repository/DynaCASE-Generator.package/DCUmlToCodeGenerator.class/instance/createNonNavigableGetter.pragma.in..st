generator - accessors
createNonNavigableGetter: aName pragma: aPragma in: aClass
	aClass
		compile:
			('{1}
	{2}
	<DCNonNavigable>
	^ self shouldNotImplement' format: (Array with: aName with: aPragma with: aName))
		classified: 'accessing'