examples
sampleModel
	| model obj el dia proj a |
	model := MooseModel named: 'UML Class Diagram'.
	proj := FAMIXClass named: 'DCProject'.
	dia := FAMIXClass named: 'DCDiagram'.
	el := FAMIXClass named: 'DCNamedElement'.
	obj := FAMIXClass named: 'DCModelObject'.
	obj addAttribute: (FAMIXAttribute named: 'dcID' type: (FAMIXClass named: 'UUID')).
	obj addAttribute: (FAMIXAttribute named: 'dcName' type: (FAMIXClass named: 'String')).
	proj
		addMethod:
			((FAMIXMethod named: 'addDiagram')
				addParameter: (FAMIXParameter named: 'aDiagram' type: dia);
				yourself).
	proj
		addMethod:
			((FAMIXMethod named: 'layoutFor')
				addParameter: (FAMIXParameter named: 'aDiagram' type: dia);
				addParameter:
					(FAMIXParameter new
						name: 'return';
						direction: OPUmlParameterDirectionKind return;
						declaredType: (FAMIXClass named: 'Dictionary'));
				yourself).
	model
		add: proj;
		add: dia;
		add: el;
		add: obj.
	model add: (FAMIXInheritance subclass: el superclass: obj).
	model add: (FAMIXInheritance subclass: dia superclass: obj).
	a := OPFAMIXBinaryAssociation new.
	a sourceEnd
		name: 'owner';
		declaredType: dia;
		multiplicity: OPFAMIXMultiplicity zeroToOne.
	a targetEnd
		name: 'elements';
		declaredType: el;
		multiplicity: OPFAMIXMultiplicity zeroToMany.
	model add: a.
	a := OPFAMIXBinaryAssociation new.
	a sourceEnd
		declaredType: proj;
		multiplicity: OPFAMIXMultiplicity zeroToOne.
	a targetEnd
		name: 'diagrams';
		declaredType: dia;
		multiplicity: OPFAMIXMultiplicity zeroToMany.
	model add: a.
	a := OPFAMIXBinaryAssociation new.
	a sourceEnd
		declaredType: obj;
		multiplicity: OPFAMIXMultiplicity zeroToMany.
	a targetEnd
		name: 'owner';
		declaredType: obj;
		multiplicity: OPFAMIXMultiplicity zeroToOne.
	^ model