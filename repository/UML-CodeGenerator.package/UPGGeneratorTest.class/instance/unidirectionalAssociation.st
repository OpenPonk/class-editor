instance creation
unidirectionalAssociation
	| source target association |
	source := FAMIXClass named: 'SourceSomething'.
	target := FAMIXClass named: 'TargetSomething'.
	association := DCFAMIXBinaryAssociation source: source target: target.
	association name: 'elements>'.
	association sourceEnd
		name: 'owner';
		beNonNavigable;
		multiplicity: DCFAMIXMultiplicity one.
	association targetEnd
		name: 'elements';
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	^ association