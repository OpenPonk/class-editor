building
property
	^ super property
		==>
			[ :nodes | 
			FAMIXAttribute new
				name: nodes second;
				declaredType: (nodes third ifNotNil: [ FAMIXClass named: nodes third ]);
				multiplicity: nodes fourth ]