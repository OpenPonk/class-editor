Class {
	#name : 'OPUmlDiagramEndLabelsFigureCommand',
	#superclass : 'OPDiagramFigureCommand',
	#instVars : [
		'relevantDiagramElements'
	],
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any |
			  any supportsHidingLabelEnds ] ]
]

{ #category : 'activation' }
OPUmlDiagramEndLabelsFigureCommand class >> contextMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: OPUmlDiagramEndLabelsFigureMenuGroup
		  for: OPCanvasPresenter
]

{ #category : 'as yet unclassified' }
OPUmlDiagramEndLabelsFigureCommand class >> defaultResultingShowState [

	^ OPUmlDiagramHideSameAsClassEndLabelsFigureCommand
		  styleState
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand class >> isAbstract [

	^ self = OPUmlDiagramEndLabelsFigureCommand
]

{ #category : 'as yet unclassified' }
OPUmlDiagramEndLabelsFigureCommand >> applicableDiagramElements [

	^ relevantDiagramElements ifNil: [
		  relevantDiagramElements := diagramElements select: [ :each |
			                             each supportsHidingLabelEnds ] ]
]

{ #category : 'accessing' }
OPUmlDiagramEndLabelsFigureCommand >> basicMenuItemName [

	^ ''
]

{ #category : 'accessing' }
OPUmlDiagramEndLabelsFigureCommand >> defaultMenuItemName [

	| basicName |
	basicName := self basicMenuItemName.

	self isCurrentlySelected ifTrue: [ ^ basicName , ' [selected]' ].

	self isCurrentlyActive ifTrue: [ ^ basicName , ' (active)' ].

	^ basicName
]

{ #category : 'as yet unclassified' }
OPUmlDiagramEndLabelsFigureCommand >> defaultResultingShowState [
	^ self class defaultResultingShowState
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand >> isCurrentlyActive [

	^ false
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand >> isCurrentlySelected [

	^ self applicableDiagramElements anySatisfy: [ :any |
		  self isCurrentlySelectedByStyle: any localStyle ]
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand >> isCurrentlySelectedByStyle: aStyle [

	^ self subclassResponsibility
]
