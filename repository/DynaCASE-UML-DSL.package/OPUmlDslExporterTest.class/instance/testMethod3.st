tests
testMethod3
	self
		export: (self parseMethod: 'notNil() : Object')
		equals: 'notNil() : Object'