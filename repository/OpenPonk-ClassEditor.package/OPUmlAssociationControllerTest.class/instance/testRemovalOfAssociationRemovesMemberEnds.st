tests - diagram
testRemovalOfAssociationRemovesMemberEnds
	| elementController |
	diagramController
		showModelInDiagram: element;
		showModelInDiagram: comment;
		showModelInDiagram: association.
	diagramController model packagedElements
		addAll:
			{element.
			comment.
			association}.
	diagramController
		removeFromModel: association;
		removeFromModel: comment;
		removeFromModel: element.
	self assert: diagramController controllers asArray equals: #()