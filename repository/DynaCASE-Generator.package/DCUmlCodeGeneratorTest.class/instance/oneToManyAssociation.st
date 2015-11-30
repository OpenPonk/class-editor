instance creation
oneToManyAssociation
	| source target association |
	source := FAMIXClass named: 'University'.
	target := FAMIXClass named: 'Department'.
	association := DCFAMIXBinaryAssociation source: source target: target.
	association sourceEnd
		name: 'university';
		aggregation: DCUmlAggregationKind composite;
		multiplicity: DCFAMIXMultiplicity one.
	association targetEnd
		name: 'departments';
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	^ association