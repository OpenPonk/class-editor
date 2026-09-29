"
A project tree command that imports a UML package structure into the current project hierarchy.
"
Class {
	#name : 'OPImportUmlPackageCommand',
	#superclass : 'OPProjectTreeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-ProjectTree',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-ProjectTree'
}

{ #category : 'testing' }
OPImportUmlPackageCommand >> canBeExecuted [
	self selectedViewModel ifNil: [ ^ false ].
	^ self selectedViewModel isKindOf: OPUmlPackageViewModel
]

{ #category : 'executing' }
OPImportUmlPackageCommand >> execute [
	OPUmlClassEditorPlugin importToPackage: self selectedViewModel model
]

{ #category : 'accessing' }
OPImportUmlPackageCommand >> iconName [
	"Answer the icon name for importing model elements from an XMI file."
	^ #smallOpen
]

{ #category : 'initialization' }
OPImportUmlPackageCommand >> initialize [
	super initialize.
	self name: 'Import from XMI...'
]
