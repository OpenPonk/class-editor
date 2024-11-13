Class {
	#name : 'OPUmlDiagramHideEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramSetEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'hooks' }
OPUmlDiagramHideEndLabelsFigureCommand class >> resultingShowState [

	^ #show
]

{ #category : 'accessing' }
OPUmlDiagramHideEndLabelsFigureCommand >> basicMenuItemName [

	^ 'Hide all'
]

{ #category : 'accessing' }
OPUmlDiagramHideEndLabelsFigureCommand >> defaultMenuIconFormSet [

	^ FormSet form: OPCoreIcons opHideLabelsIcon
]

{ #category : 'accessing' }
OPUmlDiagramHideEndLabelsFigureCommand >> description [

	^ 'Hide all association end labels'
]
