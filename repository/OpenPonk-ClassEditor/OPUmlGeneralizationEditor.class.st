"
I am a Spec presenter acting as a dedicated editor for a specific UML Generalization. I provide a UI to view the specific and general classifiers, and edit comments and generalization sets.
"
Class {
	#name : 'OPUmlGeneralizationEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'controller',
		'generalLabel',
		'general',
		'specificLabel',
		'specific',
		'commentLabel',
		'commentTextArea',
		'generalizationSetsEditor',
		'viewModel',
		'undoManager'
	],
	#category : 'OpenPonk-ClassEditor-UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'UI'
}

{ #category : 'saving' }
OPUmlGeneralizationEditor >> basicSave [
	| commentCommand |
	generalizationSetsEditor basicSave.
	commentCommand := OPUmlUpdateGeneralizationCommentCommand new
		generalization: self model
		commentText: commentTextArea text trim.
	self undoManager
		ifNotNil: [ :manager | manager execute: commentCommand ]
		ifNil: [ commentCommand execute ].
	self viewModel ifNotNil: #modelChanged
]

{ #category : 'accessing' }
OPUmlGeneralizationEditor >> commentTextArea [
	^ commentTextArea
]

{ #category : 'initialization' }
OPUmlGeneralizationEditor >> controller: aGeneralizationController [
	controller := aGeneralizationController.
	aGeneralizationController ifNotNil: [ self viewModel: aGeneralizationController viewModel ]
]

{ #category : 'layout' }
OPUmlGeneralizationEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.4;
				   add: (SpTabLayout new
						    add: (SpBoxLayout newVertical
								     add: (SpBoxLayout newHorizontal
										      add: generalLabel width: 70;
										      add: general;
										      yourself)
								     expand: false;
								     add: (self instantiate: SpLabelPresenter new)
								     expand: false;
								     add: (SpBoxLayout newHorizontal
										      add: specificLabel width: 70;
										      add: specific;
										      yourself)
								     expand: false;
								     add: (self instantiate: SpLabelPresenter new)
								     expand: false;
								     add: (SpBoxLayout newHorizontal
										      add: commentLabel width: 70;
										      add: commentTextArea;
										      yourself)
								     height: 100;
								     yourself)
						    label: 'Generalization';
						    yourself);
				   add: (SpTabLayout new
						    add: generalizationSetsEditor label: 'Generalization Sets';
						    yourself);
				   yourself);
		  yourself
]

{ #category : 'accessing' }
OPUmlGeneralizationEditor >> generalizationSetsEditor [
	^ generalizationSetsEditor
]

{ #category : 'initialization' }
OPUmlGeneralizationEditor >> initializePresenters [

	super initializePresenters.

	generalLabel := self newLabel.
	generalLabel label: 'General:'.
	general := self newLabel.
	specificLabel := self newLabel.
	specificLabel label: 'Specific:'.
	specific := self newLabel.
	commentLabel := self newLabel.
	commentLabel label: 'Comment:'.
	commentTextArea := self newText.
	generalizationSetsEditor := self instantiate:
		                            OPUmlGeneralizationSetsOfControllerEditor
			                            new
]

{ #category : 'initialization' }
OPUmlGeneralizationEditor >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow
		title: 'Edit Generalization';
		initialExtent: 700 @ 500;
		closeOnBackdropClick: true;
		whenClosedDo: [ aWindow isCancelled ifFalse: [ self save ] ]
]

{ #category : 'accessing' }
OPUmlGeneralizationEditor >> model [
	^ self viewModel ifNotNil: #model
]

{ #category : 'actions' }
OPUmlGeneralizationEditor >> save [
	self undoManager
		ifNotNil: [ :mgr | mgr inTransaction: [ self basicSave ] ]
		ifNil: [ self basicSave ]
]

{ #category : 'accessing' }
OPUmlGeneralizationEditor >> undoManager [
	^ undoManager
]

{ #category : 'accessing' }
OPUmlGeneralizationEditor >> undoManager: anUndoManager [
	undoManager := anUndoManager.
	generalizationSetsEditor ifNotNil: [ :ed | ed undoManager: anUndoManager ]
]

{ #category : 'accessing' }
OPUmlGeneralizationEditor >> viewModel [
	^ viewModel
]

{ #category : 'initialization' }
OPUmlGeneralizationEditor >> viewModel: aGeneralizationViewModel [
	viewModel := aGeneralizationViewModel.
	general label: (viewModel model general name ifNil: [ '' ]).
	specific label: (viewModel model specific name ifNil: [ '' ]).
	commentTextArea text: (viewModel model ownedComments
		ifEmpty: [ '' ]
		ifNotEmpty: [ :comments | comments first body asString ]).
	generalizationSetsEditor viewModel: viewModel
]
