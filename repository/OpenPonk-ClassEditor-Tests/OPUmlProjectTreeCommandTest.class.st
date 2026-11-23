"
Tests project tree contextual commands specific to UML packages, classes, and associations.
"
Class {
	#name : 'OPUmlProjectTreeCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'preexistingWindows'
	],
	#category : 'OpenPonk-ClassEditor-Tests-Commands-ProjectTree',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Commands-ProjectTree'
}

{ #category : 'running' }
OPUmlProjectTreeCommandTest >> setUp [

	super setUp.
	preexistingWindows := (self currentWorld submorphs select: [ :each | each isSystemWindow ]) asIdentitySet
]

{ #category : 'running' }
OPUmlProjectTreeCommandTest >> tearDown [

	| existing |
	existing := preexistingWindows ifNil: [ IdentitySet new ].
	self currentWorld submorphs copy do: [ :each |
		(each isSystemWindow and: [ (existing includes: each) not ]) ifTrue: [ each delete ] ].
	super tearDown
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testExportUmlPackageCommandCanBeExecutedAndExecuteDelegatesToPlugin [

	| command context classViewModel packageModel packageViewModel exportedPackage |
	command := OPExportUmlPackageCommand new.
	context := Mock new.
	command context: context.

	context stub selectedItem willReturn: nil.
	self deny: command canBeExecuted description: 'Export command must not execute without selection'.

	classViewModel := OPUmlClassViewModel new
		                  model: (OPUMLClass new name: 'C');
		                  yourself.
	context stub selectedItem willReturn: classViewModel.
	self deny: command canBeExecuted description: 'Export command must not execute for non-package selection'.

	packageModel := OPUMLPackage new name: 'Root'.
	packageViewModel := OPUmlPackageViewModel new
		                    model: packageModel;
		                    yourself.
	context stub selectedItem willReturn: packageViewModel.
	self assert: command canBeExecuted description: 'Export command must execute for OPUmlPackageViewModel'.

	(OPUmlClassEditorPlugin stub exportPackage: Any) will: [ :arg | exportedPackage := arg ].
	command execute.
	self assert: exportedPackage identicalTo: packageModel
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testExportUmlPackageCommandHasSaveAsIcon [
	| exportCommand specCommand |
	exportCommand := OPExportUmlPackageCommand new.
	specCommand := exportCommand asSpecCommand.
	self assert: specCommand iconName equals: #smallSaveAs
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testGenerateUmlProfileCommandCanBeExecuted [

	| command context profileViewModel packageViewModel |
	command := OPGenerateUmlProfileCommand new.
	context := Mock new.
	command context: context.
	context stub selectedItem willReturn: nil.
	self deny: command canBeExecuted description: 'Generate Profile command must not execute without selection'.
	packageViewModel := OPUmlPackageViewModel new
		                    model: OPUMLPackage new;
		                    yourself.
	context stub selectedItem willReturn: packageViewModel.
	self deny: command canBeExecuted description: 'Generate Profile command must not execute for non-profile package'.
	profileViewModel := OPUmlProfileViewModel new
		                    model: (OPUMLProfile new
				                     name: 'Pro';
				                     yourself);
		                    yourself.
	context stub selectedItem willReturn: profileViewModel.
	self assert: command canBeExecuted description: 'Generate Profile command must execute for OPUmlProfileViewModel'
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testGenerateUmlProfileCommandExecuteOpensWizard [

	| command context profileViewModel window |
	profileViewModel := OPUmlProfileViewModel new
		                    model: (OPUMLProfile new
				                     name: 'Pro';
				                     yourself);
		                    yourself.
	context := Mock new.
	context stub selectedItem willReturn: profileViewModel.
	command := OPGenerateUmlProfileCommand new.
	command context: context.
	window := command execute.
	[
		self assert: window presenter class identicalTo: OPUmlProfileGeneratorWizard.
		self assert: window presenter prefixInput text equals: 'Pro'.
		self assert: window presenter packageInput text equals: 'Pro-Profile' ] ensure: [ window ifNotNil: [ window close ] ]
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testGenerateUmlProfileCommandHasConfigurationIcon [
	| generateCommand specCommand |
	generateCommand := OPGenerateUmlProfileCommand new.
	specCommand := generateCommand asSpecCommand.
	self assert: specCommand iconName equals: #smallConfiguration
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testImportUmlPackageCommandCanBeExecutedAndExecuteDelegatesToPlugin [

	| command context classViewModel packageModel packageViewModel importedPackage |
	command := OPImportUmlPackageCommand new.
	context := Mock new.
	command context: context.

	context stub selectedItem willReturn: nil.
	self deny: command canBeExecuted description: 'Import command must not execute without selection'.

	classViewModel := OPUmlClassViewModel new
		                  model: (OPUMLClass new name: 'C');
		                  yourself.
	context stub selectedItem willReturn: classViewModel.
	self deny: command canBeExecuted description: 'Import command must not execute for non-package selection'.

	packageModel := OPUMLPackage new name: 'Root'.
	packageViewModel := OPUmlPackageViewModel new
		                    model: packageModel;
		                    yourself.
	context stub selectedItem willReturn: packageViewModel.
	self assert: command canBeExecuted description: 'Import command must execute for OPUmlPackageViewModel'.

	(OPUmlClassEditorPlugin stub importToPackage: Any) will: [ :arg | importedPackage := arg ].
	command execute.
	self assert: importedPackage identicalTo: packageModel
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testImportUmlPackageCommandHasOpenIcon [
	| importCommand specCommand |
	importCommand := OPImportUmlPackageCommand new.
	specCommand := importCommand asSpecCommand.
	self assert: specCommand iconName equals: #smallOpen
]
