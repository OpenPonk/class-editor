initialization
initialize
	super initialize.
	elements := Dictionary new.
	(packagedElementVisitor := OPUmlXmiPackagedElementVisitor new) elements: elements