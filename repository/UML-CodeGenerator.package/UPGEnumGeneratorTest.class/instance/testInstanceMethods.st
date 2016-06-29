tests
testInstanceMethods
	self assert: cls selectors asSet equals: #(#organization #person #system) asSet.
	self
		ast: (cls >> #organization) ast
		equals:
			'organization
	"Generated method"
	^ #organization'.
	self assert: (cls >> #organization) protocol equals: 'accessing - literals'