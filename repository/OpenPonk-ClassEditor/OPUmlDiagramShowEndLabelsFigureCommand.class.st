Class {
	#name : 'OPUmlDiagramShowEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlDiagramShowEndLabelsFigureCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext diagramElements anySatisfy: [ :any |
			  any showAssociationEndLabels not ] ]
]

{ #category : 'hooks' }
OPUmlDiagramShowEndLabelsFigureCommand class >> resultingShowState [

	^ true
]

{ #category : 'accessing' }
OPUmlDiagramShowEndLabelsFigureCommand >> defaultMenuItemName [

	^ 'Show association end labels'
]

{ #category : 'accessing' }
OPUmlDiagramShowEndLabelsFigureCommand >> description [

	^ 'Show association end labels even where the text is just name of the class'
]
