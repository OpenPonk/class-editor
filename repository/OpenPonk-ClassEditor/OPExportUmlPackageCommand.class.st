"
A project tree command that serializes and exports a selected UML package to an external XMI or project file.
"
Class {
	#name : 'OPExportUmlPackageCommand',
	#superclass : 'OPProjectTreeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-ProjectTree',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-ProjectTree'
}

{ #category : 'testing' }
OPExportUmlPackageCommand >> canBeExecuted [
	self selectedViewModel ifNil: [ ^ false ].
	^ self selectedViewModel isKindOf: OPUmlPackageViewModel
]

{ #category : 'executing' }
OPExportUmlPackageCommand >> execute [
	OPUmlClassEditorPlugin exportPackage: self selectedViewModel model
]

{ #category : 'accessing' }
OPExportUmlPackageCommand >> iconName [
	"Answer the icon name for exporting model elements to an XMI file."
	^ #smallSaveAs
]

{ #category : 'initialization' }
OPExportUmlPackageCommand >> initialize [
	super initialize.
	self name: 'Export as XMI...'
]
