examples
sampleCompleteClass
	| model class |
	model := MooseModel named: 'Something'.
	class := FAMIXClass named: 'CompleteClass'.
	model add: class.
	class
		addAttribute:
			(FAMIXAttribute new
				name: 'normal';
				declaredType: (FAMIXClass named: 'Integer');
				yourself).
	class
		addAttribute:
			(FAMIXAttribute new
				name: 'collection';
				declaredType: (FAMIXClass named: 'Float');
				multiplicity: DCUmlMultiplicity zeroToMany;
				yourself).
	class
		addAttribute:
			(FAMIXAttribute new
				name: 'static';
				declaredType: (FAMIXClass named: 'String');
				isStatic: true;
				yourself).
	^ model