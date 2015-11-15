generator - attribute
attributeTypeNameFor: aSymbol in: aClass
	| roelTypes |
	(aClass includesSelector: aSymbol)
		ifTrue:
			[ (aClass >> aSymbol) pragmas
				detect: [ :each | each keyword = #DCType:multiplicity: | (each keyword = #DCType:) ]
				ifFound: [ :pragma | ^ pragma arguments first ] ].
	roelTypes := (TypeCollector typeInstvar: aSymbol ofClass: aClass) types.
	roelTypes
		ifNotEmpty:
			[ (roelTypes first isKindOf: Symbol class)
				ifTrue: [ ^ #Symbol ].
			(roelTypes first isKindOf: String class)
				ifTrue: [ ^ #String ].
			(roelTypes first isKindOf: Integer class)
				ifTrue: [ ^ #Integer ].
			^ roelTypes first name ].
	^ FAMIXClass named: #Object