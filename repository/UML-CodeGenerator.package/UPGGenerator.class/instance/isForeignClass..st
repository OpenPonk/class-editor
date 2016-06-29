helpers
isForeignClass: aClass
	^ (Smalltalk hasClassNamed: aClass name)
		and: [ (aClass name asClass package name = self context package) not ]