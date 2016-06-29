tests
testGetterOneToOne
	self
		ast: (generator getter: oneToOne targetEnd)
		equals: 'university <DCAssociation: ''President president --- university University''> ^ university'