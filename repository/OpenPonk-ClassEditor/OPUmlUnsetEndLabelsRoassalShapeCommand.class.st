Class {
	#name : 'OPUmlUnsetEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlUnsetEndLabelsRoassalShapeCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any |
			  any owningElement exists ] ]
]

{ #category : 'accessing' }
OPUmlUnsetEndLabelsRoassalShapeCommand >> basicMenuItemName [

	^ 'Use diagram-level setting'
]

{ #category : 'accessing' }
OPUmlUnsetEndLabelsRoassalShapeCommand >> description [

	^ 'Adopt option picked for the entire diagram, instead of overriding it'
]

{ #category : 'execution' }
OPUmlUnsetEndLabelsRoassalShapeCommand >> execute [

	self applicableDiagramElements
		select: [ :each | each owningElement exists ]
		thenDo: [ :each | each unsetAssociationEndLabels ]
]

{ #category : 'testing' }
OPUmlUnsetEndLabelsRoassalShapeCommand >> isCurrentlySelectedByStyle: aStyle [

	aStyle ifNil: [ ^ true ].
	^ (aStyle includesKey:
		   OPUmlAssociationEndLabel showAssociationEndLabelsKey) not
]
