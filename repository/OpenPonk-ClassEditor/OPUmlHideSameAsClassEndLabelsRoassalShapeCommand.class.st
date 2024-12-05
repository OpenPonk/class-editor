Class {
	#name : 'OPUmlHideSameAsClassEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlSetEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'hooks' }
OPUmlHideSameAsClassEndLabelsRoassalShapeCommand class >> styleState [

	^ #hideSame
]

{ #category : 'accessing' }
OPUmlHideSameAsClassEndLabelsRoassalShapeCommand >> basicMenuItemName [

	^ 'Hide same as class name'
]

{ #category : 'accessing' }
OPUmlHideSameAsClassEndLabelsRoassalShapeCommand >> defaultMenuIconFormSet [

	^ FormSet form: OPCoreIcons opHideSomeLabelsIcon
]

{ #category : 'accessing' }
OPUmlHideSameAsClassEndLabelsRoassalShapeCommand >> description [

	^ 'Hide association end labels with same text as name of its connected class'
]
