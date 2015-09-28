grammar
operation
	^ super operation
		==>
			[ :nodes | 
			| method |
			method := FAMIXMethod named: nodes second.
			nodes fourth
				ifNotNil:
					[ :ret | 
					method declaredType: ret first.
					method multiplicity: nodes fourth second ].
			nodes third do: [ :each | method addParameter: each ].
			method ]