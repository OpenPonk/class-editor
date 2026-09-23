Class {
	#name : 'OPUmlPackageViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

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
