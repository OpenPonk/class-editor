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
OPUmlClassPropertyViewModelTest >> testRemoveRenderDoesNotClearCommentIconDiagramElement [
	| classModel shape canvas |
	classModel := OPUMLClass new name: 'CommentTestClass'.
	classModel ownedComments add: (OPUMLComment new body: 'Test comment').
	shape := OPUmlClassShape in: OPNoShape instance forModelElement: classModel.
	canvas := RSCanvas new.
	shape renderIn: canvas.

	self assert: (shape instVarNamed: #commentIcon) isNotNil.
	self assertCollection: shape ownedElements includesAll: { shape instVarNamed: #commentIcon }.

	shape removeRender.
	"Must fail in red phase because removeRender sets commentIcon := nil"
	self
		assert: (shape instVarNamed: #commentIcon) isNotNil
		description: 'removeRender must not destroy diagram element reference (Rule 4j)'
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
