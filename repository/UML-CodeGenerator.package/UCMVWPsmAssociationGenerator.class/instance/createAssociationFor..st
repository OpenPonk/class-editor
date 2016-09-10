as yet unclassified
createAssociationFor: anAssociation
	self
		resolveAssociationEnd: anAssociation sourceEnd
		in: (typesLookup at: anAssociation targetEnd declaredType).
	self
		resolveAssociationEnd: anAssociation targetEnd
		in: (typesLookup at: anAssociation sourceEnd declaredType)