Class {
	#name : #LIVClassBoxBuilder,
	#superclass : #Object,
	#instVars : [
		'model',
		'baseShape',
		'nameShape'
	],
	#category : 'LiveInstanceVisualization-Inspector-Extensions'
}

{ #category : #shapes }
LIVClassBoxBuilder >> baseShape [
	^ baseShape ifNil: [ baseShape := self newBaseShape ]
]

{ #category : #building }
LIVClassBoxBuilder >> build [
	| el |
	el := baseShape.
	self nameShape owningElement: el.
	^ el
]

{ #category : #initialization }
LIVClassBoxBuilder >> initialize [
	super initialize.
	baseShape := self newBaseShape
]

{ #category : #accessing }
LIVClassBoxBuilder >> model [
	^ model
]

{ #category : #accessing }
LIVClassBoxBuilder >> model: anObject [
	model := anObject.
	self nameShape text: model name
]

{ #category : #shapes }
LIVClassBoxBuilder >> nameShape [
	^ nameShape ifNil: [ nameShape := self newNameShape ]
]

{ #category : #'instance creation' }
LIVClassBoxBuilder >> newBaseShape [
	^ OPUmlClassifierShape new
]

{ #category : #'instance creation' }
LIVClassBoxBuilder >> newNameShape [
	^ OPUmlNameLabel new
		text: #Undefined;
		localStyle: (OPUmlStyle new fontSize: 11);
		yourself
]
