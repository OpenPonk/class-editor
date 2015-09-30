examples
sampleDsl
	| model obj el dia proj a factory |
	factory := DCUmlDSLFactory new.
	model := factory model: 'UML Class Diagram'.
	proj := factory class: 'DCProject'.
	dia := factory class: 'DCDiagram'.
	el := factory class: 'DCNamedElement'.
	obj := factory class: 'DCModelObject'.
	obj addAttribute: (factory attribute: 'dcID : UUID').
	obj addAttribute: (factory attribute: 'dcName : String').

	proj addMethod: (factory method: 'addDiagram(aDiagram : DCDiagram)').
	proj addMethod: (factory method: 'layoutFor(aDiagram : DCDiagram): Dictionary').

	model
		add: proj;
		add: dia;
		add: el;
		add: obj.

	model add: (FAMIXInheritance subclass: el superclass: obj).
	model add: (FAMIXInheritance subclass: dia superclass: obj).

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
		multiplicity: DCFAMIXMultiplicity zeroToOne.

	^ model