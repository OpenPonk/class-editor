grammar
returnValue
	^ super returnValue
		==> [ :nodes | 
			FAMIXParameter new
				name: 'return';
				declaredType: (FAMIXClass named: (nodes first ifNil: [ 'Object' ]));
				direction: DCUmlParameterDirectionKind return;
				multiplicity: nodes second;
				yourself ]