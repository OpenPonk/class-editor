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
			((FAMIXMethod named: 'layoutFor' type: (FAMIXClass named: 'Dictionary'))
				addParameter: (FAMIXParameter named: 'aDiagram' type: dia);
				yourself).
	model
		add: proj;
		add: dia;
		add: el;
		add: obj.

	model add: (FAMIXInheritance subclass: el superclass: obj).
	model add: (FAMIXInheritance subclass: dia superclass: obj).
"
	a := DCFAMIXBinaryAssociation source: dia target: el.
	a sourceEnd
		name: 'owner';
		multiplicity: DCFAMIXMultiplicity zeroToOne.
	a targetEnd
		name: 'elements';
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	model add: a.

	a := DCFAMIXBinaryAssociation source: proj target: dia.
	a sourceEnd multiplicity: DCFAMIXMultiplicity zeroToOne.
	a targetEnd
		name: 'diagrams';
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	model add: a.

	a := DCFAMIXBinaryAssociation source: obj target: obj.
	a sourceEnd multiplicity: DCFAMIXMultiplicity zeroToMany.
	a targetEnd
		name: 'owner';
		multiplicity: DCFAMIXMultiplicity zeroToOne."

	^ model