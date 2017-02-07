grammar
parameter
	^ super parameter
		==> [ :nodes | 
			FAMIXParameter new
				name: nodes first;
				declaredType: (FAMIXClass named: (nodes second ifNil: [ 'Object' ]));
				multiplicity: nodes third;
				yourself ]