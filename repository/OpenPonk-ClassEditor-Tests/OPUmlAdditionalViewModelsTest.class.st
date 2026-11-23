"
Unit tests for auxiliary UML view models including constraints, data types, extensions, operations, and enumeration literals.
"
Class {
	#name : 'OPUmlAdditionalViewModelsTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'tests' }
OPUmlAdditionalViewModelsTest >> testConstraintViewModelMetadataAndRemoval [

	| testProject rootPackage constraint testRegistry constraintViewModel |
	self assert: OPUmlConstraintViewModel modelClass equals: OPUMLConstraint.

	testProject := OPProject new.
	rootPackage := OPUMLPackage new name: 'Root'.
	constraint := OPUMLConstraint new name: 'Inv'.
	rootPackage packagedElements add: constraint.
	testProject addModel: rootPackage.
	testRegistry := OPViewModelRegistry forProject: testProject.
	constraintViewModel := testRegistry viewModelFor: constraint.

	self assert: constraintViewModel icon bits equals: OPUmlIcons constraintIcon bits.
	constraintViewModel removeModel.
	self assertEmpty: rootPackage packagedElements
]

{ #category : 'tests' }
OPUmlAdditionalViewModelsTest >> testDataTypeViewModelMetadataAndIsSystemElement [

	| testProject commonPackage dataType detachedDataType testRegistry dataTypeViewModel detachedViewModel |
	self assert: OPUmlDataTypeViewModel modelClass equals: OPUMLDataType.

	testProject := OPProject new.
	commonPackage := OPUMLPackage new name: OPUmlCommonTypesFactory commonTypesPackageName.
	dataType := OPUMLDataType new name: OPUmlCommonTypesFactory typeNames anyOne.
	commonPackage packagedElements add: dataType.
	testProject addModel: commonPackage.
	testRegistry := OPViewModelRegistry forProject: testProject.

	detachedDataType := OPUMLDataType new name: 'Date'.
	detachedViewModel := testRegistry viewModelFor: detachedDataType.
	self assert: detachedViewModel icon bits equals: OPUmlIcons dataTypeIcon bits.
	self deny: detachedViewModel isSystemElement description: 'Detached DataType without parent is not a system element'.

	dataTypeViewModel := testRegistry viewModelFor: dataType.
	self assert: dataTypeViewModel isSystemElement description: 'DataType inside system CommonTypes package is a system element'.
	dataTypeViewModel removeModel.
	self assertEmpty: commonPackage packagedElements
]

{ #category : 'tests' }
OPUmlAdditionalViewModelsTest >> testEnumerationLiteralViewModelValidation [

	| nilModelViewModel unownedViewModel |
	nilModelViewModel := OPUmlEnumerationLiteralViewModel new.
	nilModelViewModel validate.

	unownedViewModel := OPUmlEnumerationLiteralViewModel new model: (OPUMLEnumerationLiteral new
			                     name: 'OrphanLit';
			                     yourself).
	self should: [ unownedViewModel validate ] raise: OPModelInvalid
]

{ #category : 'tests' }
OPUmlAdditionalViewModelsTest >> testExtensionViewModelModelTargetEdgeCases [

	| extension extensionViewModel ownedEnd |
	extension := OPUMLExtension new.
	extensionViewModel := OPUmlExtensionViewModel new model: extension.

	self assert: extensionViewModel modelTarget isNil description: 'Extension with empty memberEnds has nil target'.

	ownedEnd := OPUMLExtensionEnd new
		            name: 'extension_MyStereo';
		            yourself.
	extension ownedEnd: ownedEnd.
	extension memberEnds add: ownedEnd.
	self assert: extensionViewModel modelTarget isNil description: 'Extension with only ownedEnd has nil target'
]

{ #category : 'tests' }
OPUmlAdditionalViewModelsTest >> testOperationViewModelParentPlaceholderAndValidation [

	| testProject rootPackage dataType operation testRegistry operationViewModel nilModelViewModel unownedViewModel |
	testProject := OPProject new.
	rootPackage := OPUMLPackage new name: 'Root'.
	dataType := OPUMLDataType new name: 'Money'.
	operation := OPUMLOperation new
		             name: 'add';
		             datatype: dataType;
		             yourself.
	rootPackage packagedElements add: dataType.
	testProject addModel: rootPackage.
	testRegistry := OPViewModelRegistry forProject: testProject.
	operationViewModel := testRegistry viewModelFor: operation.

	self assert: operationViewModel findParentViewModel model identicalTo: dataType.
	self assert: operationViewModel placeholderName equals: 'operation'.

	nilModelViewModel := OPUmlOperationViewModel new.
	nilModelViewModel validate.

	unownedViewModel := OPUmlOperationViewModel new model: (OPUMLOperation new
			                     name: 'orphanOp';
			                     yourself).
	self should: [ unownedViewModel validate ] raise: OPModelInvalid
]
