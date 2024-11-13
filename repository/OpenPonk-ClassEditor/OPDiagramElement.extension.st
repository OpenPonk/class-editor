Extension { #name : 'OPDiagramElement' }

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> showAssociationEndLabels [

	^ self stylePropertyNamed: self showAssociationEndLabelsKey ifAbsent: [
		  OPUmlDiagramHideSameAsClassEndLabelsFigureCommand
			  resultingShowState ]
]

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> showAssociationEndLabels: aSymbol [

	self stylePropertyNamed: self showAssociationEndLabelsKey put: aSymbol
]

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement class >> showAssociationEndLabelsKey [

	^ #showAssociationEndLabels
]

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> showAssociationEndLabelsKey [

	^ self class showAssociationEndLabelsKey
]

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> supportsHidingLabelEnds [

	^ false
]

{ #category : '*OpenPonk-ClassEditor' }
OPDiagramElement >> unsetAssociationEndLabels [

	self removeLocalStylePropertyNamed: self showAssociationEndLabelsKey
]
