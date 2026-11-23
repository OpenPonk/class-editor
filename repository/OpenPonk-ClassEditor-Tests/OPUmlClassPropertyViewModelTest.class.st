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
OPUmlClassPropertyViewModelTest >> testDescriptionDefaultValueClearAndNilWrite [

	| defaultValueDescription accessor |
	defaultValueDescription := viewModel descriptionDefaultValue.
	accessor := defaultValueDescription accessor.

	self assert: (accessor read: viewModel) equals: ''.

	accessor write: 'initial' to: viewModel.
	self assert: (accessor read: viewModel) equals: 'initial'.

	accessor write: '' to: viewModel.
	self assert: (accessor read: viewModel) equals: ''.

	accessor write: nil to: viewModel.
	self assert: (accessor read: viewModel) equals: ''.

	viewModel model defaultValue: (OPUMLLiteralString new value: 'literal').
	self assert: (accessor read: viewModel) equals: ''
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testDescriptionMultiplicityReadAndWrite [

	| description |
	description := viewModel descriptionMultiplicity.
	description accessor write: '1..*' to: viewModel.

	self assert: (description accessor read: viewModel) equals: '1..*'.
	self assert: model lowerBound equals: 1.
	self assert: model upperBound equals: '*'
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testDescriptionNameBlankUsesPlaceholderName [

	| nameDescription |
	model type: (OPUMLClass new
			 name: 'Account';
			 yourself).
	nameDescription := viewModel descriptionName.
	nameDescription accessor write: '   ' to: viewModel.

	self assert: model name equals: 'account'
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
OPUmlClassPropertyViewModelTest >> testDescriptionTypeClearAndReadOnlyForAssociationEnd [

	| description association assocEnd assocEndViewModel |
	description := viewModel descriptionType.
	description accessor write: 'String' to: viewModel.
	self assert: (description accessor read: viewModel) equals: 'String'.

	description accessor write: '' to: viewModel.
	self assert: model type isNil description: 'Writing empty string must clear property type'.
	self assert: (description accessor read: viewModel) equals: ''.

	association := OPUMLAssociation new name: 'Assoc'.
	assocEnd := OPUMLProperty new
		            name: 'endA';
		            association: association;
		            type: (OPUMLClass new
				             name: 'Target';
				             yourself);
		            yourself.
	assocEndViewModel := OPUmlClassPropertyViewModel new model: assocEnd.
	description := assocEndViewModel descriptionType.

	self assert: description isReadOnly description: 'Association end type description must be read-only'.
	description accessor write: 'String' to: assocEndViewModel.
	self assert: assocEnd type name equals: 'Target'
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
OPUmlClassPropertyViewModelTest >> testEstablishedTypeNamesIncludesEnumerations [

	| enumModel names |
	enumModel := OPUMLEnumeration new name: 'OrderStatus'.
	rootModel packagedElements add: enumModel.

	names := viewModel establishedTypeNames.
	self assertCollection: names includesAll: #( 'OrderStatus' 'String' 'Date' )
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testFindParentViewModelCases [

	| detachedViewModel noModelViewModel association assocProperty dataType dataTypeProperty |
	detachedViewModel := OPUmlClassPropertyViewModel new model: model.
	self assert: detachedViewModel findParentViewModel isNil description: 'Detached view model without registry has nil parent'.

	noModelViewModel := OPUmlClassPropertyViewModel new registry: registry.
	self assert: noModelViewModel findParentViewModel isNil description: 'View model without model has nil parent'.

	self assert: viewModel findParentViewModel model identicalTo: parentModel.

	association := OPUMLAssociation new name: 'Assoc'.
	assocProperty := OPUMLProperty new
		                 name: 'endProp';
		                 owningAssociation: association;
		                 yourself.
	rootModel packagedElements add: association.
	self assert: (registry viewModelFor: assocProperty) findParentViewModel model identicalTo: association.

	dataType := OPUMLDataType new name: 'Money'.
	dataTypeProperty := OPUMLProperty new
		                    name: 'amount';
		                    datatype: dataType;
		                    yourself.
	rootModel packagedElements add: dataType.
	self assert: (registry viewModelFor: dataTypeProperty) findParentViewModel model identicalTo: dataType
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testPlaceholderNameCases [

	| propertyViewModel |
	propertyViewModel := OPUmlClassPropertyViewModel new.
	self assert: propertyViewModel placeholderName equals: 'attribute'.

	propertyViewModel model: OPUMLProperty new.
	self assert: propertyViewModel placeholderName equals: 'attribute'.

	propertyViewModel model type: (OPUMLClass new
			 name: '';
			 yourself).
	self assert: propertyViewModel placeholderName equals: 'attribute'.

	propertyViewModel model type: (OPUMLClass new
			 name: 'Order Item';
			 yourself).
	self assert: propertyViewModel placeholderName equals: 'orderItem'.

	propertyViewModel model type: (OPUMLClass new
			 name: 'Customer';
			 yourself).
	self assert: propertyViewModel placeholderName equals: 'customer'
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testPlaceholderNameFallsBackToAttributeForPunctuationOnlyTypeName [

	| property propertyViewModel |
	property := OPUMLProperty new
		            type: (OPUMLClass new
				             name: '---';
				             yourself);
		            yourself.
	propertyViewModel := OPUmlClassPropertyViewModel new model: property.

	self assert: propertyViewModel placeholderName equals: 'attribute'
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
OPUmlClassPropertyViewModelTest >> testTypeCompletionEmptyAndFilterBlock [

	| completion |
	completion := viewModel typeCompletion.
	self assertEmpty: (completion filteredValuesWith: '   ').
	self
		deny: (completion filterBlock value: 'BrandNewTempType' value: 'BrandNewTempType')
		description: 'Exact unestablished temporary token must be filtered out'.
	self
		assert: (completion filterBlock value: 'DateTime' value: 'Date')
		description: 'Established matching candidate must pass filterBlock'
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testTypeNamedCases [

	| primitiveType existingClass createdCustomType reusedCustomType standaloneViewModel standaloneType |
	primitiveType := viewModel typeNamed: 'String'.
	self assert: primitiveType identicalTo: (OPUMLXMISpecsStorage primitivesMap at: 'String').

	existingClass := OPUMLClass new name: 'Invoice'.
	rootModel packagedElements add: existingClass.
	self assert: (viewModel typeNamed: 'Invoice') identicalTo: existingClass.

	createdCustomType := viewModel typeNamed: 'CustomCode'.
	self assert: createdCustomType name equals: 'CustomCode'.
	reusedCustomType := viewModel typeNamed: 'CustomCode'.
	self assert: reusedCustomType identicalTo: createdCustomType.

	standaloneViewModel := OPUmlClassPropertyViewModel new model: OPUMLProperty new.
	standaloneType := standaloneViewModel typeNamed: 'DetachedType'.
	self assert: standaloneType class equals: OPUMLDataType.
	self assert: standaloneType name equals: 'DetachedType'
]

{ #category : 'tests' }
OPUmlClassPropertyViewModelTest >> testTypeNamedReusesCanonicalTypeWhenLazilyCreatingCommonTypesPackage [

	| bareProject barePackage ownerClass property bareRegistry propertyViewModel resolvedType commonTypesPackage |
	bareProject := OPProject named: 'BareProject'.
	barePackage := OPUMLPackage new name: 'BareRoot'.
	ownerClass := OPUMLClass new name: 'Event'.
	property := OPUMLProperty new name: 'createdAt'.
	ownerClass ownedAttributes add: property.
	barePackage packagedElements add: ownerClass.
	bareProject addModel: barePackage.
	bareRegistry := OPViewModelRegistry forProject: bareProject.

	propertyViewModel := bareRegistry viewModelFor: property.
	resolvedType := propertyViewModel typeNamed: 'Date'.
	self assert: resolvedType name equals: 'Date'.
	commonTypesPackage := barePackage packagedElements detect: [ :each |
		                      (each oclIsKindOf: #Package) and: [ each name = OPUmlCommonTypesFactory commonTypesPackageName ] ].
	self assert: (commonTypesPackage packagedElements count: [ :each | each name = 'Date' ]) equals: 1
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
