grammar
parameter
	^ super parameter
		==>
			[ :nodes | 
			DCUmlParameter new
				name: nodes first;
				type: nodes second;
				multiplicity: nodes third ]