Class {
	#name : 'OPUmlAssociationViewModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'registry',
		'association',
		'endA',
		'endB',
		'classA',
		'classB',
		'viewModel'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
OPUmlAssociationViewModelTest >> setUp [
	super setUp.
	project := OPProject new.
	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	endA := OPUMLProperty new name: 'roleA'; type: classA.
	endB := OPUMLProperty new name: 'roleB'; type: classB.
	association := OPUMLAssociation new name: 'AssocAB'.
	endA association: association.
	endB association: association.
	association memberEnds add: endA; add: endB.
	endA owningAssociation: association.
	endB owningAssociation: association.
	project addModel: (OPUMLPackage new name: 'RootPkg'; yourself).
	project models first packagedElements addAll: { classA . classB . association }.
	registry := OPViewModelRegistry forProject: project.
	viewModel := registry viewModelFor: association
]

{ #category : 'as yet unclassified' }
OPUmlAssociationViewModelTest >> tearDown [
	viewModel := nil.
	registry := nil.
	classA := nil.
	classB := nil.
	endA := nil.
	endB := nil.
	association := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPUmlAssociationViewModelTest >> testCreationPriorityIsHigherThanClassifierPriority [
	| classifierViewModel associationViewModel |
	classifierViewModel := OPUmlClassifierViewModel new.
	associationViewModel := OPUmlAssociationViewModel new.
	self
		assert: classifierViewModel creationPriority < associationViewModel creationPriority
		description: 'Classifier creation priority must be strictly lower than association priority to ensure nodes render before edges during Redo'.
]

{ #category : 'as yet unclassified' }
OPUmlAssociationViewModelTest >> testDescriptionIsNavigableWriteUpdatesNavigability [
	"Verifies that descriptionIsNavigable writes navigability directly to the view model without calling #viewModel."
	| descriptions desc |
	descriptions := OPUmlPropertyMagritteDescriptions
		reader: [ :aViewModel | aViewModel model memberEnds second ]
		labelPrefix: 'Target: '.
	desc := descriptions descriptionIsNavigable.
	desc accessor write: true to: viewModel.
	self assert: endB isNavigable
]
