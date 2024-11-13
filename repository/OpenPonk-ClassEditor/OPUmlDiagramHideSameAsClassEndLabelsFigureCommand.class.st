Class {
	#name : 'OPUmlDiagramHideSameAsClassEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramSetEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'hooks' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand class >> styleState [

	^ #hideSame
]

{ #category : 'accessing' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand >> basicMenuItemName [

	^ 'Hide same as class name'
]

{ #category : 'accessing' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand >> defaultMenuIconFormSet [

	^ FormSet form: OPCoreIcons opHideSomeLabelsIcon
]

{ #category : 'accessing' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand >> description [

	^ 'Hide association end labels with same text as name of its connected class'
]
