initialization
initialize
	super initialize.
	sourceEndLabels := OPUmlAssociationEndLabels on: self.
	targetEndLabels := OPUmlAssociationEndLabels on: self.
	constraints := OrderedCollection new