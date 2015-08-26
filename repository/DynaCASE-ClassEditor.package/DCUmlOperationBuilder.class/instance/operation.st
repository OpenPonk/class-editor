grammar
operation
	^ super operation
		==>
			[ :nodes | 
			DCUmlOperation new
				name: nodes second;
				parameters: nodes third;
				returnParameter: nodes fourth;
				yourself ]