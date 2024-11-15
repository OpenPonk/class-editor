Extension { #name : 'OPDiagram' }

{ #category : '*OpenPonk-ClassEditor' }
OPDiagram >> supportsHidingLabelEnds [

	^ self modelElement isNotNil and: [
		  self modelElement isKindOf: OPUMLPackage ]
]
