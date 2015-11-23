grammar
returnValue
	^ super returnValue
		==>
			[ :nodes | 
			{(nodes first ifNotNil: [ FAMIXClass named: nodes first ]).
			nodes second} ]