"
I am a concrete context menu command that explicitly turns ON (shows) all end labels for the currently selected UML relationship shape.
"
Class {
	#name : 'OPUmlShowEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlSetEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-RoassalShape',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-RoassalShape'
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
