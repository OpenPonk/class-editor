figures
createEdgeFrom: fromElement to: toElement
	^ OPUmlEdge new
		modelElement: self model;
		source: fromElement;
		target: toElement;
		headDecorator: RTEmptyNarrowArrow;
		yourself