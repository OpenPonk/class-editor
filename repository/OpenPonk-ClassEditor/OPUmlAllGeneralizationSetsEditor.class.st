"
I am a specialized Spec presenter extending OPUmlGeneralizationSetsEditor, designed to display and edit ALL generalization sets across the entire UML diagram, rather than those scoped to a single generalization.
"
Class {
	#name : 'OPUmlAllGeneralizationSetsEditor',
	#superclass : 'OPUmlGeneralizationSetsEditor',
	#category : 'OpenPonk-ClassEditor-UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'UI'
}

{ #category : 'initialize-release' }
OPUmlAllGeneralizationSetsEditor >> close [

	self withWindowDo: [ :window | window close ]
]

{ #category : 'layout' }
OPUmlAllGeneralizationSetsEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: table;
		  yourself
]

{ #category : 'accessing' }
OPUmlAllGeneralizationSetsEditor >> diagramController: aController [

	self controller: aController
]

{ #category : 'initialization' }
OPUmlAllGeneralizationSetsEditor >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow
		title: 'Generalization Sets Editor';
		initialExtent: 500 @ 750;
		closeOnBackdropClick: true;
		whenClosedDo: [ aWindow isCancelled ifFalse: [ self save ] ]
]
