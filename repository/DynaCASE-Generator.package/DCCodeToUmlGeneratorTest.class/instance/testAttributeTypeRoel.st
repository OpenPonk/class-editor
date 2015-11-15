tests
testAttributeTypeRoel
	| name |
	cls addInstVarNamed: #inst.
	{('''hello''' -> #String).
	('#hello' -> #Symbol).
	('10' -> #Integer).
	('OrderedCollection new' -> #OrderedCollection)}
		do:
			[ :pair | 
			cls compile: ('method inst := {1}' format: {pair key}).
			name := generator attributeTypeNameFor: #inst in: cls.
			self assert: name equals: pair value ]