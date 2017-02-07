figures
createEdgeFrom: fromElement to: toElement
	^ OPUmlEdge new
		modelElement: self model;
		source: fromElement;
		target: toElement;
		in: [ :e | e localStyle strokeColor: Color blue ];
		yourself