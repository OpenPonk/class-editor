instance creation
unidirectionalAssociation
	| source target association |
	source := FAMIXClass named: 'SourceSomething'.
	target := FAMIXClass named: 'TargetSomething'.
	association := OPFAMIXBinaryAssociation source: source target: target.
	association name: 'elements>'.
	association sourceEnd
		name: 'owner';
		beNonNavigable;
		multiplicity: OPFAMIXMultiplicity one.
	association targetEnd
		name: 'elements';
		multiplicity: OPFAMIXMultiplicity zeroToMany.
	^ association