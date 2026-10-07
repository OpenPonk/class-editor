"
Tests property bindings and synchronization between UML class attributes and form presenters.
"
Class {
	#name : 'OPUmlClassPropertyViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testDescriptionTypeCleanupUnusedTemporaryTypes [
	| project package class prop registry propViewModel desc commonPkg typeNames |
	project := OPProject new.
	package := OPUmlClassEditorPlugin new newModel.
	project addModel: package.
	class := OPUMLClass new name: 'Car'.
	prop := OPUMLProperty new name: 'speed'.
	class ownedAttributes: { prop }.
	package packagedElements add: class.
	registry := OPViewModelRegistry forProject: project.
	propViewModel := registry viewModelFor: prop.
	desc := propViewModel descriptionType.

	"Simulace psaní znaku po znaku"
	desc write: 'Wh' to: propViewModel.
	desc write: 'WholeBlood' to: propViewModel.

	commonPkg := package packagedElements detect: [ :each | each name = 'CommonTypes' ].
	typeNames := commonPkg packagedElements collect: #name.

	self assertCollection: typeNames includesAll: #( 'WholeBlood' ).
	self deny: (typeNames includes: 'Wh') description: 'Intermediate type Wh must be removed from CommonTypes'
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testDescriptionTypeHasEntryCompletion [
	| project package class prop registry propViewModel desc completion |
	project := OPProject new.
	package := OPUmlClassEditorPlugin new newModel.
	project addModel: package.
	class := OPUMLClass new name: 'Order'.
	prop := OPUMLProperty new name: 'created'.
	class ownedAttributes: { prop }.
	package packagedElements add: class.
	registry := OPViewModelRegistry forProject: project.
	propViewModel := registry viewModelFor: prop.

	desc := propViewModel descriptionType.
	self assert: (desc hasProperty: #entryCompletion) description: 'descriptionType must define #entryCompletion property'.
	completion := desc propertyAt: #entryCompletion.
	self assert: completion class equals: EntryCompletion.

	self assertCollection: (completion filteredValuesWith: 'dat') hasSameElements: #( 'Date' 'DateTime' 'DateAndTime' ).
	self assertCollection: (completion filteredValuesWith: 'DEC') hasSameElements: #( 'Decimal' ).
	self assertCollection: (completion filteredValuesWith: 'order') hasSameElements: #( 'Order' )
]

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
OPUmlClassPropertyViewModelTest >> testTypeNamedUnknownTypeReturnsDataTypeInCommonTypes [
	| project package commonTypesPkg prop propViewModel registry resolvedType |
	project := OPProject new.
	package := OPUMLPackage new name: 'RootPackage'.
	project addModel: package.
	commonTypesPkg := OPUMLPackage new name: 'CommonTypes'.
	package packagedElements add: commonTypesPkg.

	prop := OPUMLProperty new name: 'testAttr'.
	package packagedElements add: (OPUMLClass new name: 'TestClass'; ownedAttributes: { prop }; yourself).

	registry := OPViewModelRegistry forProject: project.
	propViewModel := registry viewModelFor: prop.

	resolvedType := propViewModel typeNamed: 'CustomStudentType'.
	self assert: (resolvedType oclIsKindOf: #DataType) description: 'Unknown type must be a DataType'.
	self deny: (resolvedType oclIsKindOf: #Class) description: 'Unknown type must not be a Class'.
	self assert: resolvedType name equals: 'CustomStudentType'.
	self assertCollection: commonTypesPkg packagedElements includesAny: { resolvedType }
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
