initialization
initializeOn: anAssociationShape
	self initialize.
	associationShape := anAssociationShape.
	(nameLabel := OPUmlAssociationEndLabel new)
		text: [ :model | model notationStringWithoutType ];
		owningElement: anAssociationShape.
	(multiplicityLabel := OPUmlMultiplicityLabel new)
		text: [ :model | model notationAssociationMultiplicityRange ];
		owningElement: anAssociationShape