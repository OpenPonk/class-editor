initialization
initialize
	super initialize.
	elements := Dictionary new.
	(packagedElementVisitor := DCUmlXmiPackagedElementVisitor new) elements: elements