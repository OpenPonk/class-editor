Class {
	#name : 'OPExportUmlPackageCommand',
	#superclass : 'OPProjectTreeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-ProjectTree',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-ProjectTree'
}

{ #category : 'as yet unclassified' }
OPExportUmlPackageCommand >> canBeExecuted [
	self selectedViewModel ifNil: [ ^ false ].
	^ self selectedViewModel isKindOf: OPUmlPackageViewModel
]

{ #category : 'as yet unclassified' }
OPExportUmlPackageCommand >> execute [
	OPUmlClassEditorPlugin exportPackage: self selectedViewModel model
]

{ #category : 'as yet unclassified' }
OPExportUmlPackageCommand >> initialize [
	super initialize.
	self name: 'Export as XMI...'
]
