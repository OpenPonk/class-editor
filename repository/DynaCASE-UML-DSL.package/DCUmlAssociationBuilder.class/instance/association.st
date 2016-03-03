accessing
association
	^ super association
		==>
			[ :nodes | 
			| assoc |
			nodes first third.
			assoc := DCFAMIXBinaryAssociation source: (FAMIXClass named: nodes first first) target: (FAMIXClass named: nodes third first).
			assoc name: (nodes fourth ifNil: [ '' ]).
			assoc instVarNamed: #sourceEnd put: nodes first second.
			assoc instVarNamed: #targetEnd put: nodes third second.
			nodes first second association: assoc.
			nodes third second association: assoc.
			nodes first third = false & (nodes third third = true)
				ifTrue: [ assoc sourceEnd isNavigable: false ].
			nodes first third = true & (nodes third third = false)
				ifTrue: [ assoc targetEnd isNavigable: false ].
			assoc ]