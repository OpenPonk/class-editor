Class {
	#name : 'OPImportUmlPackageCommand',
	#superclass : 'OPProjectTreeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-ProjectTree',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-ProjectTree'
}

{ #category : 'as yet unclassified' }
OPImportUmlPackageCommand >> canBeExecuted [
	self selectedViewModel ifNil: [ ^ false ].
	^ self selectedViewModel isKindOf: OPUmlPackageViewModel
]

{ #category : 'as yet unclassified' }
OPImportUmlPackageCommand >> execute [
	OPUmlClassEditorPlugin importToPackage: self selectedViewModel model
]

{ #category : 'as yet unclassified' }
OPImportUmlPackageCommand >> initialize [
	super initialize.
	self name: 'Import from XMI...'
]
