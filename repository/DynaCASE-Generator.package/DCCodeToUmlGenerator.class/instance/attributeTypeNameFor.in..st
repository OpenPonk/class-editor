generator - attribute
attributeTypeNameFor: aSymbol in: aClass
	(aClass includesSelector: aSymbol)
		ifTrue:
			[ (aClass >> aSymbol) pragmas
				detect: [ :each | each keyword = #DCType:multiplicity: | (each keyword = #DCType:) ]
				ifFound: [ :pragma | ^ pragma arguments first ] ].
	^ FAMIXClass named: #Object