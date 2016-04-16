generator - attribute
ensureInstVariable: aName in: aClass
	((aClass withAllSuperclasses flatCollect: #instVarNames) includes: aName)
		ifTrue: [ ^ false ].
	aClass addInstVarNamed: aName.
	^ true