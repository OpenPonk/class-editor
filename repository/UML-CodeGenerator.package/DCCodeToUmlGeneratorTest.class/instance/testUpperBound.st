tests
testUpperBound
	{(#(1 10) -> 10).
	(#(2) -> 2).
	(#(#*) -> DCUnlimitedNatural max).
	(#(0 #*) -> DCUnlimitedNatural max)}
		do:
			[ :pair | 
			self
				assert:
					(generator
						upperBoundFor: (Pragma keyword: #DCType:multiplicity: arguments: (Array with: #X with: pair key)))
				equals: pair value ]