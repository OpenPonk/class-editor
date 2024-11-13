Class {
	#name : 'OPUmlDiagramHideEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlDiagramHideEndLabelsFigureCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any |
			  any showAssociationEndLabels ] ]
]

{ #category : 'hooks' }
OPUmlDiagramHideEndLabelsFigureCommand class >> resultingShowState [

	^ false
]

{ #category : 'accessing' }
OPUmlDiagramHideEndLabelsFigureCommand >> defaultMenuItemName [

	^ 'Hide association end labels'
]

{ #category : 'accessing' }
OPUmlDiagramHideEndLabelsFigureCommand >> description [

	^ 'Hide association end labels where the text is just name of the class'
]
