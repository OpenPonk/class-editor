parsing
parse: aString
	| builder statements classes model |
	model := MooseModel new.
	builder := DCUmlDslBuilder new.
	statements := builder parse: aString.
	classes := (statements select: #isClass thenCollect: [ :each | each name -> each ])
		asOrderedDictionary.
	statements
		select: #isBinaryAssociation
		thenDo:
			[ :each | 
			classes
				at: each source name
				ifPresent: [ :source | each source: source ]
				ifAbsent: [ classes at: each source name put: each source ].
			classes
				at: each target name
				ifPresent: [ :target | each target: target ]
				ifAbsent: [ classes at: each target name put: each target ] ].
	statements
		select: #isInheritance
		thenDo:
			[ :each | 
			classes
				at: each subclass name
				ifPresent: [ :source | each subclass: source ]
				ifAbsent: [ classes at: each subclass name put: each subclass ].
			classes
				at: each superclass name
				ifPresent: [ :target | each superclass: target ]
				ifAbsent: [ classes at: each superclass name put: each superclass ] ].
	model addAll: classes.
	model addAll: (statements select: #isAssociation).
	^ model