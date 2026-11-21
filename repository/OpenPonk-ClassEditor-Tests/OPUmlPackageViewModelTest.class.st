"
Tests view model representations, containment semantics, and headers for UML packages.
"
Class {
	#name : 'OPUmlPackageViewModelTest',
	#superclass : 'OPAbstractViewModelTest',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPUmlPackageViewModelTest >> modelClass [

	^ OPUMLPackage
]

{ #category : 'initialization' }
OPUmlPackageViewModelTest >> newModel [

	^ OPUMLPackage new
		  name: 'SubPackage';
		  yourself
]

{ #category : 'initialization' }
OPUmlPackageViewModelTest >> newRootModel [

	^ OPUMLPackage new
		  name: 'RootPackage';
		  yourself
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testAllTypeElementsWithGeneralizationSet [

	| testProject package genSet types packageViewModel testRegistry |
	testProject := OPProject new.
	package := OPUMLPackage new.
	package name: 'RootPackage'.
	testProject addModel: package.

	genSet := OPUMLGeneralizationSet new.
	genSet name: 'PowerTypeSet'.
	package packagedElements add: genSet.

	testRegistry := OPViewModelRegistry forProject: testProject.
	packageViewModel := testRegistry viewModelFor: package.

	types := packageViewModel allTypeElements.
	self assertEmpty: types
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testAllTypeElementsWithNestedPackageAndTypes [

	| testProject rootPackage subPackage classA classB genSet types packageViewModel testRegistry |
	testProject := OPProject new.
	rootPackage := OPUMLPackage new.
	rootPackage name: 'RootPackage'.
	testProject addModel: rootPackage.

	classA := OPUMLClass new.
	classA name: 'ClassA'.
	rootPackage packagedElements add: classA.

	subPackage := OPUMLPackage new.
	subPackage name: 'SubPackage'.
	classB := OPUMLClass new.
	classB name: 'ClassB'.
	genSet := OPUMLGeneralizationSet new.
	genSet name: 'PowerTypeSet'.
	subPackage packagedElements add: classB.
	subPackage packagedElements add: genSet.
	rootPackage packagedElements add: subPackage.

	testRegistry := OPViewModelRegistry forProject: testProject.
	packageViewModel := testRegistry viewModelFor: rootPackage.

	types := packageViewModel allTypeElements.
	self assertCollection: types hasSameElements: {
			classA.
			classB }
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testDescriptionGeneralizationSets [
	"Verifies that descriptionGeneralizationSets provides read-only to-many description with correct label"

	| umlPackage packageViewModel description |
	umlPackage := OPUMLPackage new name: 'TestPackage'.
	packageViewModel := OPUmlPackageViewModel new.
	packageViewModel instVarNamed: 'model' put: umlPackage.

	description := packageViewModel descriptionGeneralizationSets.

	self assert: description label equals: 'Generalization Sets'.
	self assert: description isReadOnly description: 'Generalization Sets description must be read-only'.
	self assert: description priority equals: 20
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testVisitorBuildsGeneralizationSetsEditButtonForPackageViewModel [
	"Verifies that OPPropertiesFormMagritteVisitor produces Edit Generalization Sets button for OPUmlPackageViewModel description"

	| umlPackage packageViewModel form visitor editButton |
	umlPackage := OPUMLPackage new name: 'TestPackage'.
	packageViewModel := OPUmlPackageViewModel new.
	packageViewModel instVarNamed: 'model' put: umlPackage.

	form := OPPropertiesForm new.
	visitor := OPPropertiesFormMagritteVisitor new.
	visitor form: form.
	visitor viewModel: packageViewModel.

	visitor visitToManyRelationDescription: packageViewModel descriptionGeneralizationSets.

	editButton := form components
		              detect: [ :eachComponent |
		              eachComponent class == SpButtonPresenter and: [ eachComponent label = 'Edit Generalization Sets' ] ]
		              ifNone: [ nil ].

	self assert: editButton class equals: SpButtonPresenter.
	self assert: editButton label equals: 'Edit Generalization Sets'
]

{ #category : 'constants' }
OPUmlPackageViewModelTest >> viewModelClass [

	^ OPUmlPackageViewModel
]
