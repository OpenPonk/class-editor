grammar
returnValue
	^ super returnValue
		==>
			[ :nodes | 
			DCUmlParameter new
				type: nodes first;
				multiplicity: nodes second;
				yourself ]