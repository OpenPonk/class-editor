tests
testAttribute
	self
		export: (self parseAttribute: '_collection : Float[0..*]')
		equals: '_collection : Float[*]'