initialization
initialize
	super initialize.
	associationsGenerator := UCMVWPsmAssociationGenerator new.
	self context: UPGGeneratorContext new.
	typesLookup := Dictionary new