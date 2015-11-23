accessing
initialize
	super initialize.
	name := ''.
	sourceEnd := DCFAMIXAssociationEnd on: self.
	targetEnd := DCFAMIXAssociationEnd on: self