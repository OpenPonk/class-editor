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

{ #category : 'accessing' }
OPUmlDiagramUnsetEndLabelsFigureCommand >> description [

	^ 'Adopt option picked for the entire diagram, instead of overriding it'
]

{ #category : 'execution' }
OPUmlDiagramUnsetEndLabelsFigureCommand >> execute [

	self applicableDiagramElements
		select: [ :each | each owningElement exists ]
		thenDo: [ :each | each unsetAssociationEndLabels ]
]

{ #category : 'testing' }
OPUmlDiagramUnsetEndLabelsFigureCommand >> isCurrentlySelectedByStyle: aStyle [

	aStyle ifNil: [ ^ true ].
	^ (aStyle includesKey:
		   OPUmlAssociationEndLabel showAssociationEndLabelsKey) not
]
