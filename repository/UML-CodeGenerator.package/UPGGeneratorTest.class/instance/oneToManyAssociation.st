instance creation
oneToManyAssociation
	| source target association |
	source := FAMIXClass named: 'University'.
	target := FAMIXClass named: 'Department'.
	association := OPFAMIXBinaryAssociation source: source target: target.
	association sourceEnd
		name: 'university';
		multiplicity: OPFAMIXMultiplicity one.
	association targetEnd
		name: 'departments';
		aggregation: OPUmlAggregationKind composite;
		multiplicity: OPFAMIXMultiplicity zeroToMany.
	^ association