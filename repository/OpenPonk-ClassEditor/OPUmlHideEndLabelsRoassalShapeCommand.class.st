"
I am a concrete context menu command that explicitly turns OFF (hides) all end labels for the currently selected UML relationship shape.
"
Class {
	#name : 'OPUmlHideEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlSetEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-RoassalShape',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-RoassalShape'
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
