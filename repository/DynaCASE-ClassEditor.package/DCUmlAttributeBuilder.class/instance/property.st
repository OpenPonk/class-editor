building
property
	^ super property
		==>
			[ :nodes | 
			DCUmlAttribute new
				name: nodes second;
				type: nodes third;
				multiplicity: nodes fourth ]