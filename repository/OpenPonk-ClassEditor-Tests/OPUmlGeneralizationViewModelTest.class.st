"
Tests view model properties, label synchronization, and style settings for UML generalizations.
"
Class {
	#name : 'OPUmlGeneralizationViewModelTest',
	#superclass : 'OPAbstractDirectionalRelationshipViewModelTest',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPUmlGeneralizationViewModelTest >> modelClass [

	^ OPUMLGeneralization
]

{ #category : 'initialization' }
OPUmlGeneralizationViewModelTest >> newRootModel [

	^ OPUMLPackage new
		  name: 'RootPackage';
		  yourself
]

{ #category : 'initialization' }
OPUmlGeneralizationViewModelTest >> newSourceModel [

	^ OPUMLClass new
		  name: 'SpecificClass';
		  yourself
]

{ #category : 'initialization' }
OPUmlGeneralizationViewModelTest >> newTargetModel [

	^ OPUMLClass new
		  name: 'GeneralClass';
		  yourself
]

{ #category : 'initialization' }
OPUmlGeneralizationViewModelTest >> setUpParentModel [

	^ sourceModel
]

{ #category : 'constants' }
OPUmlGeneralizationViewModelTest >> sourceModelClass [

	^ OPUMLClass
]

{ #category : 'constants' }
OPUmlGeneralizationViewModelTest >> targetModelClass [

	^ OPUMLClass
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testRegisterModelInRejectsNonClassifierParent [

	| specificClassifier generalClassifier generalization testProject projectController viewModelRegistry generalizationViewModel invalidParent |
	specificClassifier := OPUMLClass new name: 'SpecificClass'.
	generalClassifier := OPUMLClass new name: 'GeneralClass'.
	generalization := OPUMLGeneralization new
		                  specific: specificClassifier;
		                  general: generalClassifier;
		                  yourself.

	testProject := OPProject named: 'GeneralizationContractTestProject'.
	testProject addModel: specificClassifier.
	testProject addModel: generalClassifier.
	projectController := testProject controllerClass new
		                     project: testProject;
		                     yourself.
	viewModelRegistry := projectController viewModelRegistry.
	generalizationViewModel := viewModelRegistry viewModelFor: generalization.

	invalidParent := OPUMLPackage new name: 'InvalidParentPackage'.

	self
		should: [ generalizationViewModel registerModelIn: invalidParent ]
		raise: AssertionFailure
		description: 'registerModelIn: must strictly reject non-classifier parent'
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testRegisterModelInRestoresGeneralizationInSpecificClassifier [

	| specificClassifier generalClassifier generalization testProject projectController viewModelRegistry generalizationViewModel |
	specificClassifier := OPUMLClass new name: 'SpecificClass'.
	generalClassifier := OPUMLClass new name: 'GeneralClass'.
	generalization := OPUMLGeneralization new
		                  specific: specificClassifier;
		                  general: generalClassifier;
		                  yourself.

	testProject := OPProject named: 'GeneralizationUndoTestProject'.
	testProject addModel: specificClassifier.
	testProject addModel: generalClassifier.
	projectController := testProject controllerClass new
		                     project: testProject;
		                     yourself.
	viewModelRegistry := projectController viewModelRegistry.
	generalizationViewModel := viewModelRegistry viewModelFor: generalization.

	self assert: generalizationViewModel parentContainerModel equals: specificClassifier.

	generalizationViewModel registerModelIn: specificClassifier.
	self assertCollection: specificClassifier generalizations hasSameElements: { generalization }
]

{ #category : 'constants' }
OPUmlGeneralizationViewModelTest >> viewModelClass [

	^ OPUmlGeneralizationViewModel
]
