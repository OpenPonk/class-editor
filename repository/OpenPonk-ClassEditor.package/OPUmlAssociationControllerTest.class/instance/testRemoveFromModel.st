tests - model
testRemoveFromModel
	| element ownedComment comment assoc owningElement |
	element := OPUMLClass new name: 'Element'.
	comment := OPUMLClass new name: 'Comment'.
	assoc := OPUMLAssociation new.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		owningClass: element;
		type: comment.
	(owningElement := OPUMLProperty new)
		name: 'owningElement';
		owningAssociation: assoc;
		type: element.
	assoc
		memberEnds:
			{ownedComment.
			owningElement}.
	diagramController
		showModelInDiagram: element;
		showModelInDiagram: comment;
		showModelInDiagram: assoc.
	controller := diagramController controllerForModel: assoc.
	controller removeModel.
	self assert: ownedComment association equals: nil