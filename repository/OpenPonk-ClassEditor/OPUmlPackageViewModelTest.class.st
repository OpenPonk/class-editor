"
Tests view model representations, containment semantics, and headers for UML packages.
"
Class {
	#name : 'OPUmlPackageViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testAllTypeElementsWithGeneralizationSet [
	| project package genSet types packageViewModel registry |
	project := OPProject new.
	package := OPUMLPackage new.
	package name: 'RootPackage'.
	project addModel: package.

	genSet := OPUMLGeneralizationSet new.
	genSet name: 'PowerTypeSet'.
	package packagedElements add: genSet.

	registry := OPViewModelRegistry forProject: project.
	packageViewModel := registry viewModelFor: package.

	types := packageViewModel allTypeElements.
	self assert: types isEmpty
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testAllTypeElementsWithNestedPackageAndTypes [
	| project rootPackage subPackage classA classB genSet types packageViewModel registry |
	project := OPProject new.
	rootPackage := OPUMLPackage new.
	rootPackage name: 'RootPackage'.
	project addModel: rootPackage.

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

	registry := OPViewModelRegistry forProject: project.
	packageViewModel := registry viewModelFor: rootPackage.

	types := packageViewModel allTypeElements.
	self assertCollection: types hasSameElements: { classA . classB }
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
	self assert: description isReadOnly.
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

	editButton := form components detect: [ :eachComponent |
		(eachComponent respondsTo: #label) and: [ eachComponent label = 'Edit Generalization Sets' ] ].

	self assert: editButton isNotNil
]
