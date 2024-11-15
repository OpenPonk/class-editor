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

	aWindow
		title: 'Generalization Sets Editor';
		initialExtent: 500 @ 750;
		closeOnBackdropClick: true;
		whenClosedDo: [ aWindow isCancelled ifFalse: [ self save ] ]
]
