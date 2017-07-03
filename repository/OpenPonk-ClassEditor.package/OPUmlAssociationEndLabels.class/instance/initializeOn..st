initialization
initializeOn: anAssociationShape
	self initialize.
	associationShape := anAssociationShape.
	nameLabel := OPUmlAssociationEndLabel new.
	nameLabel
		text: [ :model | model name ];
		owningElement: anAssociationShape.
	(multiplicityLabel := OPUmlMultiplicityLabel new)
		text: [ :model | model notationAssociationMultiplicityRange ];
		owningElement: anAssociationShape