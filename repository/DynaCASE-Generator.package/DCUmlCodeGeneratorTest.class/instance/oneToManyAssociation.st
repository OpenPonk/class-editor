instance creation
oneToManyAssociation
	| source target association |
	source := FAMIXClass named: 'University'.
	target := FAMIXClass named: 'Department'.
	association := DCFAMIXBinaryAssociation source: source target: target.
	association sourceEnd
		name: 'university';
		multiplicity: DCFAMIXMultiplicity one.
	association targetEnd
		name: 'departments';
		aggregation: DCUmlAggregationKind composite;
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	^ association