Class {
	#name : 'LIVSlot',
	#superclass : 'Object',
	#instVars : [
		'owningInstance',
		'value',
		'definingFeature'
	],
	#category : 'LiveInstanceVisualization-Models',
	#package : 'LiveInstanceVisualization',
	#tag : 'Models'
}

{ #category : 'accessing' }
LIVSlot >> definingFeature [
	^ definingFeature
]

{ #category : 'accessing' }
LIVSlot >> definingFeature: anObject [
	definingFeature := anObject
]

{ #category : 'accessing' }
LIVSlot >> owningInstance [
	^ owningInstance
]

{ #category : 'accessing' }
LIVSlot >> owningInstance: anObject [
	owningInstance := anObject
]

{ #category : 'accessing' }
LIVSlot >> value [
	^ value
]

{ #category : 'accessing' }
LIVSlot >> value: anObject [
	value := anObject
]
