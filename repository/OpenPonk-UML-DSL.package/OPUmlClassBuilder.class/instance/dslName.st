accessing
dslName
	^ ($/ asParser optional , fqn)
		==>
			[ :nodes | Array with: (nodes first ifNil: [ false ] ifNotNil: [ nodes first = $/ ]) with: nodes second ]