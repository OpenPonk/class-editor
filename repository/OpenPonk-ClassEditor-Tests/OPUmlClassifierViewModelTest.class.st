"
Tests hierarchical child model discovery for UML classifier view models, including classes, stereotypes, and enumerations.
"
Class {
	#name : 'OPUmlClassifierViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'tests' }
OPUmlClassifierViewModelTest >> testAbstractClassifierItemViewModelsAreAbstract [

	self
		assert: OPUmlClassifierItemViewModel isAbstract
		description: 'OPUmlClassifierItemViewModel is a base class and must report as abstract'.
	self
		assert: OPUmlClassItemViewModel isAbstract
		description: 'OPUmlClassItemViewModel is a base class and must report as abstract'
]

{ #category : 'tests' }
OPUmlClassifierViewModelTest >> testClassViewModelChildrenModelsIncludesAttributesOperationsAndGeneralizations [

	| umlClass superClass attribute operation generalization classViewModel children |
	umlClass := OPUMLClass new name: 'Order'.
	superClass := OPUMLClass new name: 'Entity'.
	attribute := OPUMLProperty new name: 'total'.
	operation := OPUMLOperation new name: 'submit'.
	generalization := OPUMLGeneralization new
		                  general: superClass;
		                  specific: umlClass;
		                  yourself.
	umlClass ownedAttributes add: attribute.
	umlClass ownedOperations add: operation.
	umlClass generalizations add: generalization.

	classViewModel := OPUmlClassViewModel new model: umlClass.
	children := classViewModel childrenModels.

	self assert: children size equals: 3.
	self assertCollection: children hasSameElements: {
			attribute.
			operation.
			generalization }
]

{ #category : 'tests' }
OPUmlClassifierViewModelTest >> testEnumerationViewModelChildrenModelsIncludesLiteralsAndGeneralizations [

	| enumeration superEnumeration literal generalization enumerationViewModel children |
	enumeration := OPUMLEnumeration new name: 'Status'.
	superEnumeration := OPUMLEnumeration new name: 'BaseStatus'.
	literal := OPUMLEnumerationLiteral new name: 'Open'.
	generalization := OPUMLGeneralization new
		                  general: superEnumeration;
		                  specific: enumeration;
		                  yourself.
	enumeration ownedLiterals add: literal.
	enumeration generalizations add: generalization.

	enumerationViewModel := OPUmlEnumerationViewModel new model: enumeration.
	children := enumerationViewModel childrenModels.

	self assert: children size equals: 2.
	self assertCollection: children hasSameElements: {
			literal.
			generalization }
]

{ #category : 'tests' }
OPUmlClassifierViewModelTest >> testStereotypeViewModelChildrenModelsIncludesAttributesOperationsAndGeneralizations [

	| stereotype superStereotype attribute operation generalization stereotypeViewModel children |
	stereotype := OPUMLStereotype new name: 'Kind'.
	superStereotype := OPUMLStereotype new name: 'Rigid'.
	attribute := OPUMLProperty new name: 'tag'.
	operation := OPUMLOperation new name: 'check'.
	generalization := OPUMLGeneralization new
		                  general: superStereotype;
		                  specific: stereotype;
		                  yourself.
	stereotype ownedAttributes add: attribute.
	stereotype ownedOperations add: operation.
	stereotype generalizations add: generalization.

	stereotypeViewModel := OPUmlStereotypeViewModel new model: stereotype.
	children := stereotypeViewModel childrenModels.

	self assert: children size equals: 3.
	self assertCollection: children hasSameElements: {
			attribute.
			operation.
			generalization }
]
