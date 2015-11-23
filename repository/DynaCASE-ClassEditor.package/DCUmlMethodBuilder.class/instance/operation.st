grammar
operation
	^ super operation
		==>
			[ :nodes | 
			| method |
			method := FAMIXMethod named: nodes third.
			method isStatic: (nodes first includes: $_).
			method isAbstract: (nodes first includes: $/).
			nodes fifth
				ifNotNil:
					[ :ret | 
					method declaredType: ret first.
					method multiplicity: nodes fifth second ].
			nodes fourth do: [ :each | method addParameter: each ].
			method ]