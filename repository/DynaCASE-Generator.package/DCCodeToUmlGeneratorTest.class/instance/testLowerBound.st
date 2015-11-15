tests
testLowerBound
	{(#(1 10) -> 1).
	(#(2) -> 2).
	(#(#*) -> 0).
	(#(1 #*) -> 1)}
		do:
			[ :pair | 
			self
				assert:
					(generator
						lowerBoundFor: (Pragma keyword: #DCType:multiplicity: arguments: (Array with: #X with: pair key)))
				equals: pair value ]