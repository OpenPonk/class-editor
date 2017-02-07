visitor
visitParameter: aParameter
	stream nextPutAll: aParameter name.
	self visitTypeWithMultiplicity: aParameter