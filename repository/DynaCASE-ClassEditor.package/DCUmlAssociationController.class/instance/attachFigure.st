events - registering
attachFigure
	super attachFigure.
	constraints := OrderedCollection new.
	self addAssociationFigures.
	self diagramElement ownedElements
		do:
			[ :each | 
			each renderIn: self diagramElement view.
			each rtElement @ RTDraggable ].
	constraints do: #value