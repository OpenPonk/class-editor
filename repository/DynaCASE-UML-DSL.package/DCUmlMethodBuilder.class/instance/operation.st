grammar
operation
	^ super operation
		==> [ :nodes | 
			| method |
			method := FAMIXMethod named: nodes third.
			method visibility: nodes second.
			method isStatic: (nodes first includes: $_).
			method isAbstract: (nodes first includes: $/).
			nodes fourth do: [ :each | method addParameter: each ].
			nodes fifth ifNotNil: [ :ret | method addParameter: ret ].
			method ]