tests - diagram
testRemovalOfClassRemovesAssociationLabels
	diagramController
		showModelInDiagram: element;
		showModelInDiagram: comment;
		showModelInDiagram: association.
	self
		assert:
			(diagramController view elements
				count: [ :e | 
					(e trachelShape respondsTo: #text)
						and: [ {'owningElement' . 'ownedComment' . 'association' . '1'}
								includes: e trachelShape text ] ])
		equals: 5.
	controller := diagramController controllerForModel: element.
	controller remove.
	self
		assert:
			(diagramController view elements
				select: [ :e | 
					(e trachelShape respondsTo: #text)
						and: [ {'owningElement' . 'ownedComment' . 'association' . '1'}
								includes: e trachelShape text ] ]) asArray
		equals: #()