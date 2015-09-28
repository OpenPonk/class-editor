examples
sampleModel
	| model obj el dia proj |
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

	model
		add:
			(FAMIXInheritance new
				subclass: el;
				superclass: obj;
				yourself).

	"diagram
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
				yourself)."
	^ model