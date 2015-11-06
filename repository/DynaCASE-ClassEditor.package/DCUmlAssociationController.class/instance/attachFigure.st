events - registering
attachFigure
	super attachFigure.
	constraints := OrderedCollection new.
	self addAssociationFigures.
	self diagramElement ownedElements
		do: [ :each | 
			each renderIn: self diagramElement view.
			each rtElement @ RTDraggable ].
	constraints do: #value.
	self figure from translateBy: 0 @ 0