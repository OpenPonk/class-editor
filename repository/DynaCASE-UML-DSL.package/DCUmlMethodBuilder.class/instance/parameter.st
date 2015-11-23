grammar
parameter
	^ super parameter
		==>
			[ :nodes | 
			(FAMIXParameter
				named: nodes first
				type: (nodes second ifNotNil: [ FAMIXClass named: nodes second ]))
				multiplicity: nodes third;
				yourself ]