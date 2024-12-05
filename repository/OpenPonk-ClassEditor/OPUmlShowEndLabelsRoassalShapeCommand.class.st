Class {
	#name : 'OPUmlShowEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlSetEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'hooks' }
OPUmlShowEndLabelsRoassalShapeCommand class >> styleState [

	^ #hide
]

{ #category : 'accessing' }
OPUmlShowEndLabelsRoassalShapeCommand >> basicMenuItemName [

	^ 'Show all'
]

{ #category : 'accessing' }
OPUmlShowEndLabelsRoassalShapeCommand >> defaultMenuIconFormSet [

	^ FormSet form: OPCoreIcons opShowLabelsIcon
]

{ #category : 'accessing' }
OPUmlShowEndLabelsRoassalShapeCommand >> description [

	^ 'Show all association end labels'
]
