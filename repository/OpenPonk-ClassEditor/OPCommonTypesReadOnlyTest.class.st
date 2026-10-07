Class {
	#name : 'OPCommonTypesReadOnlyTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'package',
		'commonPackage',
		'dataType',
		'projectController',
		'diagramController'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPCommonTypesReadOnlyTest >> setUp [
	super setUp.
	project := OPProject new.
	package := OPUmlClassEditorPlugin new newModel.
	project addModel: package.
	commonPackage := package packagedElements detect: [ :each | each name = 'CommonTypes' ].
	dataType := commonPackage packagedElements detect: [ :each | each name = 'Number' ].

	projectController := OPProjectController new project: project; yourself.
	diagramController := OPUmlPackageDiagramController new
		projectController: projectController;
		model: package;
		yourself
]

{ #category : 'running' }
OPCommonTypesReadOnlyTest >> tearDown [
	project := nil.
	package := nil.
	commonPackage := nil.
	dataType := nil.
	projectController := nil.
	diagramController := nil.
	super tearDown
]

{ #category : 'tests' }
OPCommonTypesReadOnlyTest >> testCommonTypesCannotBeRemovedFromProjectTree [
	| reg commonPackageViewModel dataTypeViewModel command contextStub |
	reg := projectController viewModelRegistry.
	commonPackageViewModel := reg viewModelFor: commonPackage.
	dataTypeViewModel := reg viewModelFor: dataType.

	command := OPRemoveModelCommand new.
	contextStub := Mock new.
	command context: contextStub.

	contextStub stub selectedItem willReturn: commonPackageViewModel.
	self deny: command canBeExecuted description: 'Remove command must not be executable for CommonTypes package'.

	contextStub stub selectedItem willReturn: dataTypeViewModel.
	self deny: command canBeExecuted description: 'Remove command must not be executable for CommonTypes data types'
]

{ #category : 'tests' }
OPCommonTypesReadOnlyTest >> testCommonTypesHasNoSupportInDiagramController [
	self deny: (diagramController hasSupportForModel: commonPackage)
		description: 'Diagram controller must not support CommonTypes package'.
	self deny: (diagramController allModelElementsWithPossibleController includes: commonPackage)
		description: 'CommonTypes package must not appear in allModelElementsWithPossibleController'
]

{ #category : 'tests' }
OPCommonTypesReadOnlyTest >> testUserPackageNamedCommonTypesWithEnumerationIsSupportedInDiagram [
	| userPackage enumeration userPackageViewModel enumerationViewModel |
	userPackage := OPUMLPackage new name: 'CommonTypes'.
	enumeration := OPUMLEnumeration new name: 'CustomerStatus'.
	userPackage packagedElements add: enumeration.
	package packagedElements add: userPackage.

	userPackageViewModel := projectController viewModelRegistry viewModelFor: userPackage.
	enumerationViewModel := projectController viewModelRegistry viewModelFor: enumeration.

	self deny: userPackageViewModel isSystemElement
		description: 'User package named CommonTypes containing non-standard types must not be treated as system element'.
	self deny: enumerationViewModel isSystemElement
		description: 'Enumeration inside user package must not be treated as system element'.

	self assert: (diagramController hasSupportForModel: userPackage)
		description: 'User package named CommonTypes must be supported in diagram controller'.
	self assert: (diagramController hasSupportForModel: enumeration)
		description: 'Enumeration inside user package must be supported in diagram controller'
]
