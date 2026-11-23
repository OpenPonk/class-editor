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
		'createdComment',
		'originalComments',
		'viewModelRegistry'
	],
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'executing' }
OPUmlUpdateGeneralizationCommentCommand >> execute [

	| trimmedBody |
	trimmedBody := newBody trim.
	trimmedBody ifEmpty: [
			generalization ownedComments copy do: [ :eachComment | eachComment annotatedElements remove: generalization ifAbsent: [ ] ].
			generalization ownedComments removeAll.
			self notifyGeneralization.
			^ self ].
	generalization ownedComments ifEmpty: [
			createdComment ifNil: [ createdComment := OPUMLComment new ].
			createdComment annotatedElements addIfNotPresent: generalization.
			generalization ownedComments add: createdComment ].
	generalization ownedComments first body: trimmedBody.
	self notifyGeneralization
]

{ #category : 'initialization' }
OPUmlUpdateGeneralizationCommentCommand >> generalization: aGeneralization commentText: aString [

	generalization := aGeneralization.
	originalComments := generalization ownedComments asArray.
	oldBody := originalComments ifEmpty: [ '' ] ifNotEmpty: [ :comments | (comments first body ifNil: [ '' ]) asString ].
	newBody := aString ifNil: [ '' ]
]

{ #category : 'executing' }
OPUmlUpdateGeneralizationCommentCommand >> notifyGeneralization [

	viewModelRegistry ifNil: [ ^ self ].
	(viewModelRegistry hasViewModelFor: generalization) ifTrue: [ (viewModelRegistry viewModelFor: generalization) modelChanged ]
]

{ #category : 'executing' }
OPUmlUpdateGeneralizationCommentCommand >> undo [

	oldBody trim ifEmpty: [
			generalization ownedComments copy do: [ :eachComment | eachComment annotatedElements remove: generalization ifAbsent: [ ] ].
			generalization ownedComments removeAll.
			self notifyGeneralization.
			^ self ].
	generalization ownedComments copy do: [ :eachComment | eachComment annotatedElements remove: generalization ifAbsent: [ ] ].
	generalization ownedComments removeAll.
	originalComments do: [ :eachComment | eachComment annotatedElements addIfNotPresent: generalization ].
	generalization ownedComments addAll: originalComments.
	generalization ownedComments first body: oldBody.
	self notifyGeneralization
]

{ #category : 'accessing' }
OPUmlUpdateGeneralizationCommentCommand >> viewModelRegistry: aRegistry [

	viewModelRegistry := aRegistry
]
