tests - diagram
testRemovalOfClassRemovesAssociationLabels1
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
	elementController := diagramController controllerForModel: element.
	self
		deny:
			(diagramController view elements
				count: [ :e | 
					(e trachelShape respondsTo: #text)
						and: [ {'owningElement' . 'ownedComment' . 'association' . '1'}
								includes: e trachelShape text ] ])
		equals: 0.
	elementController removeModel.
	self
		assert:
			(diagramController view elements
				select: [ :e | 
					(e trachelShape respondsTo: #text)
						and: [ {'owningElement' . 'ownedComment' . 'association' . '1'}
								includes: e trachelShape text ] ]) asArray
		equals: #()