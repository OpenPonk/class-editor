Class {
	#name : 'OPUmlDiagramHideSameAsClassEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramSetEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'hooks' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand class >> resultingShowState [

	^ #hideSame
]

{ #category : 'accessing' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand >> basicMenuItemName [

	^ 'Hide same as class name'
]

{ #category : 'accessing' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand >> defaultMenuIconFormSet [

	^ FormSet form: OPCoreIcons opHideSameLabelsIcon
]

{ #category : 'accessing' }
OPUmlDiagramHideSameAsClassEndLabelsFigureCommand >> description [

	^ 'Hide association end labels where the text is the same as name of the class'
]
