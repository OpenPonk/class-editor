examples
exampleSimpleOld
	| project diagram obj el dia proj |
	project := DCProject named: 'UML Class Diagram'.
	diagram := DCUmlClassDiagram named: 'UML Class Diagram'.
	project addDiagram: diagram.
	proj := DCUmlClass named: 'DCProject'.
	dia := DCUmlClass named: 'DCDiagram'.
	el := DCUmlClass named: 'DCNamedElement'.
	obj := DCUmlClass named: 'DCModelObject'.
	obj attributes: #('+dcID: string' '+dcName: string').

	diagram
		add: proj;
		add: dia;
		add: el;
		add: obj.

	diagram
		add: (DCUmlGeneralization from: el to: obj);
		add: (DCUmlGeneralization from: dia to: obj);
		add:
				((DCUmlAssociation from: dia to: el)
						sourceName: '+owner';
						sourceMultiplicity: '0..1';
						targetName: '+elements';
						targetMultiplicity: '*';
						yourself);
		add:
				((DCUmlAssociation from: obj to: obj)
						targetName: '+owner';
						sourceMultiplicity: '*';
						targetMultiplicity: '0..1';
						yourself);
		add:
				((DCUmlAssociation from: proj to: dia)
						targetName: '+diagrams';
						targetMultiplicity: '*';
						sourceMultiplicity: '0..1';
						yourself).

	DCWorkbench openProject: project