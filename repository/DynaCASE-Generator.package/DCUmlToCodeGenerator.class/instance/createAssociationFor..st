generator - association
createAssociationFor: anAssociation
	self resolveAssociationEndFor: anAssociation sourceEnd opposite: anAssociation targetEnd.
	self resolveAssociationEndFor: anAssociation targetEnd opposite: anAssociation sourceEnd