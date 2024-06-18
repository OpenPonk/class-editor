Class {
	#name : 'LIVInstanceHistory',
	#superclass : 'Object',
	#instVars : [
		'models',
		'specificationBuilder'
	],
	#category : 'LiveInstanceVisualization-Models',
	#package : 'LiveInstanceVisualization',
	#tag : 'Models'
}

{ #category : 'adding' }
LIVInstanceHistory >> add: aModel [
	models add: aModel.
	aModel history: self
]

{ #category : 'as yet unclassified' }
LIVInstanceHistory >> inNewState: aOneArgBlock [
	^ self newState in: aOneArgBlock
]

{ #category : 'initialization' }
LIVInstanceHistory >> initialize [
	super initialize.
	models := OrderedCollection new
]

{ #category : 'as yet unclassified' }
LIVInstanceHistory >> latest [
	^ models last
]

{ #category : 'accessing' }
LIVInstanceHistory >> models [
	^ models
]

{ #category : 'as yet unclassified' }
LIVInstanceHistory >> newState [
	self models
		ifEmpty: [ self add: LIVInstanceModel new ]
		ifNotEmpty: [ | newModel |
			self latest history: nil.
			newModel := self latest deepCopy.
			self latest history: self.
			self add: newModel ].
	^ self latest
]

{ #category : 'as yet unclassified' }
LIVInstanceHistory >> oldest [
	^ models first
]

{ #category : 'accessing' }
LIVInstanceHistory >> specificationBuilder [
	^ specificationBuilder
]

{ #category : 'accessing' }
LIVInstanceHistory >> specificationBuilder: anObject [
	specificationBuilder := anObject
]
