"
I am a concrete context menu command that explicitly turns OFF (hides) the end labels for the currently selected UML relationship shape.
"
Class {
	#name : 'OPUmlUnsetEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-RoassalShape',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-RoassalShape'
}

{ #category : 'testing' }
OPUmlUnsetEndLabelsRoassalShapeCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any | any supportsHidingLabelEnds and: [ any owningElement exists ] ] ]
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

	| commands |
	commands := self applicableDiagramElements
		            select: [ :each | each owningElement exists ]
		            thenCollect: [ :each |
		            OPChangeDiagramElementStylePropertyCommand element: each property: each showAssociationEndLabelsKey value: nil ].
	commands ifEmpty: [ ^ self ].
	self undoManager
		ifNotNil: [ :activeUndoManager |
			activeUndoManager inTransaction: [ commands do: [ :eachCommand | activeUndoManager execute: eachCommand ] ] ]
		ifNil: [ commands do: #execute ]
]

{ #category : 'testing' }
OPUmlUnsetEndLabelsRoassalShapeCommand >> isCurrentlySelectedByStyle: aStyle [

	aStyle ifNil: [ ^ true ].
	^ (aStyle includesKey:
		   OPUmlAssociationEndLabel showAssociationEndLabelsKey) not
]
