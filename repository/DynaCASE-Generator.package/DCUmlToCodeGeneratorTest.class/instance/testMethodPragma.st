tests
testMethodPragma
	model := factory method: 'method(anArg: String, aCollection: Number[2..5]): Integer'.
	self
		assert: (generator methodPragmaFor: model)
		equals:
			(Pragma
				keyword: #DCMethod:
				arguments: #('method(anArg : String, aCollection : Number[2..5]) : Integer'))