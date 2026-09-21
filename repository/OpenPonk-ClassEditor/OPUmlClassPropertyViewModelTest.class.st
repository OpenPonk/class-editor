Class {
	#name : 'OPUmlClassPropertyViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testRegisterModelInFailsOnUnsupportedParent [
	| viewModel unsupportedParent |
	viewModel := OPUmlClassPropertyViewModel new.
	viewModel model: OPUMLProperty new.
	unsupportedParent := Object new.

	self should: [ viewModel registerModelIn: unsupportedParent ] raise: AssertionFailure
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testUndoRestoresClassPropertyWhenParentIsAssociation [
	| association property viewModel |
	association := OPUMLAssociation new name: 'testAssoc'.
	property := OPUMLProperty new name: 'testEnd'.
	property owningAssociation: association.
	viewModel := OPUmlClassPropertyViewModel new.
	viewModel model: property.

	viewModel registerModelIn: association.

	self assertCollection: association ownedEnds hasSameElements: { property }.
	self assertCollection: association memberEnds hasSameElements: { property }.
	self assert: property owningAssociation equals: association
]
