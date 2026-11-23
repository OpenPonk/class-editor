"
I am a context menu command to toggle or configure the visibility of end labels (such as multiplicities and role names) on UML relationship shapes.
"
Class {
	#name : 'OPUmlEndLabelsRoassalShapeCommand',
	#superclass : 'OPRoassalShapeCommand',
	#instVars : [
		'relevantDiagramElements'
	],
	#category : 'OpenPonk-ClassEditor-Commands-RoassalShape',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-RoassalShape'
}

{ #category : 'testing' }
OPUmlEndLabelsRoassalShapeCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any |
			  any supportsHidingLabelEnds ] ]
]

{ #category : 'activation' }
OPUmlEndLabelsRoassalShapeCommand class >> contextMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: OPUmlEndLabelsRoassalShapeMenuGroup
		  for: OPCanvasPresenter
]

{ #category : 'accessing' }
OPUmlEndLabelsRoassalShapeCommand class >> defaultResultingShowState [

	^ OPUmlHideSameAsClassEndLabelsRoassalShapeCommand
		  styleState
]

{ #category : 'testing' }
OPUmlEndLabelsRoassalShapeCommand class >> isAbstract [

	^ self = OPUmlEndLabelsRoassalShapeCommand
]

{ #category : 'accessing' }
OPUmlEndLabelsRoassalShapeCommand >> applicableDiagramElements [

	^ relevantDiagramElements ifNil: [
		  relevantDiagramElements := diagramElements select: [ :each |
			                             each supportsHidingLabelEnds ] ]
]

{ #category : 'accessing' }
OPUmlEndLabelsRoassalShapeCommand >> basicMenuItemName [

	^ ''
]

{ #category : 'accessing' }
OPUmlEndLabelsRoassalShapeCommand >> defaultMenuItemName [

	| basicName |
	basicName := self basicMenuItemName.

	self isCurrentlySelected ifTrue: [ ^ basicName , ' [selected]' ].

	self isCurrentlyActive ifTrue: [ ^ basicName , ' (active)' ].

	^ basicName
]

{ #category : 'testing' }
OPUmlEndLabelsRoassalShapeCommand >> isCurrentlyActive [

	^ false
]

{ #category : 'testing' }
OPUmlEndLabelsRoassalShapeCommand >> isCurrentlySelected [

	^ self applicableDiagramElements anySatisfy: [ :any |
		  self isCurrentlySelectedByStyle: any localStyle ]
]

{ #category : 'testing' }
OPUmlEndLabelsRoassalShapeCommand >> isCurrentlySelectedByStyle: aStyle [

	^ self subclassResponsibility
]
