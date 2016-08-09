figures
createEdgeFrom: fromElement to: toElement
	^ DCUmlEdge new
		modelElement: self model;
		source: fromElement;
		target: toElement;
		in: [ :e | e localStyle strokeColor: Color blue ];
		yourself