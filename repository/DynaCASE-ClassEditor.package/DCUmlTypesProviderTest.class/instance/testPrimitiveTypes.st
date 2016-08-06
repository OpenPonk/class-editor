tests-accessing
testPrimitiveTypes
	self
		assert: (provider primitiveTypes collect: #name)
		equals: #(Boolean Integer Float String Symbol Object #'nil')