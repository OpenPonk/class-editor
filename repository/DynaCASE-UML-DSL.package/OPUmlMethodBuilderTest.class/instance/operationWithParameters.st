instance creation
operationWithParameters
	| op p1 p2 |
	op := FAMIXMethod named: 'op'.
	p1 := FAMIXParameter named: 'first' type: (FAMIXClass named: 'String').
	(p2 := FAMIXParameter named: 'second' type: (FAMIXClass named: 'Number'))
		multiplicity: (DCFAMIXMultiplicity lower: 2 upper: 5).
	op addParameter: p1.
	op addParameter: p2.
	^ op