generator - association
createAssociationFor: anAssociation
	self resolveAssociationEnd: anAssociation sourceEnd.
	self resolveAssociationEnd: anAssociation targetEnd