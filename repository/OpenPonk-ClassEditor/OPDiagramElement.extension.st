Extension { #name : 'OPDiagramElement' }

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> showAssociationEndLabels [

	^ self
		  stylePropertyNamed: #showAssociationEndLabels
		  ifAbsent: [ true ]
]

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> showAssociationEndLabels: aBoolean [

	self stylePropertyNamed: #showAssociationEndLabels put: aBoolean
]

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> supportsHidingLabelEnds [

	^ false
]
