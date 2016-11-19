as yet unclassified
dictionaryToStructureNamed: aName
	| keys cls |
	self assert: [ object isDictionary ].
	keys := object keys collect: [ :each | self selectorForName: each ].
	cls := Object subclass: aName asSymbol.
	cls := Object
		subclass: aName asSymbol
		slots: keys
		classVariables: {}
		category: 'Unclassified'.
	keys
		do: [ :each | 
			cls
				compile:
					('{1}
	^ {1}' format: {each})
				classified: 'accessing' ].
	cls browse