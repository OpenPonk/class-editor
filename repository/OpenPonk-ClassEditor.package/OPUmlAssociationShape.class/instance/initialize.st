initialization
initialize
	super initialize.
	(nameLabel := OPUmlNameLabel new)
		text: [ :model | model name ];
		owningElement: self.
	sourceEndLabels := OPUmlAssociationEndLabels on: self.
	targetEndLabels := OPUmlAssociationEndLabels on: self.
	constraints := OrderedCollection new