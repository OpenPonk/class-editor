instance creation
operationWithParameters
	| op p1 p2 |
	op := DCUmlOperation named: 'op'.
	(p1 := DCUmlParameter named: 'first') type: 'String'.
	(p2 := DCUmlParameter named: 'second')
		type: 'Number';
		multiplicity: (DCUmlMultiplicity lower: 2 upper: 5).
	op parameters: (OrderedCollection with: p1 with: p2).
	^ op