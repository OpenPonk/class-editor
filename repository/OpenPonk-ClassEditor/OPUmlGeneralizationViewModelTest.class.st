Class {
	#name : 'OPUmlGeneralizationViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testRegisterModelInRejectsNonClassifierParent [
	| specificClassifier generalClassifier generalization project projectController viewModelRegistry generalizationViewModel invalidParent |
	specificClassifier := OPUMLClass new name: 'SpecificClass'.
	generalClassifier := OPUMLClass new name: 'GeneralClass'.
	generalization := OPUMLGeneralization new
		specific: specificClassifier;
		general: generalClassifier;
		yourself.

	project := OPProject named: 'GeneralizationContractTestProject'.
	project addModel: specificClassifier.
	project addModel: generalClassifier.
	projectController := project controllerClass new
		project: project;
		yourself.
	viewModelRegistry := projectController viewModelRegistry.
	generalizationViewModel := viewModelRegistry viewModelFor: generalization.

	invalidParent := OPUMLPackage new name: 'InvalidParentPackage'.

	"Rule 4b: registerModelIn: must not silently return on unsupported parent"
	self
		should: [ generalizationViewModel registerModelIn: invalidParent ]
		raise: AssertionFailure
		description: 'registerModelIn: must strictly reject non-classifier parent'
]

{ #category : 'tests' }
OPUmlGeneralizationViewModelTest >> testRegisterModelInRestoresGeneralizationInSpecificClassifier [
	| specificClassifier generalClassifier generalization project projectController viewModelRegistry generalizationViewModel |
	specificClassifier := OPUMLClass new name: 'SpecificClass'.
	generalClassifier := OPUMLClass new name: 'GeneralClass'.
	generalization := OPUMLGeneralization new
		specific: specificClassifier;
		general: generalClassifier;
		yourself.

	project := OPProject named: 'GeneralizationUndoTestProject'.
	project addModel: specificClassifier.
	project addModel: generalClassifier.
	projectController := project controllerClass new
		project: project;
		yourself.
	viewModelRegistry := projectController viewModelRegistry.
	generalizationViewModel := viewModelRegistry viewModelFor: generalization.

	"Verify parent container resolution"
	self assert: generalizationViewModel parentContainerModel equals: specificClassifier.

	"In red phase, registerModelIn: is empty and does not add generalization to specificClassifier"
	generalizationViewModel registerModelIn: specificClassifier.
	self assertCollection: specificClassifier generalizations hasSameElements: { generalization }
]
