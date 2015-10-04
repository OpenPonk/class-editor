figures
createEdgeFrom: fromElement to: toElement
	^ DCUmlEdge new
		modelElement: self model;
		source: fromElement;
		target: toElement;
		headDecorator: RTEmptyNarrowArrow asHead;
		yourself