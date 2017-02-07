grammar
returnValue
	^ super returnValue
		==> [ :nodes | 
			FAMIXParameter new
				name: 'return';
				declaredType: (FAMIXClass named: (nodes first ifNil: [ 'Object' ]));
				direction: OPUmlParameterDirectionKind return;
				multiplicity: nodes second;
				yourself ]