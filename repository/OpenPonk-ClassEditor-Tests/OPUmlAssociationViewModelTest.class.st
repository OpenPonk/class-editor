"
Tests view model mappings, end multiplicity synchronization, and role labels for UML associations.
"
Class {
	#name : 'OPUmlAssociationViewModelTest',
	#superclass : 'OPAbstractDirectionalRelationshipViewModelTest',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPUmlAssociationViewModelTest >> modelClass [

	^ OPUMLAssociation
]

{ #category : 'initialization' }
OPUmlAssociationViewModelTest >> newRootModel [

	^ OPUMLPackage new
		  name: 'RootPackage';
		  yourself
]

{ #category : 'initialization' }
OPUmlAssociationViewModelTest >> newSourceModel [

	^ OPUMLClass new
		  name: 'ClassA';
		  yourself
]

{ #category : 'initialization' }
OPUmlAssociationViewModelTest >> newTargetModel [

	^ OPUMLClass new
		  name: 'ClassB';
		  yourself
]

{ #category : 'constants' }
OPUmlAssociationViewModelTest >> sourceModelClass [

	^ OPUMLClass
]

{ #category : 'constants' }
OPUmlAssociationViewModelTest >> targetModelClass [

	^ OPUMLClass
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testCanSwitchSourceAndTargetAndDescriptionActionWhenIncomplete [

	| incompleteAssociation incompleteViewModel |
	incompleteAssociation := OPUMLAssociation new.
	incompleteViewModel := OPUmlAssociationViewModel new model: incompleteAssociation.

	self
		deny: incompleteViewModel canSwitchSourceAndTarget
		description: 'Association with fewer than 2 ends cannot switch source and target'.
	self
		assert: incompleteViewModel descriptionActionSwitchSourceTarget isNil
		description: 'Action description must be nil when source and target cannot be switched'.
	incompleteViewModel switchSourceAndTarget.
	self assertEmpty: incompleteAssociation memberEnds
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testCreationPriorityIsHigherThanClassifierPriority [

	| classifierViewModel associationViewModel |
	classifierViewModel := OPUmlClassifierViewModel new.
	associationViewModel := OPUmlAssociationViewModel new.
	self assert: classifierViewModel creationPriority equals: 10.
	self assert: associationViewModel creationPriority equals: 20.
	self
		assert: classifierViewModel creationPriority < associationViewModel creationPriority
		description:
		'Classifier creation priority must be strictly lower than association priority to ensure nodes render before edges during Redo'
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testDescriptionIsNavigableWriteUpdatesNavigability [
	"Verifies that descriptionIsNavigable writes navigability directly to the view model without calling #viewModel."

	| descriptions desc targetEnd |
	descriptions := OPUmlPropertyMagritteDescriptions
		                reader: [ :aViewModel | aViewModel model memberEnds second ]
		                labelPrefix: 'Target: '.
	desc := descriptions descriptionIsNavigable.
	desc accessor write: true to: viewModel.
	targetEnd := model memberEnds second.
	self assert: targetEnd isNavigable description: 'Target association end must become navigable after write: true'.
	self assert: targetEnd owningClass identicalTo: sourceModel
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testModelDisplayStringWithNilTypes [

	| untypedAssociation untypedViewModel displayString |
	untypedAssociation := OPUMLAssociation new name: 'links'.
	untypedAssociation memberEnds
		add: OPUMLProperty new;
		add: OPUMLProperty new.
	untypedViewModel := OPUmlAssociationViewModel new model: untypedAssociation.

	displayString := String streamContents: [ :stream | untypedViewModel modelDisplayStringOn: stream ].
	self assert: displayString equals: 'links [? -> ?] (Association)'
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testModelDisplayStringWithUnnamedTypes [

	| unnamedAssociation unnamedViewModel displayString |
	unnamedAssociation := OPUMLAssociation new.
	unnamedAssociation memberEnds
		add: (OPUMLProperty new
				 type: OPUMLClass new;
				 yourself);
		add: (OPUMLProperty new
				 type: OPUMLClass new;
				 yourself).
	unnamedViewModel := OPUmlAssociationViewModel new model: unnamedAssociation.

	displayString := String streamContents: [ :stream | unnamedViewModel modelDisplayStringOn: stream ].
	self assert: displayString equals: '[? -> ?] (Association)'
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testModelTargetReturnsNilWhenFewerThanTwoEnds [

	| singleEndAssociation singleEndViewModel |
	singleEndAssociation := OPUMLAssociation new.
	singleEndAssociation memberEnds add: (OPUMLProperty new
			 type: sourceModel;
			 yourself).
	singleEndViewModel := OPUmlAssociationViewModel new model: singleEndAssociation.

	self assert: singleEndViewModel modelTarget isNil description: 'Association with one end must return nil target'
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testSwitchSourceAndTargetSwapsEndsAndAnnouncesEvents [

	| firstEnd secondEnd thirdEnd swappedCount rebuildCount actionDescription |
	firstEnd := model memberEnds first.
	secondEnd := model memberEnds second.
	thirdEnd := OPUMLProperty new
		            name: 'third';
		            yourself.
	model memberEnds add: thirdEnd.
	swappedCount := 0.
	rebuildCount := 0.
	viewModel announcer when: OPAssociationEndsSwapped do: [ swappedCount := swappedCount + 1 ] for: self.
	viewModel announcer when: OPElementFormNeedsRebuild do: [ rebuildCount := rebuildCount + 1 ] for: self.

	actionDescription := viewModel descriptionActionSwitchSourceTarget.
	actionDescription action value.

	self assert: model memberEnds first identicalTo: secondEnd.
	self assert: model memberEnds second identicalTo: firstEnd.
	self assert: (model memberEnds at: 3) identicalTo: thirdEnd.
	self assert: swappedCount equals: 1.
	self assert: rebuildCount equals: 1
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testValidateAndValidateMemberEndCount [

	| invalidAssociation invalidViewModel extraAttribute warnings |
	invalidAssociation := OPUMLAssociation new name: 'InvalidAssoc'.
	invalidAssociation memberEnds add: (OPUMLProperty new
			 name: 'onlyEnd';
			 type: sourceModel;
			 owningAssociation: invalidAssociation;
			 association: invalidAssociation;
			 yourself).
	extraAttribute := OPUMLProperty new
		                  name: 'unownedAttr';
		                  yourself.
	invalidAssociation ownedEnds add: extraAttribute.
	invalidViewModel := OPUmlAssociationViewModel new model: invalidAssociation.
	warnings := OrderedCollection new.

	[ invalidViewModel validate ]
		on: OPModelInvalid
		do: [ :warning |
				warnings add: warning messageText.
				warning resume ].

	self denyEmpty: warnings.
	self
		assert: (warnings anySatisfy: [ :text | text includesSubstring: 'memberEnds instead of 2' ])
		description: 'Validation must report invalid memberEnd count'
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testWriteMultiplicityFromTo [

	| property |
	property := OPUMLProperty new.

	viewModel writeMultiplicityFrom: '1' to: property.
	self assert: property lowerValue value equals: 1.
	self assert: property upperValue value equals: 1.

	viewModel writeMultiplicityFrom: '*' to: property.
	self assert: property lowerValue value equals: 0.
	self assert: property upperValue value equals: '*'.

	viewModel writeMultiplicityFrom: '2..5' to: property.
	self assert: property lowerValue value equals: 2.
	self assert: property upperValue value equals: 5.

	viewModel writeMultiplicityFrom: '1..*' to: property.
	self assert: property lowerValue value equals: 1.
	self assert: property upperValue value equals: '*'
]

{ #category : 'constants' }
OPUmlAssociationViewModelTest >> viewModelClass [

	^ OPUmlAssociationViewModel
]
