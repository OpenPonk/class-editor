initialization
initialize
	super initialize.
	(nameLabel := OPUmlNameLabel new)
		text: [ :model | model name ifNil: [ '' ] ];
		owningElement: self.
	sourceEndLabels := OPUmlAssociationEndLabels on: self.
	targetEndLabels := OPUmlAssociationEndLabels on: self.
	constraints := OrderedCollection new