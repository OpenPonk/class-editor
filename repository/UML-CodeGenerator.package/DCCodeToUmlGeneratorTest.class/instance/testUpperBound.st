tests
testUpperBound
	{#(1 10) -> 10.
	#(2) -> 2.
	#(*) ->
		OPUnlimitedNatural max.
	#(0 *) ->
		OPUnlimitedNatural max}
		do: [ :pair | 
			self
				assert:
					(generator
						upperBoundFor:
							(Pragma
								keyword: #DCType:multiplicity:
								arguments: (Array with: #X with: pair key)))
				equals: pair value ]