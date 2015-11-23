accessing
dslName
	^ ($/ asParser optional , symbol)
		==>
			[ :nodes | Array with: (nodes first ifNil: [ false ] ifNotNil: [ nodes first = $/ ]) with: nodes second ]