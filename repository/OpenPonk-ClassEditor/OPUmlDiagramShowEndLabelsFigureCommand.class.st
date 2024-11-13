Class {
	#name : 'OPUmlDiagramShowEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramSetEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'hooks' }
OPUmlDiagramShowEndLabelsFigureCommand class >> resultingShowState [

	^ #hide
]

{ #category : 'accessing' }
OPUmlDiagramShowEndLabelsFigureCommand >> basicMenuItemName [

	^ 'Show all'
]

{ #category : 'accessing' }
OPUmlDiagramShowEndLabelsFigureCommand >> defaultMenuIconFormSet [

	^ FormSet form: OPCoreIcons opShowLabelsIcon
]

{ #category : 'accessing' }
OPUmlDiagramShowEndLabelsFigureCommand >> description [

	^ 'Show all association end labels'
]
