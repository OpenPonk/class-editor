Class {
	#name : 'OPUmlHideEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlSetEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'hooks' }
OPUmlHideEndLabelsRoassalShapeCommand class >> styleState [

	^ #show
]

{ #category : 'accessing' }
OPUmlHideEndLabelsRoassalShapeCommand >> basicMenuItemName [

	^ 'Hide all'
]

{ #category : 'accessing' }
OPUmlHideEndLabelsRoassalShapeCommand >> defaultMenuIconFormSet [

	^ FormSet form: OPCoreIcons opHideLabelsIcon
]

{ #category : 'accessing' }
OPUmlHideEndLabelsRoassalShapeCommand >> description [

	^ 'Hide all association end labels'
]
