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
