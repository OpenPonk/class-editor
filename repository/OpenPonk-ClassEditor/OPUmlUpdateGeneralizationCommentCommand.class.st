"
I represent an undoable command that updates comments attached to a UML generalization relationship.
"
Class {
	#name : 'OPUmlUpdateGeneralizationCommentCommand',
	#superclass : 'OPCommand',
	#instVars : [
		'generalization',
		'oldBody',
		'newBody',
		'createdComment'
	],
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'execution' }
OPUmlUpdateGeneralizationCommentCommand >> execute [
	newBody trim ifEmpty: [
		generalization ownedComments do: [ :eachComment |
			eachComment annotatedElements remove: generalization ifAbsent: [ ] ].
		generalization ownedComments removeAll.
		^ self ].
	generalization ownedComments ifEmpty: [
		createdComment := OPUMLComment new.
		createdComment annotatedElements add: generalization.
		generalization ownedComments add: createdComment ].
	generalization ownedComments first body: newBody trim
]

{ #category : 'initialization' }
OPUmlUpdateGeneralizationCommentCommand >> generalization: aGeneralization commentText: aString [
	generalization := aGeneralization.
	oldBody := generalization ownedComments
		ifEmpty: [ '' ]
		ifNotEmpty: [ :comments | comments first body asString ].
	newBody := aString ifNil: [ '' ]
]

{ #category : 'execution' }
OPUmlUpdateGeneralizationCommentCommand >> undo [
	oldBody trim ifEmpty: [
		generalization ownedComments do: [ :eachComment |
			eachComment annotatedElements remove: generalization ifAbsent: [ ] ].
		generalization ownedComments removeAll.
		^ self ].
	generalization ownedComments ifEmpty: [
		createdComment ifNil: [
			createdComment := OPUMLComment new.
			createdComment annotatedElements add: generalization ].
		generalization ownedComments add: createdComment ].
	generalization ownedComments first body: oldBody trim
]
