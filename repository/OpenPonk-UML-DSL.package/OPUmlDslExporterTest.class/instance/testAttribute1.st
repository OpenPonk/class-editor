tests
testAttribute1
	self
		export: (self parseAttribute: '_collection : Float[1..1]')
		equals: '_collection : Float'