accessing
decoratorFor: aProperty
	(aProperty name beginsWith: 'base_')
		ifTrue: [ ^ OPUmlEdgeMarkers filledArrow ].
	^ OPUmlEdgeMarkers none