tests
testGetterLazy
	generator context useLazyInitialization.
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university'