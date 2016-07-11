tests
testGetter1
	self
		ast: (generator getter: uniToDept targetEnd)
		equals:
			'departments <DCAssociation: ''University university <*>-- departments Department[*]''> ^ departments'