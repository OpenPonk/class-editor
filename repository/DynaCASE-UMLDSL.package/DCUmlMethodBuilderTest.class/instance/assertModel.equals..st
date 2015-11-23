asserting
assertModel: anActual equals: anExpected
	^ self
		assert: (DCUmlModelComparator new model: anActual equals: anExpected)
		description: [ self comparingStringBetween: anActual and: anExpected ]