accessing
association
	^ super association
		==> [ :nodes | 
			| assoc |
			assoc := OPFAMIXBinaryAssociation new.
			assoc name: (nodes fourth ifNil: [ '' ]).
			nodes first second association: assoc.
			nodes third second association: assoc.
			assoc instVarNamed: #sourceEnd put: nodes first second.
			assoc instVarNamed: #targetEnd put: nodes third second.
			nodes first second
				declaredType: (FAMIXClass named: nodes first first);
				aggregation: nodes third third.
			nodes third second
				declaredType: (FAMIXClass named: nodes third first);
				aggregation: nodes first third.
			nodes first second association: assoc.
			nodes third second association: assoc.
			nodes first fourth = false & (nodes third fourth = true)
				ifTrue: [ assoc sourceEnd isNavigable: false ].
			nodes first fourth = true & (nodes third fourth = false)
				ifTrue: [ assoc targetEnd isNavigable: false ].
			assoc ]