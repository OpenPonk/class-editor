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

{ #category : 'constants' }
OPUmlAssociationViewModelTest >> viewModelClass [

	^ OPUmlAssociationViewModel
]
