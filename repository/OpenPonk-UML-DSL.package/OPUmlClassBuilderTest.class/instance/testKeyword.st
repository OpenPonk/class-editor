tests
testKeyword
	self parse: '' rule: #keyword.
	self assert: result equals: OrderedCollection new