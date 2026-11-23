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
OPUmlGeneralizationViewModelTest >> testBasicRemoveModelFallsBackToParentPackageAndHandlesAbsentLinks [

	| generalClass specificClass isolatedGeneralization isolatedSet parentPackageViewModel detachedViewModel |
	generalClass := OPUMLClass new name: 'General'.
	specificClass := OPUMLClass new name: 'Specific'.
	parentPackageViewModel := registry viewModelFor: rootModel.

	isolatedGeneralization := OPUMLGeneralization new
		                          general: generalClass;
		                          specific: specificClass;
		                          yourself.
	isolatedSet := OPUMLGeneralizationSet new name: 'OrphanSet'.
	isolatedGeneralization instVarNamed: #generalizationSets put: (OrderedCollection with: isolatedSet).

	detachedViewModel := registry viewModelFor: isolatedGeneralization.
	detachedViewModel instVarNamed: #parentViewModel put: parentPackageViewModel.
	detachedViewModel basicRemoveModel.
	self assert: isolatedGeneralization general identicalTo: nil.
	self assert: isolatedGeneralization specific identicalTo: nil
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testBasicRemoveModelRemovesEmptyGeneralizationSet [

	| genSet |
	genSet := OPUMLGeneralizationSet new name: 'TempSet'.
	genSet generalizations add: model.
	rootModel packagedElements add: genSet.

	viewModel removeModel.

	self assertEmpty: genSet generalizations.
	self denyCollection: rootModel packagedElements includesAny: { genSet }.
	self assert: model general isNil description: 'General must be cleared on removal'.
	self assert: model specific isNil description: 'Specific must be cleared on removal'
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testBasicRemoveModelWithMultipleGeneralizationSetsAndOwningSubpackage [

	| subPackage emptySet sharedSet otherSpecific otherGeneralization |
	subPackage := OPUMLPackage new
		              name: 'SubPackage';
		              yourself.
	rootModel packagedElements add: subPackage.

	emptySet := OPUMLGeneralizationSet new
		            name: 'EmptySet';
		            yourself.
	emptySet generalizations add: model.
	subPackage packagedElements add: emptySet.

	otherSpecific := OPUMLClass new
		                 name: 'OtherSpecific';
		                 yourself.
	rootModel packagedElements add: otherSpecific.
	otherGeneralization := OPUMLGeneralization new
		                       general: targetModel;
		                       specific: otherSpecific;
		                       yourself.
	otherSpecific generalizations add: otherGeneralization.

	sharedSet := OPUMLGeneralizationSet new
		             name: 'SharedSet';
		             yourself.
	sharedSet generalizations add: model.
	sharedSet generalizations add: otherGeneralization.
	rootModel packagedElements add: sharedSet.

	viewModel removeModel.

	self assertEmpty: emptySet generalizations.
	self denyCollection: subPackage packagedElements includesAny: { emptySet }.
	self assertCollection: sharedSet generalizations hasSameElements: { otherGeneralization }.
	self assertCollection: rootModel packagedElements includesAll: { sharedSet }.
	self assert: model general isNil description: 'General must be cleared on removal'.
	self assert: model specific isNil description: 'Specific must be cleared on removal'
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testDescriptionGeneralAndSpecificReadNames [

	self assert: (viewModel descriptionGeneral accessor read: viewModel) equals: 'GeneralClass'.
	self assert: (viewModel descriptionSpecific accessor read: viewModel) equals: 'SpecificClass'
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testDescriptionGeneralAndSpecificReturnEmptyStringWhenNil [

	| emptyGeneralization emptyViewModel |
	emptyGeneralization := OPUMLGeneralization new.
	emptyViewModel := OPUmlGeneralizationViewModel new model: emptyGeneralization.

	self assert: (emptyViewModel descriptionGeneral accessor read: emptyViewModel) equals: ''.
	self assert: (emptyViewModel descriptionSpecific accessor read: emptyViewModel) equals: ''
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testDescriptionGeneralizationSetsDisplayAndWriteError [

	| description namedSet unnamedSet |
	description := viewModel descriptionGeneralizationSets.
	namedSet := OPUMLGeneralizationSet new name: 'Kinds'.
	namedSet generalizations add: model.
	unnamedSet := OPUMLGeneralizationSet new name: '   '.

	self assert: (description displayStringFor: namedSet) equals: ' - Kinds (1 generalization)'.
	self assert: (description displayStringFor: unnamedSet) equals: ' - generalization set (0 generalizations)'.
	self assertCollection: (description accessor read: viewModel) hasSameElements: { namedSet }.
	self should: [ description accessor write: #(  ) to: viewModel ] raise: Error
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testModelDisplayStringWithNilEndpoints [

	| emptyGeneralization emptyViewModel displayString |
	emptyGeneralization := OPUMLGeneralization new.
	emptyViewModel := OPUmlGeneralizationViewModel new model: emptyGeneralization.

	displayString := String streamContents: [ :stream | emptyViewModel modelDisplayStringOn: stream ].
	self assert: displayString equals: '? => ? (Generalization)'
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testModelDisplayStringWithUnnamedClassifiers [

	| unnamedGeneralization unnamedViewModel displayString |
	unnamedGeneralization := OPUMLGeneralization new
		                         specific: OPUMLClass new;
		                         general: OPUMLClass new;
		                         yourself.
	unnamedViewModel := OPUmlGeneralizationViewModel new model: unnamedGeneralization.

	displayString := String streamContents: [ :stream | unnamedViewModel modelDisplayStringOn: stream ].
	self assert: displayString equals: '? => ? (Generalization)'
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
