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
OPUmlClassifierViewModelTest >> testBasicRemovePackagedModelRemovesFromOwningPackage [

	| testProject rootPackage umlClass testRegistry classViewModel |
	testProject := OPProject new.
	rootPackage := OPUMLPackage new name: 'Root'.
	umlClass := OPUMLClass new name: 'TempClass'.
	rootPackage packagedElements add: umlClass.
	testProject addModel: rootPackage.
	testRegistry := OPViewModelRegistry forProject: testProject.
	classViewModel := testRegistry viewModelFor: umlClass.

	classViewModel removeModel.
	self assertEmpty: rootPackage packagedElements
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
OPUmlClassifierViewModelTest >> testDependentElementsIncludesAssociationsGeneralizationsAndNestedElements [

	| testProject rootPackage subPackage classA classB association generalization testRegistry classViewModel dependents |
	testProject := OPProject new.
	rootPackage := OPUMLPackage new name: 'Root'.
	subPackage := OPUMLPackage new name: 'Sub'.
	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	association := OPUMLAssociation new name: 'Assoc'.
	association memberEnds
		add: (OPUMLProperty new
				 type: classA;
				 owningAssociation: association;
				 association: association;
				 yourself);
		add: (OPUMLProperty new
				 type: classB;
				 owningAssociation: association;
				 association: association;
				 yourself).
	generalization := OPUMLGeneralization new
		                  specific: classB;
		                  general: classA;
		                  yourself.
	classB generalizations add: generalization.
	subPackage packagedElements add: classB.
	subPackage packagedElements add: association.
	rootPackage packagedElements add: classA.
	rootPackage packagedElements add: subPackage.
	testProject addModel: rootPackage.

	testRegistry := OPViewModelRegistry forProject: testProject.
	classViewModel := testRegistry viewModelFor: classA.
	dependents := classViewModel dependentElements.

	self assertCollection: dependents includesAll: {
			association.
			generalization }
]

{ #category : 'tests' }
OPUmlClassifierViewModelTest >> testDependentElementsTraversesOwnedElements [

	| testProject rootPackage targetClass nestedClass ownedGeneralization testRegistry targetViewModel |
	testProject := OPProject named: 'OwnedElementsDeps'.
	rootPackage := OPUMLPackage new name: 'Root'.
	targetClass := OPUMLClass new name: 'Target'.
	nestedClass := OPUMLClass new name: 'Nested'.
	nestedClass owner: rootPackage.
	ownedGeneralization := OPUMLGeneralization new
		                       general: targetClass;
		                       specific: nestedClass;
		                       yourself.
	ownedGeneralization owner: nestedClass.
	rootPackage packagedElements add: targetClass.
	testProject addModel: rootPackage.
	testRegistry := OPViewModelRegistry forProject: testProject.

	targetViewModel := testRegistry viewModelFor: targetClass.
	self assertCollection: targetViewModel dependentElements includesAll: { ownedGeneralization }
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

{ #category : 'tests' }
OPUmlClassifierViewModelTest >> testValidateChecksOwnedAttributes [

	| umlClass association invalidProperty classViewModel warnings |
	umlClass := OPUMLClass new name: 'BrokenClass'.
	association := OPUMLAssociation new name: 'Assoc'.
	invalidProperty := OPUMLProperty new
		                   name: 'brokenAttr';
		                   owningClass: umlClass;
		                   association: association;
		                   yourself.
	umlClass attributes add: invalidProperty.
	classViewModel := OPUmlClassViewModel new model: umlClass.
	warnings := OrderedCollection new.

	[ classViewModel validate ]
		on: OPModelInvalid
		do: [ :warning |
				warnings add: warning messageText.
				warning resume ].

	self assert: warnings size equals: 1
]
