Class {
	#name : 'OPUmlDiagramEndLabelsFigureCommand',
	#superclass : 'OPDiagramFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any |
			  any supportsHidingLabelEnds and: [
				  any showAssociationEndLabels ~= self resultingShowState ] ] ]
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand class >> isAbstract [

	^ self = OPUmlDiagramEndLabelsFigureCommand
]

{ #category : 'hooks' }
OPUmlDiagramEndLabelsFigureCommand class >> resultingShowState [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
OPUmlDiagramEndLabelsFigureCommand >> defaultMenuIconName [

	^ #smallLeftFlush
]

{ #category : 'execution' }
OPUmlDiagramEndLabelsFigureCommand >> execute [

	diagramElements
		select: [ :each | each supportsHidingLabelEnds ]
		thenDo: [ :each |
		each showAssociationEndLabels: self resultingShowState ]
]

{ #category : 'hooks' }
OPUmlDiagramEndLabelsFigureCommand >> resultingShowState [

	^ self class resultingShowState
]
