generator - attribute
multiplicityFor: aSymbol in: aClass
	(aClass includesSelector: aSymbol)
		ifTrue: [ (aClass >> aSymbol) pragmas
				detect: [ :each | each keyword = #DCType:multiplicity: ]
				ifFound: [ :pragma | 
					^ OPFAMIXMultiplicity new
						lower: (self lowerBoundFor: pragma);
						upper: (self upperBoundFor: pragma);
						yourself ] ].
	^ OPFAMIXMultiplicity one