figures
createDiagramElement
	^ super createDiagramElement
		in: [ :e | e localStyle strokeDashLength: #(2 2) ];
		yourself