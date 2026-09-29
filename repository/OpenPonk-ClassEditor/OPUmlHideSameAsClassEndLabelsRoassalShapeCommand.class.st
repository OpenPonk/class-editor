"
I am a concrete context menu command that hides end labels on a UML relationship shape if they match the default naming convention derived from the connected class names.
"
Class {
	#name : 'OPUmlHideSameAsClassEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlSetEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-RoassalShape',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-RoassalShape'
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
