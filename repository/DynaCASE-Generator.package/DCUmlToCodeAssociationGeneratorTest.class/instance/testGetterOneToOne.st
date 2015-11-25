tests
testGetterOneToOne
	result := generator getter: oneToOne targetEnd.
	self ast: result equals: 'university <DCAssociation: ''''> ^ university'