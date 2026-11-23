"
Tests transactional execution, undo, redo, comment preservation, and view model notifications for generalization comment updates.
"
Class {
	#name : 'OPUmlUpdateGeneralizationCommentCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'generalization',
		'projectController'
	],
	#category : 'OpenPonk-ClassEditor-Tests-Commands',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Commands'
}

{ #category : 'running' }
OPUmlUpdateGeneralizationCommentCommandTest >> setUp [

	| project package classGeneral classSpecific |
	super setUp.
	project := OPProject named: 'CommentCommandTestProject'.
	package := OPUMLPackage new
		           name: 'TestPackage';
		           yourself.
	classGeneral := OPUMLClass new
		                name: 'GeneralClass';
		                yourself.
	classSpecific := OPUMLClass new
		                 name: 'SpecificClass';
		                 yourself.
	package packagedElements
		add: classGeneral;
		add: classSpecific.
	generalization := OPUMLGeneralization new
		                  general: classGeneral;
		                  specific: classSpecific;
		                  yourself.
	classSpecific generalizations add: generalization.
	project addModel: package.
	projectController := OPProjectController forProject: project
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationCommentCommandTest >> testAddNewCommentUndoAndRedoReusesCommentAndCleansAnnotatedElements [

	| command createdComment |
	command := OPUmlUpdateGeneralizationCommentCommand new generalization: generalization commentText: '  First comment  '.

	command execute.
	self assert: generalization ownedComments size equals: 1.
	createdComment := generalization ownedComments first.
	self assert: createdComment body equals: 'First comment'.
	self assertCollection: createdComment annotatedElements hasSameElements: { generalization }.

	command undo.
	self assertEmpty: generalization ownedComments.
	self assertEmpty: createdComment annotatedElements.

	command execute.
	self assert: generalization ownedComments size equals: 1.
	self assert: generalization ownedComments first identicalTo: createdComment.
	self assertCollection: createdComment annotatedElements hasSameElements: { generalization }.

	command undo.
	self assertEmpty: generalization ownedComments.
	self assertEmpty: createdComment annotatedElements
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationCommentCommandTest >> testClearCommentUndoRedoUndoPreservesOriginalCommentAndAnnotatedElements [

	| originalComment command |
	originalComment := OPUMLComment new
		                   body: '  Original body  ';
		                   yourself.
	originalComment annotatedElements add: generalization.
	generalization ownedComments add: originalComment.

	command := OPUmlUpdateGeneralizationCommentCommand new generalization: generalization commentText: '   '.

	command execute.
	self assertEmpty: generalization ownedComments.
	self assertEmpty: originalComment annotatedElements.

	command undo.
	self assert: generalization ownedComments size equals: 1.
	self assert: generalization ownedComments first identicalTo: originalComment.
	self assert: originalComment body equals: '  Original body  '.
	self assertCollection: originalComment annotatedElements hasSameElements: { generalization }.

	command execute.
	self assertEmpty: generalization ownedComments.
	self assertEmpty: originalComment annotatedElements.

	command undo.
	self assert: generalization ownedComments size equals: 1.
	self assert: generalization ownedComments first identicalTo: originalComment.
	self assert: originalComment body equals: '  Original body  '.
	self assertCollection: originalComment annotatedElements hasSameElements: { generalization }
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationCommentCommandTest >> testCommentWithNilBodyIsTreatedAsEmpty [

	| nilBodyComment command |
	nilBodyComment := OPUMLComment new.
	nilBodyComment annotatedElements add: generalization.
	generalization ownedComments add: nilBodyComment.

	command := OPUmlUpdateGeneralizationCommentCommand new generalization: generalization commentText: 'New note'.
	command execute.
	self assert: generalization ownedComments first body equals: 'New note'.

	command undo.
	self assertEmpty: generalization ownedComments.
	self assertEmpty: nilBodyComment annotatedElements
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationCommentCommandTest >> testExecuteAndUndoHandleOwnedCommentWithoutGeneralizationInAnnotatedElements [

	| orphanComment clearCommand updateCommand createCommand |
	orphanComment := OPUMLComment new
		                 body: 'Existing';
		                 yourself.
	generalization ownedComments add: orphanComment.
	clearCommand := OPUmlUpdateGeneralizationCommentCommand new generalization: generalization commentText: ''.
	clearCommand execute.
	self assertEmpty: generalization ownedComments.

	clearCommand undo.
	self assert: generalization ownedComments size equals: 1.
	orphanComment annotatedElements remove: generalization ifAbsent: [ ].
	updateCommand := OPUmlUpdateGeneralizationCommentCommand new generalization: generalization commentText: 'Updated'.
	updateCommand execute.
	generalization ownedComments first annotatedElements remove: generalization ifAbsent: [ ].
	updateCommand undo.
	self assert: generalization ownedComments first body equals: 'Existing'.

	generalization ownedComments removeAll.
	createCommand := OPUmlUpdateGeneralizationCommentCommand new generalization: generalization commentText: 'Fresh'.
	createCommand execute.
	generalization ownedComments first annotatedElements remove: generalization ifAbsent: [ ].
	createCommand undo.
	self assertEmpty: generalization ownedComments
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationCommentCommandTest >> testExecuteAndUndoNotifyViewModelRegistry [

	| generalizationViewModel changeCount command |
	generalizationViewModel := projectController viewModelRegistry viewModelFor: generalization.
	changeCount := 0.
	generalizationViewModel announcer when: OPModelChanged do: [ changeCount := changeCount + 1 ] for: self.

	command := OPUmlUpdateGeneralizationCommentCommand new
		           viewModelRegistry: projectController viewModelRegistry;
		           generalization: generalization commentText: 'Documented';
		           yourself.
	command execute.
	self assert: changeCount equals: 1.

	command undo.
	self assert: changeCount equals: 2.

	command execute.
	self assert: changeCount equals: 3
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationCommentCommandTest >> testNilCommentTextClearsExistingComment [

	| existingComment command |
	existingComment := OPUMLComment new
		                   body: 'Existing';
		                   yourself.
	existingComment annotatedElements add: generalization.
	generalization ownedComments add: existingComment.

	command := OPUmlUpdateGeneralizationCommentCommand new generalization: generalization commentText: nil.
	command execute.
	self assertEmpty: generalization ownedComments.
	self assertEmpty: existingComment annotatedElements.

	command undo.
	self assert: generalization ownedComments size equals: 1.
	self assert: generalization ownedComments first identicalTo: existingComment.
	self assert: existingComment body equals: 'Existing'
]
