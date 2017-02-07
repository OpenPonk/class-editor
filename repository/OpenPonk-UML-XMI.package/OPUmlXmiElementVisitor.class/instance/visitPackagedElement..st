visitor
visitPackagedElement: anElement
	packagedElementVisitor visit: anElement.
	self visitChildren: anElement