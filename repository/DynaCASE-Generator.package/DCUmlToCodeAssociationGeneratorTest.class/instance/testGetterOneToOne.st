tests
testGetterOneToOne
	self
		ast: (generator getter: oneToOne targetEnd)
		equals: 'university <DCAssociation: ''''> ^ university'