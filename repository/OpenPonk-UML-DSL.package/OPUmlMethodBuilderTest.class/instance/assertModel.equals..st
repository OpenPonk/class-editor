asserting
assertModel: anActual equals: anExpected
	^ self
		assert: (OPUmlModelComparator new model: anActual equals: anExpected)
		description: [ self comparingStringBetween: anActual and: anExpected ]