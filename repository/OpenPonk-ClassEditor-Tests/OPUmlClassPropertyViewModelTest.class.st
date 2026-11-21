"
Tests property bindings and synchronization between UML class attributes and form presenters.
"
Class {
	#name : 'OPUmlClassPropertyViewModelTest',
	#superclass : 'OPAbstractViewModelTest',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPUmlClassPropertyViewModelTest >> modelClass [

	^ OPUMLProperty
]

{ #category : 'initialization' }
OPUmlClassPropertyViewModelTest >> newModel [

	^ OPUMLProperty new
		  name: 'sampleAttribute';
		  yourself
]

{ #category : 'initialization' }
OPUmlClassPropertyViewModelTest >> newRootModel [

	^ OPUMLPackage new
		  name: 'RootPackage';
		  yourself
]

{ #category : 'initialization' }
OPUmlClassPropertyViewModelTest >> setUpParentModel [

	| ownerClass |
	ownerClass := OPUMLClass new
		              name: 'OwnerClass';
		              yourself.
	rootModel packagedElements add: ownerClass.
	^ ownerClass
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testDescriptionTypeCleanupUnusedTemporaryTypes [

	| testProject package umlClass prop testRegistry propViewModel desc commonPkg typeNames |
	testProject := OPProject new.
	package := OPUmlClassEditorPlugin new newModel.
	testProject addModel: package.
	umlClass := OPUMLClass new name: 'Car'.
	prop := OPUMLProperty new name: 'speed'.
	umlClass ownedAttributes: { prop }.
	package packagedElements add: umlClass.
	testRegistry := OPViewModelRegistry forProject: testProject.
	propViewModel := testRegistry viewModelFor: prop.
	desc := propViewModel descriptionType.

	desc write: 'Wh' to: propViewModel.
	desc write: 'WholeBlood' to: propViewModel.

	commonPkg := package packagedElements detect: [ :each | each name = 'CommonTypes' ].
	typeNames := commonPkg packagedElements collect: #name.

	self assertCollection: typeNames includesAll: #( 'WholeBlood' ).
	self denyCollection: typeNames includesAny: #( 'Wh' )
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testDescriptionTypeHasEntryCompletion [

	| testProject package umlClass prop testRegistry propViewModel desc completion |
	testProject := OPProject new.
	package := OPUmlClassEditorPlugin new newModel.
	testProject addModel: package.
	umlClass := OPUMLClass new name: 'Order'.
	prop := OPUMLProperty new name: 'created'.
	umlClass ownedAttributes: { prop }.
	package packagedElements add: umlClass.
	testRegistry := OPViewModelRegistry forProject: testProject.
	propViewModel := testRegistry viewModelFor: prop.

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

	| propertyViewModel unsupportedParent |
	propertyViewModel := OPUmlClassPropertyViewModel new.
	propertyViewModel model: OPUMLProperty new.
	unsupportedParent := Object new.

	self should: [ propertyViewModel registerModelIn: unsupportedParent ] raise: AssertionFailure
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testRemoveRenderDoesNotClearCommentIconDiagramElement [

	| classModel shape canvas commentIcon |
	classModel := OPUMLClass new name: 'CommentTestClass'.
	classModel ownedComments add: (OPUMLComment new body: 'Test comment').
	shape := OPUmlClassShape in: OPNoShape instance forModelElement: classModel.
	canvas := RSCanvas new.
	shape renderIn: canvas.

	commentIcon := shape instVarNamed: #commentIcon.
	self assert: commentIcon class equals: OPUmlCommentIcon.
	self assertCollection: shape ownedElements includesAll: { commentIcon }.

	shape removeRender.
	"Must fail in red phase because removeRender sets commentIcon := nil"
	self assert: (shape instVarNamed: #commentIcon) identicalTo: commentIcon
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testTypeNamedUnknownTypeReturnsDataTypeInCommonTypes [

	| testProject package commonTypesPkg prop propViewModel testRegistry resolvedType |
	testProject := OPProject new.
	package := OPUMLPackage new name: 'RootPackage'.
	testProject addModel: package.
	commonTypesPkg := OPUMLPackage new name: 'CommonTypes'.
	package packagedElements add: commonTypesPkg.

	prop := OPUMLProperty new name: 'testAttr'.
	package packagedElements add: (OPUMLClass new
			 name: 'TestClass';
			 ownedAttributes: { prop };
			 yourself).

	testRegistry := OPViewModelRegistry forProject: testProject.
	propViewModel := testRegistry viewModelFor: prop.

	resolvedType := propViewModel typeNamed: 'CustomStudentType'.
	self assert: (resolvedType oclIsKindOf: #DataType) description: 'Unknown type must be a DataType'.
	self deny: (resolvedType oclIsKindOf: #Class) description: 'Unknown type must not be a Class'.
	self assert: resolvedType name equals: 'CustomStudentType'.
	self assertCollection: commonTypesPkg packagedElements includesAny: { resolvedType }
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testUndoRestoresClassPropertyWhenParentIsAssociation [

	| association property propertyViewModel |
	association := OPUMLAssociation new name: 'testAssoc'.
	property := OPUMLProperty new name: 'testEnd'.
	property owningAssociation: association.
	propertyViewModel := OPUmlClassPropertyViewModel new.
	propertyViewModel model: property.

	propertyViewModel registerModelIn: association.

	self assertCollection: association ownedEnds hasSameElements: { property }.
	self assertCollection: association memberEnds hasSameElements: { property }.
	self assert: property owningAssociation equals: association
]

{ #category : 'constants' }
OPUmlClassPropertyViewModelTest >> viewModelClass [

	^ OPUmlClassPropertyViewModel
]
