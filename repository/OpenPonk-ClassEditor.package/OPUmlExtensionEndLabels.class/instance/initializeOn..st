initialization
initializeOn: anAssociationShape
	self initialize.
	associationShape := anAssociationShape.
	(nameLabel := OPUmlAssociationEndLabel new)
		text: [ :model | '' ];
		owningElement: anAssociationShape.
	(multiplicityLabel := OPUmlMultiplicityLabel new)
		text: [ :model | '' ];
		owningElement: anAssociationShape