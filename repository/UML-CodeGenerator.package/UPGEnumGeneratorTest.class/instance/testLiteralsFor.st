tests
testLiteralsFor
	self
		assert: (generator literalsFor: model)
		equals:
			(Dictionary
				with: #organization -> '#organization'
				with: #person -> '#person'
				with: #system -> '#system')