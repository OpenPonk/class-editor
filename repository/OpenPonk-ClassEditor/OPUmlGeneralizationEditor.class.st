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
		'generalizationSetsEditor'
	],
	#category : 'OpenPonk-ClassEditor-UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'UI'
}

{ #category : 'initialization' }
OPUmlGeneralizationEditor >> controller: aGeneralizationController [

	controller := aGeneralizationController.

	general label: (controller model general name ifNil: [ '' ]).
	specific label: (controller model specific name ifNil: [ '' ]).
	commentTextArea text: (controller model ownedComments
			 ifEmpty: [ '' ]
			 ifNotEmpty: [ :comments | comments first body asString ]).
	generalizationSetsEditor generalizationController: controller
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

	aWindow
		title: 'Edit Generalization';
		initialExtent: 700 @ 500;
		closeOnBackdropClick: true;
		whenClosedDo: [ aWindow isCancelled ifFalse: [ self save ] ]
]

{ #category : 'actions' }
OPUmlGeneralizationEditor >> save [

	generalizationSetsEditor save.
	commentTextArea text trim ifEmpty: [
		^ controller model ownedComments
			  do: [ :each | each annotatedElements removeAll ];
			  removeAll ].
	controller model ownedComments ifEmpty: [
		controller model ownedComments add: OPUMLComment new ].
	controller model ownedComments first body: commentTextArea text trim
]
