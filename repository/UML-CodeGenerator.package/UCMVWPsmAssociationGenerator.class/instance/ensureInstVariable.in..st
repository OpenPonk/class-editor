as yet unclassified
ensureInstVariable: aName in: aClass
	(aClass withSuperclassHierarchy
		anySatisfy: [ :each | each attributes anySatisfy: [ :attr | attr name = aName ] ])
		ifFalse: [ aClass addAttribute: (FAMIXAttribute named: aName) ]