tests
testMethodPragma
	| pragma parser |
	parser := DCUmlMethodBuilder new.
	model := parser parse: 'method(anArg: String, aCollection: Number[2..5]): Integer'.
	pragma := generator methodPragmaFor: model.
	self
		assert: pragma
		equals:
			'<DCMethod: ''method(anArg : String, aCollection : Number[2..5]) : Integer''>'