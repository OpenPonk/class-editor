generator - attribute
multiplicityFor: aSymbol in: aClass
	(aClass includesSelector: aSymbol)
		ifTrue:
			[ (aClass >> aSymbol) pragmas
				detect: [ :each | each keyword = #DCType:multiplicity: ]
				ifFound:
					[ :pragma | 
					^ DCFAMIXMultiplicity new
						lower: (self lowerBoundFor: pragma);
						upper: (self upperBoundFor: pragma);
						yourself ] ].
	^ DCFAMIXMultiplicity one