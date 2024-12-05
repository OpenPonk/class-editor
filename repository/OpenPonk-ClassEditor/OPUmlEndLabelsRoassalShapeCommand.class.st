Class {
	#name : 'OPUmlEndLabelsRoassalShapeCommand',
	#superclass : 'OPRoassalShapeCommand',
	#instVars : [
		'relevantDiagramElements'
	],
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
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

{ #category : 'as yet unclassified' }
OPUmlEndLabelsRoassalShapeCommand class >> defaultResultingShowState [

	^ OPUmlHideSameAsClassEndLabelsRoassalShapeCommand
		  styleState
]

{ #category : 'testing' }
OPUmlEndLabelsRoassalShapeCommand class >> isAbstract [

	^ self = OPUmlEndLabelsRoassalShapeCommand
]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
OPUmlEndLabelsRoassalShapeCommand >> defaultResultingShowState [
	^ self class defaultResultingShowState
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
