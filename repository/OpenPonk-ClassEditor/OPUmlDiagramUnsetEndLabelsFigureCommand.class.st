Class {
	#name : 'OPUmlDiagramUnsetEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlDiagramUnsetEndLabelsFigureCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any |
			  any owningElement exists ] ]
]

{ #category : 'accessing' }
OPUmlDiagramUnsetEndLabelsFigureCommand >> basicMenuItemName [

	^ 'Use diagram-level setting'
]

{ #category : 'execution' }
OPUmlDiagramUnsetEndLabelsFigureCommand >> execute [

	diagramElements
		select: [ :each | each owningElement exists ]
		thenDo: [ :each | each unsetAssociationEndLabels ]
]

{ #category : 'testing' }
OPUmlDiagramUnsetEndLabelsFigureCommand >> isCurrentStyle: aStyle [

	aStyle ifNil: [ ^ true ].
	^ (aStyle includesKey:
		   OPUmlAssociationEndLabel showAssociationEndLabelsKey) not
]
