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

{ #category : 'layout' }
OPUmlAllGeneralizationSetsEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: table;
		  yourself
]

{ #category : 'initialization' }
OPUmlAllGeneralizationSetsEditor >> initializeWindow: aWindow [

	| packageName |
	super initializeWindow: aWindow.
	packageName := (self targetPackage ifNotNil: [ :package | package name ]) ifNil: [ '' ].
	aWindow
		title: (String streamContents: [ :stream |
						 stream << 'Generalization Sets Editor ('.
						 stream << packageName.
						 stream << ')' ]);
		initialExtent: 500 @ 750;
		closeOnBackdropClick: true;
		whenClosedDo: [ aWindow isCancelled ifFalse: [ self save ] ]
]
