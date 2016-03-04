tests
testClassWithStereotype
	self
		export: (self parseClass: '/::Class << meta , class >> { }')
		equals: '/::Class <<meta,class>> { }'