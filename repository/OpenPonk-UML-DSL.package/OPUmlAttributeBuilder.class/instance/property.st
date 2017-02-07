building
property
	^ super property
		==> [ :nodes | 
			FAMIXAttribute new
				name: nodes third;
				visibility: nodes second;
				isStatic: (nodes first includes: $_);
				defaultValue: nodes sixth;
				declaredType: (nodes fourth ifNotNil: [ FAMIXClass named: nodes fourth ]);
				multiplicity: nodes fifth ]