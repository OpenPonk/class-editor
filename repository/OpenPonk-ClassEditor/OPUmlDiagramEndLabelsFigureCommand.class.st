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
			  any supportsHidingLabelEnds ] ]
]

{ #category : 'activation' }
OPUmlDiagramEndLabelsFigureCommand class >> contextMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: OPUmlDiagramEndLabelsFigureMenuGroup
		  for: OPCanvasPresenter
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand class >> isAbstract [

	^ self = OPUmlDiagramEndLabelsFigureCommand
]

{ #category : 'accessing' }
OPUmlDiagramEndLabelsFigureCommand >> basicMenuItemName [

	^ ''
]

{ #category : 'accessing' }
OPUmlDiagramEndLabelsFigureCommand >> defaultMenuItemName [

	| basicName |
	basicName := self basicMenuItemName.

	self isCurrent ifFalse: [ ^ basicName ].

	^ basicName , ' [current]'
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand >> isCurrent [

	^ diagramElements anySatisfy: [ :any |
		  self isCurrentStyle: any localStyle ]
]

{ #category : 'testing' }
OPUmlDiagramEndLabelsFigureCommand >> isCurrentStyle: aStyle [

	^ self subclassResponsibility
]
