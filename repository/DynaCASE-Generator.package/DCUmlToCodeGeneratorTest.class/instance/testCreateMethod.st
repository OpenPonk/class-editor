tests
testCreateMethod
	| parser |
	parser := DCUmlMethodBuilder new.
	model := parser parse: 'method(anArg: String, aCollection: Number[2..5]): Integer'.
	self flag: 'parser needs support for colon in the selector name'.
	model name: 'method:in:'.
	self assert: cls selectors equals: #().
	generator createMethodFor: model in: cls.
	self assert: cls selectors equals: #('method:in:').
	self
		assert: (cls >> #method:in:) ast
		equals:
			(RBParser
				parseMethod:
					'method: anArg in: aCollection <DCMethod: ''method:in:(anArg : String, aCollection : Number[2..5]) : Integer''> "not yet implemented"')