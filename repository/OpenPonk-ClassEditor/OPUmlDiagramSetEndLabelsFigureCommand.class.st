Class {
	#name : 'OPUmlDiagramSetEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlDiagramSetEndLabelsFigureCommand class >> isAbstract [

	^ self = OPUmlDiagramSetEndLabelsFigureCommand
]

{ #category : 'hooks' }
OPUmlDiagramSetEndLabelsFigureCommand class >> resultingShowState [

	^ #''
]

{ #category : 'execution' }
OPUmlDiagramSetEndLabelsFigureCommand >> execute [

	diagramElements
		select: [ :each | each supportsHidingLabelEnds ]
		thenDo: [ :each |
		each showAssociationEndLabels: self resultingShowState ]
]

{ #category : 'testing' }
OPUmlDiagramSetEndLabelsFigureCommand >> isCurrentStyle: aStyle [

	aStyle ifNil: [ ^ false ].
	^ aStyle
		  at: OPUmlAssociationEndLabel showAssociationEndLabelsKey
		  ifPresent: [ :styleValue | styleValue = self resultingShowState ]
		  ifAbsent: [ false ]
]

{ #category : 'hooks' }
OPUmlDiagramSetEndLabelsFigureCommand >> resultingShowState [

	^ self class resultingShowState
]
