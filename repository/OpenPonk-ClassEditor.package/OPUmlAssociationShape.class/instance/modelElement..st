accessing
modelElement: anObject
	super modelElement: anObject.
	sourceEndLabels modelElement: anObject memberEnds first.
	targetEndLabels modelElement: anObject memberEnds second