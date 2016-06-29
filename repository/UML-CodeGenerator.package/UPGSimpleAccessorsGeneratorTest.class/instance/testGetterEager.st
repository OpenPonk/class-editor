tests
testGetterEager
	generator context useEagerInitialization.
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university'