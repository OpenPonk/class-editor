grammar
parameter
	^ super parameter
		==>
			[ :nodes | 
			(FAMIXParameter
				named: nodes first
				type: (FAMIXClass named: (nodes second ifNil: [ 'Object' ])))
				multiplicity: nodes third;
				yourself ]