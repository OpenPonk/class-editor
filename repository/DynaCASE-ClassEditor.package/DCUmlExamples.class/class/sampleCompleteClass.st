examples
sampleCompleteClass
	| model class |
	model := MooseModel named: 'Something'.
	class := FAMIXClass named: 'CompleteClass'.
	model add: class.
	class addAttribute: (FAMIXAttribute named: 'normal' type: (FAMIXClass named: 'Integer')).
	class
		addAttribute:
			((FAMIXAttribute named: 'collection' type: (FAMIXClass named: 'Float'))
				multiplicity: DCUmlMultiplicity zeroToMany).
	class
		addAttribute:
			((FAMIXAttribute named: 'static' type: (FAMIXClass named: 'String')) isStatic: true).
	class
		addAttribute:
			((FAMIXAttribute named: 'abstract' type: (FAMIXClass named: 'Object')) isAbstract: true).

	class addMethod: (FAMIXMethod named: 'basicMethod').
	class
		addMethod:
			((FAMIXMethod named: 'staticMethod')
				addParameter: (FAMIXParameter named: 'number' type: (FAMIXClass named: 'Number'));
				isStatic: true).
	class
		addMethod:
			((FAMIXMethod named: 'abstractMethod')
				declaredType: (FAMIXClass named: 'String');
				addParameter: (FAMIXParameter named: 'arg1' type: (FAMIXClass named: 'Number'));
				addParameter:
					((FAMIXParameter named: 'arg2' type: (FAMIXClass named: 'String'))
						multiplicity: DCUmlMultiplicity zeroToOne);
				isAbstract: true).

	^ model