Class {
	#name : 'OPUmlTypeRemovalUndoRedoTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'package',
		'projectController',
		'undoManager'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPUmlTypeRemovalUndoRedoTest >> setUp [
	super setUp.
	project := OPProject new.
	package := OPUmlClassEditorPlugin new newModel.
	project addModel: package.
	projectController := OPProjectController new project: project; yourself.
	undoManager := projectController undoManager
]

{ #category : 'tests' }
OPUmlTypeRemovalUndoRedoTest >> testRemoveClassNilsReferencingPropertiesAndUndoRedoRestores [
	| targetClass userClass prop cmd |
	targetClass := OPUMLClass new name: 'TargetClass'.
	userClass := OPUMLClass new name: 'UserClass'.
	prop := OPUMLProperty new name: 'ref'.
	prop type: targetClass.
	userClass ownedAttributes: { prop }.
	package packagedElements addAll: { targetClass . userClass }.

	cmd := OPRemoveModelElementCommand model: targetClass projectController: projectController.
	undoManager inTransaction: [ undoManager execute: cmd ].

	self assert: prop type isNil.
	self deny: (package packagedElements includes: targetClass).

	undoManager undo.
	self assert: prop type identicalTo: targetClass.
	self assert: (package packagedElements includes: targetClass).

	undoManager redo.
	self assert: prop type isNil.
	self deny: (package packagedElements includes: targetClass)
]

{ #category : 'tests' }
OPUmlTypeRemovalUndoRedoTest >> testRemoveDataTypeNilsReferencingPropertiesAndUndoRedoRestores [
	| commonPkg dataType userClass prop cmd |
	commonPkg := package packagedElements detect: [ :each | each name = 'CommonTypes' ].
	dataType := commonPkg packagedElements detect: [ :each | each name = 'Number' ].

	userClass := OPUMLClass new name: 'Invoice'.
	prop := OPUMLProperty new name: 'total'.
	prop type: dataType.
	userClass ownedAttributes: { prop }.
	package packagedElements add: userClass.

	cmd := OPRemoveModelElementCommand model: dataType projectController: projectController.
	undoManager inTransaction: [ undoManager execute: cmd ].

	self assert: prop type isNil.
	self deny: (commonPkg packagedElements includes: dataType).

	undoManager undo.
	self assert: prop type identicalTo: dataType.
	self assert: (commonPkg packagedElements includes: dataType).

	undoManager redo.
	self assert: prop type isNil.
	self deny: (commonPkg packagedElements includes: dataType)
]

{ #category : 'tests' }
OPUmlTypeRemovalUndoRedoTest >> testRemoveTypeDoesNotAffectUnrelatedProperties [
	| targetClass otherType userClass propTarget propOther cmd |
	targetClass := OPUMLClass new name: 'TargetClass'.
	otherType := OPUMLClass new name: 'OtherClass'.
	userClass := OPUMLClass new name: 'UserClass'.
	propTarget := OPUMLProperty new name: 'targetRef'; type: targetClass.
	propOther := OPUMLProperty new name: 'otherRef'; type: otherType.
	userClass ownedAttributes: { propTarget . propOther }.
	package packagedElements addAll: { targetClass . otherType . userClass }.

	cmd := OPRemoveModelElementCommand model: targetClass projectController: projectController.
	undoManager inTransaction: [ undoManager execute: cmd ].

	self assert: propTarget type isNil.
	self assert: propOther type identicalTo: otherType.

	undoManager undo.
	self assert: propTarget type identicalTo: targetClass.
	self assert: propOther type identicalTo: otherType
]
