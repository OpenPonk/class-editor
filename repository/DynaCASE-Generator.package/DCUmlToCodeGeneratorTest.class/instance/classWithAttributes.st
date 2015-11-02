instance creation
classWithAttributes
	| model intAttr colAttr staticAttr |
	model := FAMIXClass named: 'SomethingGenerated'.
	intAttr := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	(colAttr := FAMIXAttribute named: 'collection' type: (FAMIXClass named: 'Float'))
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	(staticAttr := FAMIXAttribute named: 'something' type: (FAMIXClass named: 'Object'))
		isStatic: true.
	model
		addAttribute: intAttr;
		addAttribute: colAttr;
		addAttribute: staticAttr.
	^ model