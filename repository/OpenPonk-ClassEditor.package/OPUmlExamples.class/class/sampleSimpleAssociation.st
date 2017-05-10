samples
sampleSimpleAssociation
	| model element ownedComment comment owningElement assoc project |
	model := OPUMLModel new name: 'Model'.
	element := OPUMLClass new name: 'Element'.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		owningClass: element.
	comment := OPUMLClass new name: 'Comment'.
	assoc := OPUMLAssociation new
		memberEnds:
			{ownedComment.
			owningElement}.
	model
		packagedElements:
			{element.
			comment.
			assoc}.
	^ model