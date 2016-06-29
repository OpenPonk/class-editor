tests
testClassMethods
	self assert: cls class selectors asSet equals: #(#person #system #enum) asSet.
	self
		ast: (cls class >> #person) ast
		equals:
			'person
	"Generated method"
	^ self enum person'.
	self assert: (cls class >> #person) protocol equals: 'accessing - literals'