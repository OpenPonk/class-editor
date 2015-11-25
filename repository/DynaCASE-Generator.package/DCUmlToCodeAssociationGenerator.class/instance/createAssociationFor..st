generator - association
createAssociationFor: anAssociation
	self
		resolveAssociationEnd: anAssociation sourceEnd
		in: (self classFor: anAssociation targetEnd property name).
	self
		resolveAssociationEnd: anAssociation targetEnd
		in: (self classFor: anAssociation sourceEnd property name)