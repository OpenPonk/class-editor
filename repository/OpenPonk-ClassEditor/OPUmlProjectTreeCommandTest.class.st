Class {
	#name : 'OPUmlProjectTreeCommandTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testExportUmlPackageCommandHasSaveAsIcon [
	| exportCommand specCommand |
	exportCommand := OPExportUmlPackageCommand new.
	specCommand := exportCommand asSpecCommand.
	self assert: specCommand iconName equals: #smallSaveAs
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testGenerateUmlProfileCommandHasConfigurationIcon [
	| generateCommand specCommand |
	generateCommand := OPGenerateUmlProfileCommand new.
	specCommand := generateCommand asSpecCommand.
	self assert: specCommand iconName equals: #smallConfiguration
]

{ #category : 'tests' }
OPUmlProjectTreeCommandTest >> testImportUmlPackageCommandHasOpenIcon [
	| importCommand specCommand |
	importCommand := OPImportUmlPackageCommand new.
	specCommand := importCommand asSpecCommand.
	self assert: specCommand iconName equals: #smallOpen
]
